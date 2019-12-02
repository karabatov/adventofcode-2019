import strutils
from sequtils import map

let initialTape = readLine(stdin).split(",").map(parseInt)
const answer = 19690720

proc tryRun(startTape: seq[int], noun: int, verb: int): int =
  var tape = startTape
  tape[1] = noun
  tape[2] = verb
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

  return tape[0]

block outer:
  for i in 0..99:
    for j in 0..99:
      if tryRun(initialTape, i, j) == answer:
        echo("Answer: " & $(100 * i + j))
        break outer
