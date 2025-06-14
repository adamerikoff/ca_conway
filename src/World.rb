require_relative 'Cell' # Ensures the 'Cell' class definition is loaded.

# The World class manages the grid of cells and the rules for their evolution
# in Conway's Game of Life.
class World
  # Allows external access to the grid's height, width, and current generation number.
  attr_reader :grid_height, :grid_width, :generation_number

  # Initializes a new World instance.
  #
  # @param grid_height [Integer] The number of rows in the grid.
  # @param grid_width [Integer] The number of columns in the grid.
  # @param initial_state [Symbol, nil] Optional: Specifies the initial setup of the grid.
  #   - `:random`: Cells are randomly set to ALIVE based on `live_cell_density`.
  #   - `nil` (or any other value): All cells start as DEAD.
  # @param live_cell_density [Float] The probability (between 0.0 and 1.0) that a cell
  #   will be initialized as ALIVE when `initial_state` is `:random`. Default is 0.1 (10%).
  def initialize(grid_height, grid_width, initial_state = nil, live_cell_density = 0.1)
    @grid_height = grid_height # Stores the height of the grid.
    @grid_width = grid_width   # Stores the width of the grid.

    # Initialize the generation counter to 0.
    @generation_number = 0

    # Initialize the 2D grid. It's an array of arrays, where each inner array represents a row.
    # Each element in the grid is an instance of the `Cell` class.
    @grid = Array.new(@grid_height) do |y|
      Array.new(@grid_width) do |x|
        # Conditional initialization of cells:
        if initial_state == :random
          # If random initialization is requested, each cell has a `live_cell_density`
          # chance of being ALIVE, otherwise it's DEAD.
          Cell.new(rand < live_cell_density ? Cell::ALIVE : Cell::DEAD)
        else
          # If not random, all cells are initialized as DEAD by default.
          Cell.new(Cell::DEAD)
        end
      end
    end
  end

  # Counts the number of live neighbors for a specific cell at (x, y) coordinates.
  # This implementation uses a **toroidal (wrapped) topology**, meaning the grid
  # wraps around at the edges, like a sphere or donut.
  #
  # @param x [Integer] The column index (horizontal position) of the target cell.
  # @param y [Integer] The row index (vertical position) of the target cell.
  # @return [Integer] The total count of live neighbors for the specified cell.
  def count_neighbors(x, y)
    live_count = 0 # Initialize a counter for live neighbors.

    # Iterate through a 3x3 square centered around the current cell (including the cell itself).
    # `dy` represents the change in the y-coordinate (row).
    # `dx` represents the change in the x-coordinate (column).
    (-1..1).each do |dy|
      (-1..1).each do |dx|
        # Skip the center (dx=0, dy=0) as a cell is not its own neighbor.
        next if dx == 0 && dy == 0

        # Calculate the coordinates of the potential neighbor.
        # Use the modulo operator (%) to implement wrapping (toroidal) boundaries.
        # This means if neighbor_x goes beyond @grid_width, it wraps back to 0,
        # and if it goes below 0, it wraps back to @grid_width - 1.
        # Ruby's % operator handles negative numbers correctly for this purpose.
        neighbor_x = (x + dx) % @grid_width
        neighbor_y = (y + dy) % @grid_height

        # With modulo arithmetic, coordinates are always valid, so no explicit
        # boundary checks are needed here.
        # If the neighbor is alive, increment the count.
        live_count += 1 if @grid[neighbor_y][neighbor_x].alive?
      end
    end
    live_count # Return the final count of live neighbors.
  end

  # Advances the cellular automaton to the next generation.
  # This method applies Conway's Game of Life rules simultaneously to all cells
  # to determine their state in the next generation.
  #
  # The rules are:
  # 1. Any live cell with fewer than two live neighbours dies (underpopulation).
  # 2. Any live cell with two or three live neighbours lives on to the next generation.
  # 3. Any live cell with more than three live neighbours dies (overpopulation).
  # 4. Any dead cell with exactly three live neighbours becomes a live cell (reproduction).
  def step
    # Create a new grid (`new_grid`) to store the state of the cells for the *next* generation.
    # This is crucial to ensure that all cell updates for the current step are based on the
    # state of the *current* generation, preventing cells from influencing each other
    # within the same step.
    new_grid = Array.new(@grid_height) do |y|
      Array.new(@grid_width) do |x|
        Cell.new(Cell::DEAD) # Initialize all cells in the `new_grid` as dead by default.
      end
    end

    # Iterate through each cell in the current grid (`@grid`).
    @grid_height.times do |y|
      @grid_width.times do |x|
        current_cell = @grid[y][x]          # Get the current cell object.
        live_neighbors = count_neighbors(x, y) # Count its live neighbors using the toroidal logic.

        # Apply the Game of Life rules:
        if current_cell.alive? # If the current cell is ALIVE:
          if live_neighbors == 2 || live_neighbors == 3
            new_grid[y][x].revive # Rule 2: It has 2 or 3 neighbors, so it lives.
          else
            new_grid[y][x].kill # Rule 1 & 3: It has <2 or >3 neighbors, so it dies.
          end
        else # If the current cell is DEAD:
          if live_neighbors == 3
            new_grid[y][x].revive # Rule 4: It has exactly 3 neighbors, so it becomes alive.
          else
            new_grid[y][x].kill # It has other than 3 neighbors, so it stays dead.
          end
        end
      end
    end

    # Increment the counter each time a new generation is calculated.
    @generation_number += 1

    # After iterating through all cells and determining their next states,
    # replace the current grid (`@grid`) with the newly calculated `new_grid`.
    # This officially transitions the world to the next generation.
    @grid = new_grid
  end

  # Returns the current status (ALIVE or DEAD) of the cell at the given coordinates.
  # Coordinates are automatically wrapped due to the underlying grid structure.
  #
  # @param x [Integer] The column index of the cell.
  # @param y [Integer] The row index of the cell.
  # @return [Symbol] The status of the cell (`:alive` or `:dead`).
  def get_cell_status(x, y)
    # Use modulo to ensure coordinates wrap around for getting status, just like neighbors.
    wrapped_x = x % @grid_width
    wrapped_y = y % @grid_height
    @grid[wrapped_y][wrapped_x].status
  end

  # Sets the status of the cell at the given coordinates.
  # Coordinates are automatically wrapped to apply changes to the correct cell on the toroidal grid.
  #
  # @param x [Integer] The column index of the cell.
  # @param y [Integer] The row index of the cell.
  # @param status [Symbol] The new status for the cell (`:alive` or `:dead`).
  def set_cell_status(x, y, status)
    # Use modulo to ensure coordinates wrap around for setting status.
    wrapped_x = x % @grid_width
    wrapped_y = y % @grid_height
    @grid[wrapped_y][wrapped_x].status = status
  end

  # Returns the entire 2D grid of `Cell` objects.
  # This method is primarily used by the rendering component (e.g., `GameOfLife` window)
  # to access the current state of all cells for drawing.
  #
  # @return [Array<Array<Cell>>] The 2D array of `Cell` objects.
  def current_grid
    @grid
  end

  # Counts the total number of currently live cells in the grid.
  # This can be useful for statistics or game over conditions.
  #
  # @return [Integer] The total number of live cells.
  def live_cell_count
    # Flatten the 2D grid into a 1D array of cells, then count how many are alive.
    @grid.flatten.count(&:alive?)
  end
end
