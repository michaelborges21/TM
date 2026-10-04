#import "lib.typ": *

= 3. Problem formulation and proposed solution

The rate at which research is published is increasing extraordinarily in the health field,
especially in medicine [40]. Researchers who increasingly need information quickly have
difficulty keeping up with new discoveries, even within a single domain --- an issue that has
been emerging for several years [41]. The SR becomes ever more resource-intensive as searches
retrieve a greater number of potentially important articles for reviewers to examine for relevance
to the research question [42].

The solution many researchers have been turning to in order to reduce this workload in
less time is based on the field of text mining, a subfield of machine learning, which facilitates
carrying out SRs in a range of fields of knowledge [18, 42]. The use of text mining techniques
and machine learning methods to support SRs has been proving quite effective. It is becoming
an increasingly common approach for limiting the human burden and the monetary resources
required, and for shortening the time needed to complete these reviews [47].

This work used information originating from PubMed, a search engine used to access
citations and abstracts of research articles in biomedicine, which draws in its database on
another system for searching and analyzing the medical literature, MEDLINE, whose source is
the bibliographic database of the United States National Library of Medicine [43, 44].

== 3.1. Problem formulation

When researchers select articles to begin their studies, they encounter difficulties in screening
this information, because searching in search engines using keywords returns a chain of articles
many of which will be irrelevant to the SR study, making it difficult for reviewers to read them
all in depth in a short space of time [45, 46]. Faced with this problem, the reviewers who built
the #emph[corpus] used in this dissertation selected a set of keywords specific to the field of
preclinical studies and entered them into PubMed, which returned 17,132 articles, many of
which proved to be of no interest to the research team. These articles, unsuitable for screening
classification, correspond to those keywords found in fields of study from other areas connected
to biomedicine. To classify the volume of articles gathered, the reviewers managed to obtain
327 articles, of which only 265 are classified as of no interest and 62 articles are classified as
relevant. This shows that the choice of keywords matters if the texts that may be of interest to
the researchers are to be obtained from the PubMed search engine, thereby avoiding wasted time
and, possibly, imbalance in the information.

== 3.2. Classifier for screening articles on the basis of title and abstract

The article classification process is grounded in the title and abstract fields, using machine
learning methods with the SVM classification technique. To build the #emph[corpus] used in
this dissertation, it was necessary to develop a script in Python 3. The script accesses PubMed
content through the title, abstract, and MeSH (medical subject headings) fields [52]. With a
spreadsheet containing three classes of keywords (see the annex), the script forms pairs and
triples of the keywords, one from each class.

For the screening process used by the reviewers, two assessment criteria were applied,
"relevant" and "not relevant," making it possible to employ the supervised classification
technique.

In order to assist the classifier, text processing techniques are used, in which text mining
procedures are applied together with NLP processes, making it possible to use representations
of the articles as a set of words with their frequencies in the text. The BoW model is used for
this representation; this model does not help in classifying the content, but it leaves a basis of
statistical measures that can be used by the TF-IDF technique [20, 50, 51, 53].

With this text processing implementation in place, it becomes possible to use the LDA
model, which proves promising when little assigned information is available, improving the
performance of supervised learning without manual annotation, helping with the
representations of the articles, and exposing texts that contain hidden information that might go
unnoticed by the classifier [54].

To classify the articles with the SVM technique, the term--document matrix is required.
This is a matrix of feature vectors, with word counts balanced by the TF-IDF technique and of
fixed length. This matrix, which contains the classification of the articles, is a list with a small
set for training the supervised classifier. With the procedures mentioned above, it is possible to
use the article classifier to assist learning in support of the SR.

== 3.3. Text mining

Text mining is the process of discovering information in large collections of texts, and it
automatically identifies interesting patterns and relationships in textual data [31]. This
knowledge discovery involves a range of applications such as text analysis, information
extraction, summarization, classification, clustering, and computational linguistics, among
others.

Text mining uses information retrieval techniques, which involve retrieving information
from stored data through user queries or preformulated user profiles [55]. Being a relatively new
field of research that has recently raised a great deal of interest in industry and in the scientific
communities, chiefly because of the growing quantity of information available on the internet,
it has been helping to develop the SR further [20, 49, 56, 57].

=== 3.3.1. Stages of text mining

One of the stages in the text mining process is the step for the text classification technique,
which is governed by the collection of data in the form of texts through the extraction of
documents that may come from the most varied sources, such as emails, text fields in databases,
web pages, digitized electronic texts, and so on [49, 56, 58, 59].

There are a number of phases that are of the utmost importance to text mining processes,
which may be listed as: (1) extraction, (2) text preprocessing, (3) transformation, (4) mining,
and lastly (5) analysis [42, 60].

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.9em,
  [#text(weight: "bold")[Extraction:] Extraction is the main phase of the text mining technique,
   and it forms the basis of the whole development process in this work. This segment involves
   the task of collecting texts, which can be done in various ways; some use third-party software
   such as crawlers, software that traverses internet sites with the aim of collecting data
   automatically. In this work, however, the mode of knowledge extraction was based on
   screening research in which two human reviewers were used to carry out research on articles
   gathered from various sources, which were then classified as "relevant" or not relevant. Once
   enough data has been gathered for analysis, it is possible to create a #emph[corpus] that will
   serve as the basis for applying text mining techniques together with machine learning
   techniques [61, 62].],
  [#text(weight: "bold")[Text preprocessing:] In this phase the texts originating from extraction
   are processed to eliminate redundancies and filter out irrelevant information that might disturb
   the desired information. Types of disturbance that may be detected are: spaces, irrelevant
   punctuation, and special characters that confuse the algorithm during learning. This phase
   usually consumes a great deal of processing time during knowledge extraction, because there
   is no single technique that can be applied across all application domains, varying greatly with
   the #emph[corpus] to be used [63].],
  [#text(weight: "bold")[Transformation:] After phases 1 and 2, this part is responsible for
   checking whether the textual information is sound, in the sense of whether or not the
   #emph[corpus] --- in which the gathered and classified articles have been brought together
   --- needs to be modified. Often, however, some text mining and text classification work
   requires dimensionality reduction, or even an increase in structure, so that it is sometimes
   necessary to add labels --- for example, creating an index for faster access, thereby better
   organizing the content of the #emph[corpus] internally. That is when there is no need to
   balance the set of texts that make up the #emph[corpus] on account of poor classification
   between the classes, which generates a tendency toward higher scores for the majority classes
   [57].],
  [#text(weight: "bold")[Mining:] The phase in which machine learning is applied to obtain the
   desired knowledge, directed to the case one intends to work on. For example, if the researcher
   needs to investigate degrees of similarity in the formation of groups, then the mining
   algorithm chosen is clustering; if, on the other hand, the same researcher needs to examine
   information already formed, where the prior knowledge is based on labels, the clearest method
   for carrying out the mining will be classification. For this work, the classification method is
   used, through which the main articles belonging to the different classes are found, helping in
   the selection of the texts one aims to obtain more quickly [49, 63].],
  [#text(weight: "bold")[Analysis:] According to [49], analysis is the effectiveness of the result
   of the processes one aims to obtain after the previous phases have been applied. It is the stage
   at which the objective of discovering new knowledge from the database that was created ---
   that is, the #emph[corpus] --- is evaluated. This is a cyclical process in which each stage is
   analyzed individually to determine whether or not it is satisfactory; if it is not satisfactory, a
   new cycle of processes is carried out.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

#fig("fig01.png", [Illustrative diagram of the text mining methodology. Source: [61].], width: 85%)

In Fig. 1 the life cycle of text mining processes can be seen. Since the preprocessing
phase is exhaustive, the sections below are set aside, after the collection of the texts, for a more
precise account of this technique, with the aim of achieving a better understanding of this part,
which is so necessary where text mining for the SR is concerned.

=== 3.3.2. Preprocessing techniques in text mining: removal of characters and spaces

This stage is considered a pre-tokenization phase, a term used to indicate the beginning of the
fragmentation of a textual sequence into words or meaningful elements, called tokens [65]. The
pre-tokenization stage filters out any kind of unnecessary characters that might cause noise in
the processing of the #emph[corpus]. Almost always, this stage of removing newline characters
or special symbols is carried out using techniques called regular expressions, also known as
regex, which constitute a language for searching, extracting, and manipulating specific string
patterns in texts. It is widely used in projects involving text validation, NLP, and text mining
[61, 64].

=== 3.3.3. Tokenization

Tokenization is the process of dividing a textual sequence into words or meaningful elements,
called tokens. The term token will be used a great deal in this dissertation, since at times it may
carry the same sense as "word." In fact, most of the time a token represents a word in the
#emph[corpus] [66].

The use of methods such as tokenization can give rise to certain kinds of problem, for
example the use of "whitespace," given that in certain languages the space is not used as a
delimiter --- in Japanese or Chinese, for instance [62]. Another problem caused by the use of
tokenization is the dimensionality of the words, since dividing the text into words leads to the
creation of large numbers of dimensions for analysis, though this can be corrected with
dimensionality reduction techniques [63].

A simple illustration of this fact uses the following line by Fernando Pessoa:
"Navegar é preciso" ("To sail is necessary"). Tokenizing the sentence yields three tokens:
[Navegar], [é], [preciso]. Decomposition into tokens makes the text easier to analyze; however,
according to [63] this division into tokens creates numerous difficulties, making it necessary to
use other techniques such as stemming, lemmatization, and stopword removal, which are
briefly described below.
