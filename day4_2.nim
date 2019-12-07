import sequtils, strutils

proc checkPassword(pass: int): bool =
  var test = pass
  var doubleNum = -1
  var repeat = false
  var repeatNum = -1
  var prev = -1
  while test > 0:
    defer:
      test = test div 10

    let last = test mod 10

    if prev < 0:
      prev = last
      continue

    if prev < last: return false

    if last == prev:
      if not repeat:
        repeat = true
        repeatNum = last
        if doubleNum < 0:
          doubleNum = last
      else:
        if repeatNum == doubleNum: doubleNum = -1
    else:
      repeat = false

    prev = last
  return doubleNum > 0

let nums = readLine(stdin).split("-").map(parseInt)

var total = 0

for i in nums[0]..nums[1]:
  if checkPassword(i):
    total += 1

echo("Total passwords: " & $total)
