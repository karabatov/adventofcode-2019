import strutils

type
  Point = object
    x, y: int

proc makePoints(line: seq[string]): seq[Point] =
  result = @[]
  var pos = Point(x: 0, y: 0)
  result.add(pos)
  for i in 0..<line.len:
    var next = line[i]
    let direction = next[0]
    removePrefix(next, direction)
    let amt = parseInt(next)
    case direction:
    of 'R':
      for i in 0..<amt:
        pos.x += 1
        result.add(pos)
    of 'L':
      for i in 0..<amt:
        pos.x -= 1
        result.add(pos)
    of 'U':
      for i in 0..<amt:
        pos.y += 1
        result.add(pos)
    of 'D':
      for i in 0..<amt:
        pos.y -= 1
        result.add(pos)
    else:
      echo("Unknown command: " & $direction)

let wire1 = makePoints(readLine(stdin).split(","))
let wire2 = makePoints(readLine(stdin).split(","))

var closest = high(int)

for i in 0..<wire1.len - 1:
  for j in 0..<wire2.len - 1:
    if wire1[i] == wire2[j]:
      let x = wire1[i].x
      let y = wire1[i].y
      let distance = abs(x) + abs(y)
      if distance < closest and distance > 0:
        closest = distance

echo("Closest intersection distance: " & $closest)
