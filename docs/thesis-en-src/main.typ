// =====================================================================
// Machine Learning for Supporting Systematic Literature Reviews
// English reconstruction of the 2020 master's thesis by Michael D. Borges
// Layout mirrors the original Word/PDF: A4, Times New Roman 12pt,
// 1.5 line spacing, justified, first-line indent, centered page numbers.
// =====================================================================

#set document(
  title: "Machine Learning for Supporting Systematic Literature Reviews",
  author: "Michael Dionísio Borges",
)

#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
  numbering: "1",
  number-align: center,
)

#set text(font: "Times New Roman", size: 12pt, lang: "en", region: "US", hyphenate: false)
#set par(justify: true, leading: 0.95em, first-line-indent: (amount: 1.25cm, all: true), spacing: 0.95em)

// ---- headings -------------------------------------------------------
#set heading(numbering: none)
#show heading: it => block(
  above: 1.4em, below: 0.9em,
  text(weight: "bold", size: if it.level == 1 { 13pt } else { 12pt }, it.body),
)

// ---- figures & tables ----------------------------------------------
#set figure(gap: 0.8em)
#show figure.caption: it => block(
  width: 100%,
  align(center, text(size: 10pt, [
    #it.supplement #context it.counter.display(it.numbering) - #it.body
  ])),
)
#show figure: set block(above: 1.4em, below: 1.4em)

// ---- equations ------------------------------------------------------
#set math.equation(numbering: "(1)")

#import "lib.typ": *

// =====================================================================
#include "00-front.typ"

#include "01-introduction.typ"
#pagebreak()
#include "02-state-of-the-art.typ"
#pagebreak()
#include "03-problem-and-solution.typ"
#include "03b-preprocessing.typ"
#include "03c-classifiers.typ"
#include "03d-lda-metrics.typ"
#include "03e-metrics-balancing.typ"
#include "03f-summarization.typ"
#pagebreak()
#include "04-results.typ"
#include "04b-lda-topics.typ"
#include "04c-gridsearch-kfold.typ"
#include "04d-discussion.typ"
#pagebreak()
#include "05-conclusion.typ"
#pagebreak()
#include "06-bibliography.typ"
#pagebreak()
#include "07-annex.typ"
