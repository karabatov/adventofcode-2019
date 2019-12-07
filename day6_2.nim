import strutils, tables

var line = ""
var orbits: Table[string, string]

while readLine(stdin, line):
  let obj = line.split(")")
  orbits[obj[1]] = obj[0]

var transfers = 0
block outer:
  while true:
    let start = orbits["YOU"]
    let target = orbits["SAN"]
    var cur1 = start
    var fromStart = 0
    while orbits.hasKey(cur1):
      var cur2 = target
      var fromTarget = 0
      while orbits.hasKey(cur2):
        if cur1 == cur2:
          transfers = fromStart + fromTarget
          break outer
        cur2 = orbits[cur2]
        fromTarget += 1
      cur1 = orbits[cur1]
      fromStart += 1

echo("Transfers: " & $transfers)
