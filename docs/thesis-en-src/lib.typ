// Shared helpers for all content files.

#let noind(body) = par(first-line-indent: 0pt, body)

#let frontheading(title) = block(
  above: 0em, below: 1em,
  text(weight: "bold", size: 12pt, title),
)

#let fig(path, caption, width: 100%) = figure(
  image("img/" + path, width: width),
  caption: caption,
  kind: image,
  supplement: [Figure],
)

#let tbl(content, caption) = figure(
  content,
  caption: caption,
  kind: table,
  supplement: [Table],
)
