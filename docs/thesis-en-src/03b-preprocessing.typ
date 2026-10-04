#import "lib.typ": *

=== 3.3.4. Stopwords

Stopwords are words within the text that are of little use, supplying many tokens that have no
value for the context while being useful for a general understanding of the text. Reference [57]
notes that stopwords are empty words, represented by the articles, prepositions, punctuation,
conjunctions, and pronouns of a specific language. Reference [67] holds that, besides not
helping in the analysis for text classification, they appear in practically all of the text's content;
examples of this in Portuguese are "a," "e," "de," "mas," and "com," among others. Removing
these tokens yields a gain in performance for the SR as a whole, reducing the size of the lexicon
considerably [68]. Fig. 2 shows this process, followed by stopword removal, more clearly.

#figure(
  kind: image,
  supplement: [Figure],
  caption: [Tokenization process followed by stopword removal.],
  block(width: 100%, align(center, stack(
    spacing: 0.9em,
    rect(inset: 6pt, stroke: 0.8pt)[The house is very beautiful.],
    text(size: 14pt)[#sym.arrow.b],
    [Tokenization and stopword removal],
    text(size: 14pt)[#sym.arrow.b],
    rect(inset: 6pt, stroke: 0.8pt)[\[house\] \[very\] \[beautiful\]],
  ))),
)

Fig. 3 shows an excerpt of the classifier code containing a short list of the words chosen
to be excluded in the stopword process.

#fig("fig03.png", [Example of an external list for removing English stopwords, selected in the
Python 3 language.])

Fig. 4 shows the internal organization of the #emph[corpus] after it has been processed
by the tokenization technique.

#fig("fig04.png", [Sample of the tokenization of the #emph[corpus] used in this work.])

=== 3.3.5. Normalizing the words

The technique of normalizing the words in texts may be regarded as a set of text preprocessing
techniques that reduce the lexicon by identifying and grouping words that bear relationships to
one another. Since there is wide variation in scope, word normalization uses a range of
techniques to carry out this task, chief among them the processes of stemming and
lemmatization. For this dissertation the lemmatization technique will be used, because one and
the same word may have several meanings within a context. Lemmatization helps distinguish
this by reducing the word to its primary root, whereas the stemming method does not use, for
example, contextual information to determine the correct sense of each term, reducing the
inflected (or sometimes derived) term to its trunk, base, or root --- generally a written form of
the word that need not carry a meaning for the context [31, 69]. Fig. 5 below exemplifies what
a word looks like after the stemming process.

#figure(
  kind: image,
  supplement: [Figure],
  caption: [Example of the use of the stemming method on the terms of the text.],
  block(width: 100%, align(center, stack(
    spacing: 0.7em,
    ["Olhar" (to look) #sym.arrow.r.double #emph[stemming] #sym.arrow.r.double "Olh"],
    ["Gritando" (shouting) #sym.arrow.r.double #emph[stemming] #sym.arrow.r.double "Grit"],
  ))),
)

=== 3.3.6. Lemmatization

Lemmatization is the process of converting a word into its base form, returning it to its root and
leaving it in the infinitive of the verb through the removal of suffixes, making it possible to
show its semantics with a view to reducing the problem of redundant texts. The use of words in
lemmatization contexts can help distinguish both unseen and ambiguous words; that is, suppose
a sentence uses a word whose root is a verb, employed in some mode of verbal transition, which
in certain situations causes redundancy [69, 70]. Below is an example of how lemmatization is
used to reduce words to their root form without loss of the term's meaning; see Fig. 6.

#figure(
  kind: image,
  supplement: [Figure],
  caption: [Example of the use of the lemmatization method on the terms of the text.],
  block(width: 100%, align(center, stack(
    spacing: 0.7em,
    ["Olhando" (looking) #sym.arrow.r.double lemmatization #sym.arrow.r.double "Olha"],
    ["Gritando" (shouting) #sym.arrow.r.double lemmatization #sym.arrow.r.double "Grita"],
  ))),
)

=== 3.3.7. Bag of Words (BoW)

BoW is a model that ignores word order as well as any punctuation or structural information,
but retains the number of times a word appears in the text, and is represented as a
term--document matrix [31]. To make the way the BoW technique works clearer, an excerpt
from two texts (poems) by the author Carlos Drummond de Andrade is shown.

#noind[Text 1 (#emph[No meio do caminho]):]

#block(inset: (left: 1.25cm))[
  No meio do caminho tinha uma pedra \
  tinha uma pedra no meio do caminho \
  tinha uma pedra \
  ...
]

#noind[Text 2 (#emph[Quadrilha]):]

#block(inset: (left: 1.25cm))[
  João amava Teresa que amava Raimundo \
  que amava Maria que amava Joaquim que amava Lili, \
  que não amava ninguém.
]

Using the BoW model to represent the texts shows the poems as vectors in which the
number of times each word appears is counted:

#block(inset: (left: 1.25cm), text(size: 11pt)[
  Text 1: \[\[ ('caminho', 2), ('do', 2), ('meio', 2), ('no', 2), ('pedra', 3), ('tinha', 3),
  ('uma', 3) \]\]

  #v(0.5em)
  Text 2: \[\[ ('amava', 6), ('joaquim', 1), ('joão', 1), ('lili', 1), ('maria', 1), ('ninguém', 1),
  ('não', 1), ('que', 5), ('raimundo', 1), ('teresa', 1) \]\]
])

Using the list indices to make it easier to classify each word of the text, it is rewritten
using numeric identifiers, as shown below:

#block(inset: (left: 1.25cm), text(size: 11pt)[
  Text 1: \[\[ (0, 2), (1, 2), (2, 2), (3, 2), (4, 3), (5, 3), (6, 3) \]\]

  #v(0.5em)
  Text 2: \[\[ (0, 6), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 5), (8, 1), (9, 1) \]\]
])

On the basis of the sentences, the feature vector is assembled, which is basically a list of
all the words contained in both texts, without repetition:

#block(inset: (left: 1.25cm), text(size: 11pt)[
  \[ 'No' 'meio' 'do' 'caminho', 'tinha', 'uma', 'pedra', 'no', 'João', 'amava', 'Teresa',
  'que', 'Raimundo', 'Maria', 'Joaquim', 'Lili', ', ', 'não', 'ninguém', '.' \]
])

This list helps reduce dimensionality through the term--document matrix process applied
to the texts [71].

#fig("fig07.png", [Example of BoW. Produced by Oguri et al. Source: [71].], width: 60%)

In the BoW model any text or sentence, document, or collection of documents is seen as
a group of elements, as Fig. 7 shows; depending on the use, these elements may be simple words
such as unigrams, bigrams, compound structures, and so on [31, 53].

Fig. 7 shows that $d_1$ represents document 1 and $w_1$ the occurrence of the first word
in that text. The weights are represented by numbers between 1 and 0, which indicate whether
or not a given word occurs in a particular text, and are used to extract information about the
similarity of texts from the number of words they have in common [20]. By grounding the
frequencies in weights, these aim to estimate the number of occurrences of a given word in a
particular text, serving as the basis for the TF-IDF measure [58, 66, 72].

Fig. 8 shows an internal view of the matrix created by the BoW model used by the
classifier proposed in this dissertation for supporting the SR, in which the frequency of the terms
within the document can be seen.

#fig("fig08.png", [Sample of the BoW to be used in the SR of this dissertation.])

=== 3.3.8. TF--IDF

The TF-IDF measure computes the importance of a word in a text on the basis of the frequency
with which it appears across the whole set of documents. TF-IDF is considered the most
common mode of text analysis used for SRs, which makes this feature widely used alongside
machine learning algorithms [48]. This measure holds that if a word appears several times in a
single document, then it is considered important and receives a high score. If, however, many
documents contain that word, then it should not be used as an identifier and receives a low score
[58].

To compute TF-IDF, the calculation is separated into two stages. The first defines the
term frequency, TF [73, 76].

$ op("TF")(t, d) = frac(
  "number of times the term" (t) "appears in document" (d),
  "total number of terms in document" (d)
) $

Equation 1 explains that $op("TF")(t, d)$ corresponds to the number of times the word $t$
appears in document $d$. The second stage presents the inverse document frequency part,
$op("IDF")(t)$.

$ op("IDF")(t) = ln ( frac(
  "total number of texts",
  "number of texts in which the term" t "appears"
) ) $

In equation 2 it can be seen that the inverse document frequency is given by the logarithm
of the total number of documents or texts in the set divided by the number of texts in which the
word appears. The score the word receives is represented as the weight of a term [77, 78].

For a better understanding of how the TF-IDF measure works, a short example is given
of how to obtain the results of the weight calculations. Suppose a given document comprising
100 words in which the word "CDG" appears three times. The term frequency (TF) is given by
$3 div 100 = 0.03$. Suppose it is known that there are 10 million documents and that the word
CDG appears in 1,000 of those documents. The inverse document frequency (IDF) is computed
as $ln(10\,000\,000 div 1\,000) = 4$. The TF-IDF weight is then the product of these values:
$0.03 times 4 = 0.12$.

== 3.4. Automatic document classification

In [79, 80] the authors show that automatic document classification is a procedure that refers to
the construction of classifiers through the use of inductive processes. This inductive process,
called learning, builds a classifier for a class C by observing the characteristics of a set of
documents previously classified under class C by a researcher in the field in question. This type
of learning is called supervised, in which a new document is classified by comparison with a
classifier produced and trained from labeled (classified) documents.

For the development of the classifier, two tools are used in this dissertation for this
purpose: SVM and LDA. Both will be used together, with LDA serving to assist the SVM when
there is little manually assigned information [42].

The input to the classification treatment is made up of several collections of data --- in
the case of this dissertation, texts represented algebraically by an apparatus of documents $D$,
or #emph[corpus], in the following format $D = {d_1, d_2, ... d_i}$ --- and the classes associated
with each collection of documents in the following form, $C = {c_1, c_2, ... c_k}$ [31, 77, 122].

Classification consists in determining whether or not document $d_i$ belongs to the class
category $C_k$, for $i = 1, 2, ..., n$ and $k = 1, 2, ..., z$, these being represented as vectors
$(d_1, c_1), ..., (d_i, c_k)$, where $d_i$ is a vector representing the terms that occur in the text
and $C_k$ is the class associated with the document, thus maintaining the following relation
represented by the text preprocessing vector:
$D = {(d_1, c_1), (d_2, c_2), (d_3, c_3) ... (d_i, c_k)}$ [20, 81, 82].

According to [31], data classification comprises two classes, single-label and multi-label,
which serve to manage the state each document is in. Information in the single-label class
belongs to only one class, whereas in the multi-label case the same text or document may belong
to, or be associated with, more class categories [20].
