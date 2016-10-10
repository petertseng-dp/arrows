require "./src/arrows"

def print_grid(grid : Array(String), points : Set(Point), if_present : Proc(Char, String), if_absent : Proc(Char, String))
  grid.each_with_index { |line, y|
    puts line.chomp.each_char.map_with_index { |c, x|
      points.includes?({y, x}) ? if_present.call(c) : if_absent.call(c)
    }.join
  }
end

if ARGV.empty?
  puts "usage: #{PROGRAM_NAME} input"
  exit(1)
end

raw_lines = File.read_lines(ARGV[0])
grid = raw_lines.map(&.chomp.each_char.map { |c| to_dir(c) }.to_a)
size, points = find_cycle(grid)
points = points.to_set

puts size
puts

print_grid(raw_lines, points, ->(c : Char) { "\e[1;31m#{c}\e[0m" }, ->(c : Char) { c.to_s })
# puts

# print_grid(raw_lines, points, ->(c : Char) { c.to_s }, ->(c : Char) { " " })
