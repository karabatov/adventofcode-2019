import sequtils

let dim = 25 * 6

let image = toSeq(readLine(stdin).items)
let layers = image.len div dim

var zeroes = high(int)
var multi = 0
for i in 0..<layers:
  var localZero = 0
  var ones = 0
  var twos = 0
  for j in i * dim..<(i + 1) * dim:
    case image[j]:
      of '0': localZero += 1
      of '1': ones += 1
      of '2': twos += 1
      else: continue

  if localZero < zeroes:
    multi = ones * twos
    zeroes = localZero

echo("1s x 2s on layer with fewest 0s: " & $multi)
