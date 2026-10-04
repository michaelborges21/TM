#set page(numbering: none)
#import "lib.typ": *

// ---------------------------------------------------------------- cover
#align(right, image("img/logo.png", width: 5.5cm))

#v(0.6cm)

#set par(first-line-indent: 0pt, justify: false)

#align(center, text(weight: "bold", size: 12pt)[
  DEPARTMENT OF SCIENCES AND TECHNOLOGIES

  #v(0.5em)
  MASTER'S DEGREE IN COMPUTER SCIENCE AND TELECOMMUNICATIONS ENGINEERING

  #v(0.5em)
  UNIVERSIDADE AUTÓNOMA DE LISBOA

  #v(0.5em)
  "LUÍS DE CAMÕES"
])

#v(2.0cm)

#align(center, text(weight: "bold", size: 14pt)[
  MACHINE LEARNING FOR SUPPORTING \
  SYSTEMATIC LITERATURE REVIEWS
])

#v(1.2cm)

#align(center, text(size: 12pt)[
  Dissertation submitted in fulfillment of the requirements for the degree of \
  Master in Computer Science and Telecommunications Engineering
])

#v(1.8cm)

#text(size: 12pt)[
  Author: Michael Dionísio Borges

  #v(0.4em)
  Advisor: Professor Gonçalo Ramiro Valadão Matias, PhD

  #v(0.4em)
  Candidate number: 30001171
]

#v(2.2cm)

#align(center, text(weight: "bold", size: 12pt)[
  July 2020

  #v(0.4em)
  Lisbon
])

#pagebreak()
#pagebreak()
#set page(numbering: "1")
#counter(page).update(3)

// ----------------------------------------------------------- dedication
#frontheading[Dedication]

#set par(first-line-indent: 1.25cm, justify: true)

I dedicate this work to my father, #emph[Allan Kardec Afonso Borges]; without him I could
hardly have made this journey to a distant country and been able to study. To my mother,
#emph[Izaira Dionísia Borges], who, although no longer present in my life today, left me an
inheritance of knowledge and fine examples of how to live. I cannot fail to mention my
girlfriend, whom I love dearly, #emph[Mariana Lima Barbosa], who had so much patience with
me, helping and encouraging me through the difficult and the joyful moments of my journey.
Last of all, I am grateful to God for having placed these people in my life; without Him none
of this would have been possible.

#pagebreak()

// ------------------------------------------------------ acknowledgements
#frontheading[Acknowledgements]

I thank the people who were part of my life in Lisbon, the city where my knowledge grew, and
who helped me understand a little more about the circumstances that shape my life today and
about what may yet come.

#pagebreak()

// -------------------------------------------------------------- epigraph
#v(4cm)
#set par(first-line-indent: 0pt, justify: false)
#text(style: "italic")[
  Help the one who errs; \
  their feet walk the same ground, and, \
  if you have it in you to correct, \
  you have no right to condemn.
]

#v(0.8em)
#h(4cm) Allan Kardec

#pagebreak()

// -------------------------------------------------------------- abstract
#frontheading[Abstract]

#set par(first-line-indent: 1.25cm, justify: true)

Due to the great demand for scientific publications, researchers find it hard to follow
discoveries within the same domain. Synthesizing the investigation, either informally or
through systematic reviews, it becomes increasingly resource-intensive as searches retrieve
more potentially relevant information for reviewers to assess the relevance of the issue and the
investigation. With the need to start medical research in the field of genetics, a small team of
researchers used a series of keywords in the PubMed search engine. That returned a chain of
articles, making the screening process more difficult, and not all of these texts will be relevant
for the literature review, due to the quantity and in the short term it will not be possible for the
reviewers to read them all in-depth. With the task of screening 17,132 articles, the reviewers
use the "relevant" or "not relevant" labels to classify the information in the title and abstract
fields, thus easing the burden of reading the entire content. With a very high number of texts,
reviewers were able to screen 327 articles, and in this process, they obtained more studies
classified as "not relevant" than "relevant", forming an unbalanced #emph[corpus]. Focusing on
this problem a classifier is proposed that will support researchers in sorting articles, this will be
trained in a supervised manner with articles that have gone through manual sorting, with a small
set of training that serves to train the classifier. To solve the imbalance problem, the
oversampling technique is applied, showing to be very useful when there is little information
contained in the #emph[corpus]. This resampling procedure allows a better approach to articles
with text processing techniques such as text mining, enabling the use of another strategy called
term frequency -- inverse document frequency (TF-IDF). The methodology used for the
qualification of articles is the supervised binary classification, using the support vector machine
(SVM) classifier, which proved to be effective in conjunction with the probabilistic method
latent Dirichlet allocation (LDA), a model for discovering thematic structures hidden in
collections of texts, where the support vector machine might not be more accurate. This is
intended to demonstrate that the use of machine learning methods is effective in learning by
assisting investigations with systematic review.

#v(1em)
#noind[
  #text(weight: "bold")[Keywords]: Machine Learning; SVM; LDA; #emph[Corpus]#[;]
  cross-validation; oversampling; summarization; literature review; machine learning.
]

#pagebreak()

// ----------------------------------------------- note on this edition
#frontheading[Note on this English edition]

This is an unofficial English reconstruction of the dissertation originally written and defended
in Portuguese in July 2020. The layout reproduces the original as closely as possible --- A4
page, Times New Roman, 1.5 line spacing, justified text, and the original chapter, figure, and
table numbering --- but it is a typeset reconstruction, not the original file with its text replaced.
Page numbers therefore correspond only approximately to those of the Portuguese edition.

The #emph[Abstract] above is the author's own English text, reproduced verbatim from the
original. Tables 1, 2, 4, and 5, and Figures 2, 5, and 6, were redrawn so that their contents
appear in English; where a figure illustrates Portuguese morphology specifically, the original
Portuguese terms are kept and an English gloss is added in parentheses, since replacing them
would change what the figure demonstrates. The remaining figures are the original images:
where they are screenshots of code,
console output, or diagrams, any text inside the image remains in Portuguese, since altering it
would mean redrawing evidence of the work as it was actually carried out. Captions are
translated throughout.

The bibliography and the annex are reproduced verbatim, as they consist of citations and source
code that do not change between editions. The bibliography preserves the original numbering,
in which the numbers 74, 75, and 121 are not used.

Three internal cross-references that were plainly mistyped in the original have been corrected
here, since leaving them would point the reader to the wrong place: in section 3.7, two
references to "equation (18)" now read equation (25), the equation actually under discussion;
in section 3.5.3 the reference to "equation (17)" for log perplexity now reads equation (24); and
in section 4.2 a forward reference to "Fig. 28" now reads Fig. 26. Nothing else in the text was
altered.

#pagebreak()

// -------------------------------------------------------------- contents
#frontheading[Contents]

#outline(title: none, depth: 3, indent: 1.2em)

#pagebreak()

// -------------------------------------------------------- list of tables
#frontheading[List of Tables]

#outline(title: none, target: figure.where(kind: table))

#pagebreak()

// ------------------------------------------------------- list of figures
#frontheading[List of Figures]

#outline(title: none, target: figure.where(kind: image))

#pagebreak()

// ------------------------------------------------------------- acronyms
#frontheading[List of Acronyms and Abbreviations]

#set par(first-line-indent: 0pt)
#table(
  columns: (3cm, 1fr),
  stroke: none,
  row-gutter: 0.55em,
  [BOW], [Bag of Words],
  [IDF], [Inverse Document Frequency],
  [TF--IDF], [Term Frequency -- Inverse Document Frequency],
  [LDA], [Latent Dirichlet Allocation],
  [NLTK], [Natural Language Toolkit],
  [ANN], [Artificial Neural Networks],
  [SVM], [Support Vector Machines],
  [NLP], [Natural Language Processing],
  [MeSH], [Medical Subject Headings],
  [NE], [Named Entities],
  [SR], [Systematic Review],
)
#set par(first-line-indent: 1.25cm)

#pagebreak()
