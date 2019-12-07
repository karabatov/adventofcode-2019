import strutils, tables

var line = ""
var orbits: Table[string, string]

while readLine(stdin, line):
  let obj = line.split(")")
  orbits[obj[1]] = obj[0]

var total = 0
for key in orbits.keys:
  var cur = key
  while orbits.hasKey(cur):
    total += 1
    cur = orbits[cur]

echo("Total orbits: " & $total)
