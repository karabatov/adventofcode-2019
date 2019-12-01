import strutils

var sum = 0
var line: string

while readLine(stdin, line):
  var next = parseInt(line)
  next = next div 3 - 2
  while next >= 0:
    sum += next
    next = next div 3 - 2

echo("Total: " & $sum)
