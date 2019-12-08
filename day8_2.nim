import sequtils, terminal

let w = 25
let h = 6
let dim = w * h

let image = toSeq(readLine(stdin).items)
let layers = image.len div dim
# Fully transparent image
var final = newSeqWith(dim, '2')

proc blend(a, b: char): char =
  case a:
    of '2': b
    else: a

for i in 0..<dim:
  var px: seq[char]
  for j in 0..<layers:
    px.add(image[j * dim + i])
  final[i] = foldl(px, blend(a, b))

echo("Image:")
for i in 0..<h:
  for j in 0..<w:
    case final[i * w + j]:
      of '2': stdout.styledWrite(fgDefault, "█")
      of '1': stdout.styledWrite(fgWhite, "█")
      of '0': stdout.styledWrite(fgBlack, "█")
      else: continue
  echo("")
