require 'gosu' # Imports the Gosu 2D game development library.
require_relative 'Cell' # Imports the custom Cell class from 'Cell.rb'.
require_relative 'World' # Imports the custom World class from 'World.rb'.

# The main game window class, inheriting from Gosu::Window.
class GameOfLife < Gosu::Window
  # --- Configuration Constants ---
  # These constants define the grid's dimensions and how large each cell appears on screen.
  GRID_WIDTH = 150    # Number of cells horizontally in the Game of Life grid.
  GRID_HEIGHT = 150   # Number of cells vertically in the Game of Life grid.

  CELL_SIZE = 5       # The size (in screen pixels) of each individual cell when drawn.
                      # A CELL_SIZE of 1 would mean each cell is one screen pixel.

  # Window dimensions calculation: The total width/height of the Gosu window.
  # This scales the logical grid dimensions by the CELL_SIZE.
  WINDOW_WIDTH = GRID_WIDTH * CELL_SIZE
  WINDOW_HEIGHT = GRID_HEIGHT * CELL_SIZE

  # --- Initialization Method ---
  # This method is called once when the game starts.
  def initialize
    # Call the constructor of the parent class (Gosu::Window) to create the window.
    # It sets the window's dimensions and whether it's fullscreen (false in this case).
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    # Set the title displayed in the window's title bar.
    self.caption = "Conway's Game of Life CELLULAR AUTOMATA"

    # Create an instance of our custom World class.
    # The World manages the 2D array of Cell objects and the Game of Life logic.
    # :random as the third argument tells the World to initialize with some live cells.
    @world = World.new(GRID_HEIGHT, GRID_WIDTH, :random)

    # --- New: Font for Displaying Generation Number ---
    # Create a Gosu::Font object for rendering text.
    # Arguments: (size, options hash)
    # The font size is set to 20 pixels. Gosu uses a default font if not specified.
    @font = Gosu::Font.new(20)
  end

  # --- Update Method ---
  # This method is called repeatedly by Gosu, typically 60 times per second (frames per second).
  # It contains the game's core logic and updates the state of the world.
  def update
    # Advance the Game of Life world to its next generation.
    # This applies the rules of Conway's Game of Life to all cells.
    @world.step
  end

  # --- Draw Method ---
  # This method is called repeatedly by Gosu, responsible for rendering everything to the screen.
  # It should only contain drawing commands.
  def draw
    # Iterate through each row and column of the current Game of Life grid.
    # @world.current_grid returns the 2D array of Cell objects.
    @world.current_grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        # Determine the color of the current cell based on its status.
        color = if cell.alive?
                  Gosu::Color::WHITE # If the cell is alive, draw it white.
                else
                  Gosu::Color::BLACK # If the cell is dead, draw it black.
                end

        # Calculate the top-left screen coordinates for where this cell should be drawn.
        # Multiply the grid (x, y) by CELL_SIZE to get screen pixels.
        screen_x = x * CELL_SIZE
        screen_y = y * CELL_SIZE

        # Draw a solid rectangle for the current cell.
        # Arguments: (x, y, width, height, color, z_order)
        # - screen_x, screen_y: Top-left corner on the screen.
        # - CELL_SIZE, CELL_SIZE: The width and height of the rectangle (ensuring it's square).
        # - color: The determined Gosu::Color object.
        # - 0: The Z-order, determining layering (0 means "bottom" layer).
        # Using Gosu.draw_rect for each cell ensures **crisp, non-blurry pixels**
        # because it draws basic shapes directly, without the texture scaling/filtering
        # issues encountered with Gosu::Image.from_blob in older Gosu versions.
        Gosu.draw_rect(screen_x, screen_y, CELL_SIZE, CELL_SIZE, color, 0)
      end
    end

    # --- New: Draw Generation Number and Cell count---
    # Create the text string to display.
    generation_text = "G: #{@world.generation_number}\nCC: #{@world.live_cell_count}"

    # Draw the text on the screen using the @font object.
    # Arguments: (text, x, y, z_order, scale_x, scale_y, color)
    # - 5, 5: X and Y coordinates (a small offset from the top-left corner).
    # - 1: Z-order (making sure the text appears on top of the grid, which is at Z-order 0).
    # - 1.0, 1.0: Scaling factors (no scaling for the text itself).
    # - Gosu::Color::RED: The color of the text (you can change this).
    @font.draw_text(generation_text, 0, 0, 1, 1.0, 1.0, Gosu::Color::RED)
  end

  # --- Button Down Event Handler ---
  # This method is called by Gosu whenever a button (keyboard key or mouse button) is pressed.
  # @param id [Integer] The ID of the button that was pressed (e.g., Gosu::MS_LEFT, Gosu::KB_ESCAPE).
  def button_down(id)
    case id
    when Gosu::MS_LEFT # Check if the left mouse button was clicked.
      # Convert the mouse's screen coordinates (mouse_x, mouse_y) to grid coordinates.
      # Dividing by CELL_SIZE maps screen pixels back to grid cells.
      grid_x = mouse_x / CELL_SIZE
      grid_y = mouse_y / CELL_SIZE

      # Ensure the calculated grid coordinates are within the actual grid boundaries.
      if grid_x >= 0 && grid_x < GRID_WIDTH && grid_y >= 0 && grid_y < GRID_HEIGHT
        # Get the current status of the clicked cell from the World.
        current_status = @world.get_cell_status(grid_x, grid_y)

        # Toggle the cell's status (alive to dead, or dead to alive).
        if current_status == Cell::ALIVE
          @world.set_cell_status(grid_x, grid_y, Cell::DEAD)
        else
          @world.set_cell_status(grid_x, grid_y, Cell::ALIVE)
        end
        # IMPORTANT: Since we're drawing directly with Gosu.draw_rect,
        # changes to @world.get_cell_status/@world.set_cell_status will be
        # automatically reflected in the next 'draw' call. No manual image
        # regeneration or buffer swapping is needed here for the click to appear.
      end
    when Gosu::KB_ESCAPE # Check if the Escape key was pressed.
      close # Close the game window.
    end
  end
end

# --- Game Start ---
# Create a new instance of the GameOfLife window and start the game loop.
# The 'show' method makes the window visible and begins calling 'update' and 'draw' automatically.
GameOfLife.new.show
