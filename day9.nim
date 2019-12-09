import sequtils, strutils, tables

let initialTape = readLine(stdin).split(",").map(parseInt)

proc runAmp(firmware: seq[int], inputs: seq[int]): seq[int] =
  var mem = initTable[int, int]()
  for idx, val in firmware:
    mem[idx] = val
  var relBase = 0
  var inputPos = 0
  var pos = 0

  proc getVal(pos: int): int =
    mem.getOrDefault(pos, 0)

  proc setVal(val: int, pos: int) =
    mem[pos] = val

  proc posFromMode(mode: int, offset: int): int =
    return case mode:
      of 0: getVal(pos + offset)
      of 1: pos + offset
      of 2: relBase + getVal(pos + offset)
      else:
        echo("Unexpected mode: " & $mode)
        quit()

  while true:
    var codelen: int
    let instr = getVal(pos)
    let opcode = instr mod 100
    let p1mode = (instr div 100) mod 10
    let p2mode = (instr div 1000) mod 10
    let p3mode = (instr div 10000) mod 10
    let p1 = posFromMode(p1Mode, 1)
    let p2 = posFromMode(p2Mode, 2)
    let p3 = posFromMode(p3Mode, 3)
    case opcode:
      # Add
      of 1:
        codelen = 4
        setVal(getVal(p1) + getVal(p2), p3)
      # Multiply
      of 2:
        codelen = 4
        setVal(getVal(p1) * getVal(p2), p3)
      # Input
      of 3:
        codelen = 2
        let value = inputs[inputPos]
        setVal(value, p1)
        inputPos += 1
      # Output
      of 4:
        codelen = 2
        result.add(getVal(p1))
      # Jump if true
      of 5:
        codelen = 3
        if getVal(p1) > 0:
          codelen = 0
          pos = getVal(p2)
      # Jump if false
      of 6:
        codelen = 3
        if getVal(p1) == 0:
          codelen = 0
          pos = getVal(p2)
      # Less than
      of 7:
        codelen = 4
        if getVal(p1) < getVal(p2):
          setVal(1, p3)
        else:
          setVal(0, p3)
      # Equals
      of 8:
        codelen = 4
        if getVal(p1) == getVal(p2):
          setVal(1, p3)
        else:
          setVal(0, p3)
      # Relative base
      of 9:
        codelen = 2
        relBase += getVal(p1)
      # Halt
      of 99:
        break
      else:
        echo("You done goofed at pos " & $pos & ". Got instr " & $instr)
        quit()

    if codelen > 0:
      pos += codelen

# Part 1 inputs: @[1]
let inputs = @[2]
let outputs = runAmp(initialTape, inputs)
echo(outputs.mapIt(intToStr(it)).join(","))
