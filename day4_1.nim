import sequtils, strutils

proc checkPassword(pass: int): bool =
  var test = pass
  var double = false
  var prev = -1
  while test > 0:
    let last = test mod 10
    if prev < 0:
      prev = last
    else:
      if last == prev: double = true
      if prev < last: return false
      prev = last
    test = test div 10
  return double

let nums = readLine(stdin).split("-").map(parseInt)

var total = 0

for i in nums[0]..nums[1]:
  if checkPassword(i):
    total += 1

echo("Total passwords: " & $total)
