import strutils
from sequtils import map

let initialTape = readLine(stdin).split(",").map(parseInt)
let input = 5

var tape = initialTape
var pos = 0
while true:
  var codelen: int
  let instr = tape[pos]
  let opcode = instr mod 100
  let p1mode = (instr div 100) mod 10
  let p2mode = (instr div 1000) mod 10
  # let p3mode = (instr div 10000) mod 10
  case opcode:
    # Add
    of 1:
      codelen = 4
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      tape[tape[pos+3]] = tape[p1] + tape[p2]
    # Multiply
    of 2:
      codelen = 4
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      tape[tape[pos+3]] = tape[p1] * tape[p2]
    # Input
    of 3:
      codelen = 2
      let value = input
      tape[tape[pos+1]] = value
    # Output
    of 4:
      codelen = 2
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      echo($tape[p1])
    # Jump if true
    of 5:
      codelen = 3
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      if tape[p1] > 0:
        codelen = 0
        pos = tape[p2]
    # Jump if false
    of 6:
      codelen = 3
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      if tape[p1] == 0:
        codelen = 0
        pos = tape[p2]
    # Less than
    of 7:
      codelen = 4
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      if tape[p1] < tape[p2]:
        tape[tape[pos+3]] = 1
      else:
        tape[tape[pos+3]] = 0
    # Equals
    of 8:
      codelen = 4
      let p1 = if p1mode == 0: tape[pos+1] else: pos+1
      let p2 = if p2mode == 0: tape[pos+2] else: pos+2
      if tape[p1] == tape[p2]:
        tape[tape[pos+3]] = 1
      else:
        tape[tape[pos+3]] = 0
    # Halt
    of 99:
      break
    else:
      echo("You done goofed at pos " & $pos)
      break

  if codelen > 0:
    pos += codelen
