import strutils

var sum = 0
var line = ""

while readLine(stdin, line):
  let next = parseInt(line)
  sum += next div 3 - 2

echo("Total: " & $sum)
