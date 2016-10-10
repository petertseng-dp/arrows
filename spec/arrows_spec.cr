require "spec"
require "../src/arrows"

describe "Arrows" do
  it "works on large grid" do
    input = "^^v>>v^>>v<<<v>v<>>>>>>>>^vvv^^vvvv<v^^><^^v>
>><<>vv<><<<^><^<^v^^<vv>>^v<v^vv^^v<><^>><v<
vv<^v<v<v<vvv>v<v<vv<^<v<<<<<<<<^<><>^><^v>>>
<v<v^^<v<>v<>v<v<^v^>^<^<<v>^v><^v^>>^^^<><^v
^>>>^v^v^<>>vvv>v^^<^<<<><>v>>^v<^^<>v>>v<v>^
^^^<<^<^>>^v>>>>><>>^v<^^^<^^v^v<^<v^><<^<<<>
v<>v^vv^v<><^>v^vv>^^v^<>v^^^>^>vv<^<<v^<<>^v
<<<<<^<vv<^><>^^>>>^^^^<^<^v^><^v^v>^vvv>^v^^
<<v^<v<<^^v<>v>v^<<<<<>^^v<v^>>>v^><v^v<v^^^<
^^>>^<vv<vv<>v^<^<^^><><^vvvv<<v<^<<^>^>vv^<v
^^v^>>^>^<vv^^<>>^^v>v>>v>>v^vv<vv^>><>>v<<>>
^v<^v<v>^^<>>^>^>^^v>v<<<<<>><><^v<^^v><v>^<<
v>v<><^v<<^^<^>v>^><^><v^><v^^^>><^^<^vv^^^>^
v><>^><vv^v^^>><>^<^v<^><v>^v^<^<>>^<^vv<v>^v
><^<v>>v>^<<^>^<^^>v^^v<>>v><<>v<<^><<>^>^v<v
>vv>^>^v><^^<v^>^>v<^v><>vv>v<^><<<<v^<^vv<>v
<><<^^>>^<>vv><^^<vv<<^v^v^<^^^^vv<<>^<vvv^vv
>v<<v^><v<^^><^v^<<<>^<<vvvv^^^v<<v>vv>^>>^<>
^^^^<^<>^^vvv>v^<<>><^<<v>^<<v>>><>>><<^^>vv>
<^<^<>vvv^v><<<vvv<>>>>^<<<^vvv>^<<<^vv>v^><^
"

    grid = input.lines.map(&.chomp.each_char.map { |c| to_dir(c) }.to_a)
    size, points = find_cycle(grid)
    points.size.should eq(size)
    size.should eq(44)
  end
end
