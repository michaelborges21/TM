#import "lib.typ": *

#noind[Described in more detail below:]

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.6em,
  [TP (True Positive) = number of articles of the "relevant" class classified as articles of the
   "relevant" class.],
  [FN (False Negative) = number of articles of the "relevant" class classified as articles of the
   "not relevant" class.],
  [TN (True Negative) = number of articles of the "not relevant" class classified as articles of
   the "not relevant" class.],
  [FP (False Positive) = number of articles of the "not relevant" class classified as articles of
   the "relevant" class.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

#tbl(
  table(
    columns: 4,
    stroke: 0.5pt,
    inset: 7pt,
    align: center,
    table.cell(colspan: 2, stroke: none)[],
    table.cell(colspan: 2)[#text(weight: "bold", style: "italic")[Predicted values]],
    table.cell(colspan: 2, stroke: none)[],
    [Relevant], [Not relevant],
    table.cell(rowspan: 2)[#text(weight: "bold", style: "italic")[Actual values]],
    [Relevant], [TP], [FP],
    [Not relevant], [FN], [TN],
  ),
  [Confusion matrix showing the categories.],
)

#noind[from which the explanation of the following metrics can be seen more precisely:]

$ op("FP") = N - op("TP") $

where the number $N$ is the number of "relevant," of the "relevant" class type.

$ op("FN") = M - op("TN") $

where the number $M$ is the number of "not relevant," of the "relevant" class type [54]. The
confusion matrix provides a great deal of information that can give rise to misunderstanding
when the results are explored; for this type of problem the issue can be resolved by using
metrics, such as the classifier's #emph[accuracy], #emph[precision], #emph[recall], and
#emph[F1 score], explained as the ratio between the number of positive examples correctly
classified and the total number of examples identified as positive by the classifier [38, 54, 86].

$ op("precision") = op("TP") / (op("TP") + op("FP")) $

Precision yields the percentage of articles that were classified by the model as belonging
to the "relevant" class, giving weight to information of the positive class (TP); the higher the
precision, therefore, the less effort will be required to analyze the articles of the "relevant" class
[38].

The disadvantage of this measure is that it does not take into account the articles of the
"not relevant" class. According to the authors of [84, 86], the perfect way to achieve precision
would be to make a single positive prediction and ensure that it is correct
($op("precision") = 1\/1 = 100%$), which is not very useful for the investigation, leading the
classifier to ignore all the "not relevant" parts and less of the "relevant" ones. From this point
of view, precision is used together with another metric called recall, which also goes by the
designations #emph[sensitivity] or #emph[true positive rate] (TPR), representing the proportion
of true positives that were correctly identified.

$ op("recall") "or" op("TPR") = op("TP") / (op("TP") + op("FN")) $

For the classifier's percentage of correct calls, accuracy is used, which considers the
number of correct calls over the positive and negative samples. This measure addresses the
whole objective of the classification work, thereby coming closer to the human capacity to
assess the subjectivity of a text correctly [54, 87, 88].

$ op("accuracy") = (op("TP") + op("TN")) / (op("TP") + op("TN") + op("FP") + op("FN")) $

In some circumstances it is necessary to have a metric that indicates the overall quality
of the supervised classification model and that works well even with datasets that have
disproportionate classes. This metric combines precision and recall and is called F1. It is a
harmonic mean of precision and recall, whereas the regular mean treats all values equally. The
harmonic mean gives more weight to the lower values, resulting in high F1 scores if recall and
precision are both high as well. In short, according to the author of [38], F1 is a better metric
than accuracy chiefly in cases where false positives and false negatives have different impacts
on the model, since F1 creates a result out of those divergences.

$ op("F1") = (2 * op("precision") * op("recall")) / (op("precision") + op("recall")) $

Besides the supervised classification metrics, this dissertation also uses evaluation
measures for the probabilistic model, such as the model's log perplexity and topic coherence.
These measures provide a convenient way of judging how good a particular topic model is.

Log perplexity measures the constraints expressed by the model. From the point of view
of the recognition task, it can be said that the language model reduces the number of word
options during the recognition process, so that it may be interpreted as the average number of
word options. Perplexity measures the difficulty of the recognition task: the lower the log
perplexity, the lower the error rate [89].

$ 2^(H(p)) = 2^(- sum_x p(x) log_2 p(x)) $

#noind[where:]

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.5em,
  [$H(p)$: is the entropy (in bits) of the distribution;],
  [$p$: discrete probability;],
  [$x$: is a variable over the events.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

#noind[
  Note: entropy, in this case of log perplexity, belongs to the field of information theory, and is
  defined as a way of determining the average degree of uncertainty with respect to the
  information sources [90].
]

Topic coherence is a measurement of the quality of a topic's property that allows sense
to be made of it, establishing a relation between its parts and between the text itself to which it
belongs and the situation of its occurrence. In another context, coherence can be seen as the
measure of the correlation between the phases of each topic at different points of a text. Topic
coherence can be divided into the following segments [91, 92]:

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.6em,
  [#text(weight: "bold")[Segmentation:] where the topics are divided into several parameters,
   assuming that the qualities of the topics in each parameter are different.],
  [#text(weight: "bold")[Probability estimation:] where the quantity of topics in each parameter
   is measured.],
  [#text(weight: "bold")[Confirmation measure:] where the quality of the topic (according to a
   given metric) in each parameter is measured and a number is assigned.],
  [#text(weight: "bold")[Aggregation:] the gauge by which these quality numbers are combined
   in a certain way (arithmetic mean) to create a single number.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

#fig("fig13.png", [Function in which the development of topic coherence can be observed. Source: [91].])

#noind[This can be described according to Fig. 13 as:]

#set par(first-line-indent: 0pt)
#list(
  spacing: 0.5em,
  [$t$: topics coming from the topic model;],
  [$S$: segmented topics;],
  [$P$: computed probabilities;],
  [$arrow(phi)$ (phi vector): a vector of the "confirmed measures" coming out of the
   confirmation module;],
  [$C$: the final coherence value.],
)
#set par(first-line-indent: (amount: 1.25cm, all: true))

== 3.6. Balancing technique

To balance the information contained in the dataset, various balancing techniques may be used,
the most common being random undersampling and random oversampling. For the purposes of
this dissertation the random oversampling technique was adopted, as better suited to the nature
of the chosen #emph[corpus].

The random undersampling procedure is a technique that randomly reduces the majority
samples and equalizes them with the quantity of the minority ones. The idea is that the data of
the dominant class contain redundant records, and that a smaller, balanced quantity of data
benefits the performance of the model and makes it easier to explore. The disadvantage is that
information important to the majority class may be lost [54].

The random oversampling technique, by contrast, is the opposite of random
undersampling. Random oversampling randomly replicates the minority class until it equals the
majority class, or until it is sufficient for the data to be balanced. This choice is based on the
set of information in the #emph[corpus], which is a relatively small set, with rare classes
containing few articles.
