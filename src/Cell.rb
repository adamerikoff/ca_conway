class Cell
  # Define constants for cell states using symbols.
  # Symbols are efficient and commonly used in Ruby for distinct states.
  ALIVE = :alive
  DEAD = :dead

  # This allows you to read and write the @status instance variable
  attr_accessor :status

  # Initialize a new cell. By default, a cell starts as DEAD.
  def initialize(initial_status = DEAD)
    @status = initial_status
  end

  # Helper method to check if the cell is alive
  def alive?
    @status == ALIVE
  end

  # Helper method to check if the cell is dead
  def dead?
    @status == DEAD
  end

  # Methods to change the cell's state
  def revive
    @status = ALIVE
  end

  def kill
    @status = DEAD
  end
end
