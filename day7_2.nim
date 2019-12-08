import sequtils
import strutils
from algorithm import nextPermutation

let initialTape = readLine(stdin).split(",").map(parseInt)

type
  Stop = object
    pos, output: int
    halt: bool

proc runAmp(tape: var seq[int], position: int, inputs: seq[int]): Stop =
  var inputPos = 0
  var pos = position
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
        let value = inputs[inputPos]
        tape[tape[pos+1]] = value
        inputPos += 1
      # Output
      of 4:
        codelen = 2
        let p1 = if p1mode == 0: tape[pos+1] else: pos+1
        return Stop(pos: pos + codelen, output: tape[p1], halt: false)
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
        return Stop(pos: pos, output: -1, halt: true)
      else:
        echo("You done goofed at pos " & $pos)
        break

    if codelen > 0:
      pos += codelen

var phases = @[5, 6, 7, 8, 9]
var thrusters = 0
while phases.nextPermutation():
  var mem = newSeqWith(phases.len, initialTape)
  var stopPos = newSeqWith(5, 0)
  var started = newSeqWith(5, false)
  var haltCount = 0
  var output = 0
  while haltCount < 5:
    for i in 0..<phases.len:
      var inputs: seq[int]
      if not started[i]:
        inputs.add(phases[i])
        started[i] = true
      inputs.add(output)
      let stop = runAmp(mem[i], stopPos[i], inputs)
      if stop.halt:
        haltCount += 1
      else:
        output = stop.output
        stopPos[i] = stop.pos
  if output > thrusters:
    thrusters = output

echo("Max thrusters: " & $thrusters)
