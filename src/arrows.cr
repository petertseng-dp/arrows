enum Direction : UInt8
  Up
  Down
  Left
  Right
end

def to_dir(c : Char) : Direction
  case c
  when '^'; Direction::Up
  when '>'; Direction::Right
  when '<'; Direction::Left
  when 'v'; Direction::Down
  else      raise "Invalid direction #{c}"
  end
end

# !!! I would like to make these uints, but then wrapping logic is harder.
# I let points temporarily take on negative values and then mod them.
alias Point = Tuple(Int32, Int32)

def move(pos : Point, dir : Direction) : Point
  y, x = pos
  case dir
  when Direction::Up   ; {y - 1, x}
  when Direction::Down ; {y + 1, x}
  when Direction::Left ; {y, x - 1}
  when Direction::Right; {y, x + 1}
  else
    # !!! I don't like that this is necessary.
    # Is there a keyword to say these are all the values of Direction?
    raise "Invalid direction #{dir}"
  end
end

def bound(pos : Point, bounds : Point) : Point
  yp, xp = pos
  yb, xb = bounds
  {yp % yb, xp % xb}
end

# !!! I would like to make the length a uint, actually.
# However, Array#size is an Int32 (and the compiler can't prove that size - index > 0)
def find_cycle(grid : Array(Array(Direction))) : Tuple(Int32, Array(Point))
  cols = grid[0].size
  bounds = {grid.size, cols}

  unmarked_points = Set.new(grid.each_with_index.flat_map { |row, y|
    raise "Uneven board: row 0 size #{cols}, row #{y} size #{row} " unless row.size == cols
    (0...row.size).map { |x| {y, x} }
  })

  max_length = 0
  max_points = [] of Point

  unmarked_points.each { |pos|
    marked_here = [] of Point

    current_pos = pos
    while unmarked_points.includes?(current_pos)
      marked_here << current_pos
      # Warning: modification of set while iterating over it.
      # (Crystal handles this just fine as of this writing)
      unmarked_points.delete(current_pos)
      y, x = current_pos
      current_pos = bound(move(current_pos, grid[y][x]), bounds)
    end

    if (index = marked_here.index(current_pos))
      this_length = marked_here.size - index
      if this_length > max_length
        max_length = this_length
        max_points = marked_here[index..-1]
      end
    end
  }

  {max_length, max_points}
end
