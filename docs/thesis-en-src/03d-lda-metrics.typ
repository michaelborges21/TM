#import "lib.typ": *

=== 3.5.2. LDA

Latent Dirichlet allocation, better known as LDA, is a probabilistic topic model used for NLP
processing and content-based topic extraction, which links the category of unclassified text
learning. Topic modeling is represented as a distribution over words, and its basis is tied to the
Naive Bayes classifier, itself a probabilistic classifier. This technique (LDA) arose from the
need to extract information from texts around the year 2003, in order to carry out topic modeling
on the basis of probability, and is today one of the most popular techniques [39, 40, 54].

To identify topics, the LDA model uses clustering methods to identify meaningful groups
of articles. In [39] the authors show that the topic model appears only during processing (which
is why it is called latent). LDA is not a classifier in itself, but it uses a topic generation approach
and is widely used to avoid any strong assumption about the relationship between the text and
the categories, using the distributions of words over topics as a mathematical model. LDA does
not need to have known class labels, as in some types of supervised classifier where pattern
deductions are made. This whole process is described through probabilistic and statistical
models in order to identify groups of topics.

The exploration of large volumes of data with little assigned information in topic
discovery is demonstrated in [39, 42], where structures with semantic values --- which in the
context of text mining form groups of terms that frequently occur together --- when analyzed
give indications of a theme or subject, occurring in subsets of documents. The term topic is
defined as a set of words that bear relationships within the document or text from which they
are automatically extracted.

In order to understand better how the probabilistic model works, suppose that a
#emph[corpus] containing reviews of articles has been supplied, comprising several texts. The
review texts submitted by reviewers over time contain many terms, some of which are used
across several topics. A topic identified by the LDA probabilistic method may represent reviews
for an individual article, or it may represent a group of article reviews. For LDA, the topic itself
is merely a probability distribution over time for a set of terms [84, 85].

Terms are rarely exclusive to any one text; they may refer to other texts or be general
terms that apply to everything --- examples would be "good," "wonderful," "happy," "sadness."
Other terms may be corrupted or meaningless words, or words with unnecessary characters,
which are referred to as noise. It is important to understand, however, that the LDA method is
not intended to capture every word contained in the #emph[corpus], nor to understand how the
words are related beyond their co-occurrence probabilities. It can only group words that have
been used in the target domain.

After the term indices have been computed, individual lines of text are compared using
a distance-based similarity measure to determine whether two parts of the text are similar. For
example, one may find that the article has several names that are strongly associated, or one
may find that strongly negative terms are generally associated with a particular article. The
similarity measure can be used to identify related terms and to create recommendations [39, 40].

Mathematically, LDA modeling has at its basis the Dirichlet distribution, denoted
$op("Dir")(z, alpha)$, and according to [18]:

$ op("Dir")(z, alpha) = 1/(B(alpha)) product_(k=1)^K z_k^(alpha_k - 1) $

Here $z = (z_1, z_2, ..., z_k)$ is a $K$-dimensional variable, with values
$0 <= z <= 1$ in $[0, 1]$ and $sum_(i=1)^K z_i = 1$. In this context
$alpha = (alpha_1, ..., alpha_k)$ are the hyperparameters of the distribution. The function
$B(alpha)$, called the Beta function, can be expressed in terms of the gamma function
$Gamma$:

$ B(alpha) = (product_(kappa=1)^K Gamma(alpha_kappa)) / (Gamma(sum_(kappa=1)^K alpha_kappa)) $

LDA does not use the semantics used by humans; these are accessed by the algorithms
through BoW techniques, by which word order is ignored [50].

The sampling of the topic distribution is carried out by the Dirichlet distribution, which
is the multivariate generalization of the Beta distribution, used to allocate the words of different
topics that will populate the documents. This gives an indication that the intent of this
algorithmic model is to allocate the latent topics that are distributed according to the Dirichlet
distribution, which in turn is a multivariate discrete distribution [39, 86].

Fig. 12 represents the Bayesian network graphically. In this network, each vertex
corresponds to a variable and each edge to a dependency relation. In this representation, instead
of showing each variable repeatedly, a rectangle is used to group variables into a subgraph that
repeats. The number of repetitions is labeled at the bottom of each rectangle.

#fig("fig12.png", [Graphical model of the Dirichlet distribution. Adapted from source: [39].], width: 75%)

LDA contains three hierarchical levels and is strongly influenced by the Bayesian model,
as can be seen in Fig. 12. In the first stage there is a representation of the topic distribution
across the whole collection of documents; the second stage of levels includes the distribution of
topics for each document. At the last level, the distribution of topics is repeated internally for
the words in a document. With this last level it becomes possible to represent a document as a
mixture of topics [129].

Fig. 12 can be better described through the following key to its variables [39]:

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.55em,
  [$n$ --- number of words in the vocabulary.],
  [$m$ --- number of documents.],
  [$K$ --- number of topics.],
  [$n_(d_j)$ --- number of words in a document $d_j$, where $1 <= j <= m$.],
  [$theta$ --- distribution of topics per document.],
  [$phi$ --- distribution of topics over the words of the vocabulary.],
  [$theta_j$ --- vector with the proportion of topics for document $d_j$, where $1 <= j <= m$.],
  [$phi_k$ --- vector with the proportion of vocabulary words for topic $k$, where $1 <= k <= K$.],
  [$alpha$ --- prior of the Dirichlet distribution, related to the document--term distribution.],
  [$beta$ --- prior of the Dirichlet distribution, related to the topic--word distribution.],
  [$w_i$ --- $i$-th word of the vocabulary, where $1 <= i <= n$.],
  [$w_(j,i)$ --- word $w_i$ observed in document $d_j$, where $1 <= j <= m$ and $1 <= i <= n$.],
  [$z_(j,i)$ --- topic distribution associated with the word $w_(j,i)$ in document $d_j$, where
   $1 <= j <= m$ and $1 <= i <= n$.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

Looking at Fig. 12, it can be seen that the hyperparameters represented by $alpha$ and
$beta$ influence the level of collections of documents. If, in the LDA modeling, the value of
$alpha$ is high, it means that each document will probably contain a greater mixture of topics;
with the same parameter, if $alpha$ is low, the LDA model will eventually have a mixture of
few topics, resulting in greater concentration in those topics. A high value of the parameter
$beta$ makes it likely that each topic contains a mixture of many words; conversely, a low value
of $beta$ indicates topics formed with few words, yielding a weak topic model [39, 129]. In
later chapters the implementation of the LDA model through the Gensim library will be
presented, together with the bubble charts that the library makes available.

=== 3.5.3. Performance measures for the classification algorithm

For the algorithm supporting the SR to work well, a number of methods are used to give greater
accuracy in classification, validating whether the classifier is performing its task correctly. To
classify the texts as "relevant" or "not relevant," it is necessary to use specific measures and
techniques such as cross-validation in order to obtain good results. Where supervised
classification is concerned, it is necessary to use measures called metrics, which check whether
the classifier is able to characterize new examples when they are presented to it.

In most cases the evaluation metric uses a matrix when supervised, binary classification
is involved, with correctly and incorrectly classified samples. This is called the confusion
matrix, a table frequently used to describe the performance of a classification model on a dataset
[38, 86].

The general idea of the confusion matrix is to ascertain the number of times the
"relevant" class is classified as "not relevant"; to reach that conclusion, the confusion matrix
uses a set of predictions so that they can be compared with the actual values. This set of
predictions can be described as:

#tbl(
  table(
    columns: 3,
    stroke: 0.5pt,
    inset: 7pt,
    align: center,
    table.header(
      [#text(weight: "bold")[Correct class]],
      [#text(weight: "bold")[Positive]],
      [#text(weight: "bold")[Negative]],
    ),
    [Positive], [True Positives (TP)], [False Negatives (FN)],
    [Negative], [False Positives (FP)], [True Negatives (TN)],
  ),
  [Metrics used for supervised classification.],
)
