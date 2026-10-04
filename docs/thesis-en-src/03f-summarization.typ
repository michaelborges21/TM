#import "lib.typ": *

a few dozen records (articles). See Fig. 14 for a visual illustration of these two techniques [54].

#fig("fig14.png", [Example of the oversampling and undersampling techniques.], width: 85%)

The random oversampling resampling technique takes into account the weight $(p)$ of
each sample of the minority class, with $p = 1$, given by the resampling algorithm that will
appear in the loss function. The loss function is the optimization of the classification and
regression criterion used by the oversampling resampling algorithm [54]; it weights the function
in such a way as to discount errors for records with low weights in favor of records with higher
weights. Many classification algorithms assume a weights argument that allows records to be
weighted up or down. The weight $(p)$ for the majority class is defined as $1\/p$, so that the
minority class is increased to match the proportion of the majority class; in the end the total sum
of the weights is practically the same [54, 93, 94].

The advantage of using random oversampling resampling is that no information is lost,
but there may be fitting issues, known as overfitting of the data, since this multiplication or
replication proves ineffective for predicting new results [94].

== 3.7. Summarization of articles

The process of transcribing a text into a shorter version is called text summarization, and it can
be of two types: extractive and abstractive. In the first, sets of important sentences from a
document are produced without alteration; in the second, there is a process of improving the
coherence of the text, eliminating redundancies and making the sentences more concise, which
comes to create new clauses [96].

In the summarization process, reducing the quantity of text in a document while
preserving its key meanings is immensely useful for trying to discover whether or not a long
document meets the reader's needs and whether it is worth reading the rest of that information.
With long texts, the summarization algorithm processes and summarizes the document in the
time the reader would take to read the first paragraph. The main key point is to reduce the size
and the level of detail of a document while preserving the main points and the overall meaning
[96, 97].

This dissertation uses summarization of the extractive type, with the abstract as its key
point of summary within the articles. This course was adopted for the following reason: since
the abstract is a part of the article that already presents a summary of what is to be shown,
summarizing on top of this part works well for articles with a long abstract, which in many
circumstances confuses the reader with the article's introduction.

With a view to easing the human reviewers' screening work by reducing the reading
burden, summarization based on this aspect was investigated in this dissertation, using for this
purpose the Gensim library, which has at its foundation rows of text sentences and applies a
variation of the TextRank algorithm [98].

Recognition of the entities of each summarization of the abstracts is also employed,
using the spaCy library for this purpose together with its displacy function. Reference [99] shows
that Named Entities (NE) are represented by one or more rigid designators in a given text. Some
of the most common NE types are: proper nouns, such as names of people, organizations, and
local entities; temporal entities such as dates, time, day, year, and month; and numeric entities,
such as measurements, percentages, and monetary values [99].

The TextRank method is an unsupervised, general-purpose algorithm in the field of
summarization, designed for specific NLP tasks. The main idea is the ranking of text based on
graphs, its concept being grounded in mathematics, in a subfield of graph theory [100, 101, 102,
103].

The TextRank algorithm has at its basis the PageRank algorithm, another algorithm used
to carry out website ranking searches, widely employed by the Google search engine. This
algorithm extracts key phrases by exploring the structure of the text in question, in order to
determine key phrases that appear essential to the text, in the same way as PageRank [104].

In order to understand the TextRank algorithm better, a short account of its structure in
mathematical terms is required [105]:

$ C(N_i) = (1 - d) + d sum_(N_j in E_n (N_i))
  (p_(j i)) / (sum_(N_k in S_a (N_j)) p_(j k)) C(N_j) $

#noind[According to some notations, the following can be observed:]

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.5em,
  [$C(N_i)$: ranking of the nodes;],
  [$N_i$: node;],
  [$d$: $d$ is a damping factor intended to include in the model the probability of a random
   jump from one node of the graph to any other;],
  [$N_j$: nodes belonging to the set $E_n (N_i)$;],
  [$N_k$: nodes belonging to the set $S_a (N_j)$; these are the total nodes that each node $N_j$
   recommends;],
  [$p_(j k)$: weight of the recommendations.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

As explained in [80], equation (25) represents a graph model that can be defined as
$G = (N, A)$, these being the parameters of a directed and weighted graph --- that is, it assigns
weights to the recommendations of each set of nodes. $N$ is the set of nodes and $A$ the edges,
where $A$ is a subset of $N times N$. The node $N_i$ is represented by the set $E_n (N_i)$,
which point to it, making a self-reference.

$C(N_j)$ is the set of rankings of each of the nodes $N_j$ belonging to the set
$E_n (N_i)$ --- that is, the nodes that recommend $N_i$ --- with $p_(j i)$ as the weights
aggregated to the indications. $N_k$ represents the nodes belonging to the set $S_a (N_j)$; these
are the total nodes that each node $N_j$ recommends, the weights of those recommendations
being represented by $p_(j k)$ [100].

In equation (25) an important factor to note is the variable $d$, an item that helps damp
the model on the probabilistic side when there is a random jump from one vertex of the graph
to any other. In a usual situation while browsing the internet, this factor represents the
probability of the user reaching a page by means of a link located on the current page, with
$(1 - d)$ being the probability of the user jumping to the next page at random, unlinked to the
page of origin. According to the TextRank documentation, the original definition of the factor
$d$ is 0.85, lying between the bounds of 0 and 1.

In this way, the TextRank algorithm is independent of training, which is required in
supervised classification. It can be run on any random part of the text, determining the
emergence of intrinsic texts derived from the simple basis of the properties of the text to be
analyzed, which makes it a highly adaptable algorithm for use with new domains and languages
[104].
