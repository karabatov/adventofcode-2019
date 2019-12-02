import strutils
from sequtils import map

var tape = readLine(stdin).split(",").map(parseInt)

# “1202 program alarm”
tape[1] = 12
tape[2] = 2

var pos = 0
while true:
  defer:
    pos += 4

  case tape[pos]:
    of 1:
      tape[tape[pos+3]] = tape[tape[pos+1]] + tape[tape[pos+2]]
    of 2:
      tape[tape[pos+3]] = tape[tape[pos+1]] * tape[tape[pos+2]]
    of 99:
      break
    else:
      echo("You done goofed at pos " & $pos)
      break

echo("Pos 0 = " & $tape[0])
