#import "lib.typ": *

= 4. Presentation and discussion of results

This chapter presents the development of the classifier for machine learning in systematic
literature review, taking a technical approach to the use of the programming methodologies, as
well as the details of how the #emph[corpus] is constituted and the difficulties of classifying on
top of it, together with the use of the metrics for the subject under discussion.

== 4.1. Organization and balancing of the corpus

The #emph[corpus] of this work is made up of a collection of articles based on the searches
carried out against the database of the PubMed search engine, forming a list in the Python 3
language. Four positions are found in the #emph[corpus], subdivided into: the index at position
zero, the classification of the article at position one, the title at position two, and lastly the
abstract at position three.

#tbl(
  table(
    columns: 4,
    stroke: 0.5pt,
    inset: 7pt,
    align: center,
    [Index \[0\]], [Classification \[1\]], [Title \[2\]], [Abstract \[3\]],
  ),
  [Organization of the corpus fields in the list.],
)

Considering the classification methodology in which the articles were assessed in the
"relevant" and "not relevant" categories, the set of classified articles, as already noted in section
3.1, is not balanced, containing more "not relevant" classifications than "relevant" ones, and
thereby causing an imbalance in the classification results. To balance this #emph[corpus], some
adjustments to its structure were necessary, such as converting the information base from a list
format into a format more tractable for the classifier --- the dataframe format of the pandas
library, for example --- before it passes through the text processing carried out by the text mining
techniques. This makes the information more accessible to the procedures used by the classifier.

The #emph[corpus] used in this dissertation is made up of two files. One contains the
articles selected and classified by the screening team, stored in a spreadsheet file, as can be seen
in Fig. 15, with a caption describing the ".xlsx file containing classified articles." The second
file contains assorted articles from the field of biomedicine but without classification, shown in
Fig. 15 with a caption describing the ".dat file containing unclassified articles"; this file
originates from the script developed in Python 3 to access the PubMed database, as described
in section 3.2.

#fig("fig15.png", [View of the files that make up the corpus.])

The file containing the classified articles is opened and processed so that its content can
be extracted, in order to check whether these data contain any kind of junk, such as null values
or even the question-mark characters used by the reviewers to indicate that there is indecision
about the classification of a particular article. Once this process is complete, two lists are
created: the first containing the classification and the second listing the indices of each article,
making it possible to organize the content by pairing the elements contained in both lists, as can
be seen in Fig. 16.

#fig("fig16.png", [The .xlsx file being processed to remove irrelevant content.])

Continuing with the development, the second file, containing the unclassified articles, is
opened. It then becomes possible to merge the two files into a single list, with the fields selected
through an algorithmic structure so as to separate the classified articles from the unclassified
ones into a new list containing index, title, and abstract, as shown in Fig. 17.

#fig("fig17.png", [Loop structure for organizing the new Python list (corpus).])

#fig("fig18.png", [A demonstration of the content of the list formed from the two files.])

With this sequence of steps so far, the result is a list such as the one seen in Fig. 18,
containing 327 articles, which are not yet usable by the classifier and must still undergo text
processing.

For greater precision in the #emph[corpus] classification stage, one further keyword is
introduced into the list: the #emph[index] field. This field will make it possible for the data to
be handled by the classifier algorithm with better access to the classification labels, which will
help find the best hyperplane with the grid search technique for the classifier, as will be
demonstrated later on.

First, however, the list with the four fields needs to be converted into a pandas dataframe.
This is a rectangular data table representation containing an ordered collection of columns, each
of which may hold a different type of value. What sets the pandas dataframe apart from a simple
Python list is that it has an index for both rows and columns, which makes it easier both to view
the content and to manipulate the data it contains, helping with the classification used by the
algorithms. This process can be seen in Fig. 19 [106, 107].

#fig("fig19.png", [Corpus in pandas dataframe format with the index column added.])

Once the #emph[corpus] has been adjusted, the oversampling technique is used to
balance the data. This technique is the most suitable for this type of situation, causing the
minority sample to be balanced statistically without much loss of information.

#fig("fig20.png", [Counts of the classifications before balancing.], width: 65%)

In the chart of Fig. 20 it can be seen that the proportion of classified articles relative to
the volume of the #emph[corpus], with a total of relevant classifications (1), is low, favoring the
majority classification, not relevant (0).

#fig("fig21.png", [Counts of the classifications after balancing.], width: 65%)

With the use of the oversampling resampling technique, the #emph[corpus] becomes
balanced, synthesizing 203 additional articles for the positive classification and increasing the
percentage of correct calls in the classification of the articles, with a total of 530 articles. This
resampling technique was chosen because of the nature of the #emph[corpus] on which this
work is based, being a dataset of low dimensionality and with few "relevant" classifications.
The oversampling method was the most suitable for restructuring the classification of the
#emph[corpus], leaving the #emph[corpus] at a proportion of 50% for both classes, as Fig. 21
shows, which helps with the supervised classification discussed further on.

== 4.2. Applying the probabilistic model together with the supervised classifier

The methodology used in this work has its foundation in supervised classification, using the
SVM classifier. To obtain greater precision from this classifier, the LDA probabilistic model is
used. Its purpose is to map all the topics that make up the articles contained in the
#emph[corpus], so that the words in each document are captured chiefly by these imaginary
topics (latent topics, those that go unnoticed in a reading). In order to obtain this resource, LDA
uses representations based on clusters, which are induced across the whole set of articles, and
its way of treating the articles differs from that of the SVM classifier [20, 48].
