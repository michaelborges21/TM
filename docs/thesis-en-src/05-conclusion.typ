#import "lib.typ": *

= 5. Conclusion

The motivation behind the development of this dissertation was to seek a solution that would
make it possible to solve, or at least alleviate, the difficulty of performing the manual screening
of articles used with the SR method. The existing estimate of the number of hours required to
carry out the review is based on the title and abstract fields, and may last on average from days
to several months, depending on the quantity of articles to be put through screening [13, 21].

To build the #emph[corpus] used in this dissertation, a set of 17,132 articles was gathered
from the PubMed search engine. Of that total, the reviewers managed to screen 327 articles,
taking on average about 10 minutes to classify a single article as "relevant" or "not relevant."
To complete this task, the reviewers spent 54.5 hours classifying 327 articles, and this
#emph[corpus] is not balanced.

The classifier proposed for supporting the SR in article screening, built with a machine
learning method together with text processing techniques such as text mining and NLP, is
applied to the #emph[corpus] with a ratio of 4.27:1 --- that is, 265 articles classified as "not
relevant" and 62 articles classified as "relevant" (see Fig. 20). To remedy this imbalance
problem, the oversampling technique was used, allowing this same #emph[corpus] to contain a
greater proportion of "relevant" articles and thereby contributing to a more accurate
classification.

With the balanced #emph[corpus] of 530 articles processed by the classifier proposed for
supporting the SR, a total of 232 articles were classified as relevant, with a precision of 96.6%,
an accuracy of 81%, an F1 score of 56%, and a recall of 63%, as against the 216 articles
classified as not relevant, taking on average 10 minutes to obtain the classification with the
proposed, balanced #emph[corpus] --- a considerable margin of difference in time compared
with the manual screening carried out by the researchers.

Out of curiosity as to whether classification would take longer with a high number of
articles, this same dissertation used the whole proposed #emph[corpus], containing both the
articles classified by the reviewers and the 16,804 articles that could not be classified, bearing
in mind that what was measured was not classification accuracy but the time consumed. For
this set of classified and unclassified articles, totaling 17,132, the same classifier algorithm was
used, and it was faster than manual screening, taking on average 45 minutes to complete the
classification of all the classified and unclassified articles, whereas for the same team of
reviewers this time could reach 118 days, or 3 months and 28 days.

The machine learning classifier for semi-automating the classification process can help
researchers in medicine as well as professionals in other fields of knowledge, such as
biomedicine, law, and history --- fields that demand a great deal of investigation --- offering
greater speed and accuracy when researchers and reviewers obtain the articles they want,
through classification using the title and abstract fields. This topic shows that machine learning
in support of SRs helps people in their daily research work, semi-automating the process of
searching for information in a faster and more practical way, and facilitating access to the
literature through classifiers developed with machine learning methods.

== 5.1. Future work

The following topics are intended to be addressed in future work:

#set par(first-line-indent: 0pt)
#list(
  spacing: 1em,
  [Use the text summarization algorithm to reduce the content of the articles gathered, helping
   reviewers read the important parts of the whole article before the classification process and
   avoiding wasted time. The aim is thereby to obtain better manual screening before moving
   on to supervised classification.],
  [Automate the process of selecting articles in the PubMed and MEDLINE search engines
   with text summarization, as proposed in the first item of this section, but with the difference
   that this summarization process would be applied at the start of the selection process by the
   script developed in the present dissertation.],
  [In the classification process, use already summarized articles for training. These are
   expected to yield a better classification.],
  [Obtain the classification without going through supervised learning, making it possible to
   take advantage not only of the articles with defined classes but also of those that had no
   opportunity to be classified through supervised classification.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

At the end of screening, researchers and reviewers will be able to worry less about the
time needed to carry out the classification; using the summarization technique and unsupervised
classification (not used in this dissertation) will save time and financial costs in the automatic
screening process.
