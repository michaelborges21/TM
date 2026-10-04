#import "lib.typ": *

#fig("fig28.png", [Coherence points and coherence value.], width: 65%)

The idea behind the chart in Fig. 28 is to give the researcher the number closest to the
ideal number of topics, by building many LDA models with different values of $k$ and choosing
the one that gives the highest coherence value. Choosing a value of $k$ that marks the end of
the rapid growth in topic coherence generally offers more meaningful and interpretable topics.
Choosing an even higher value can sometimes give more granular subtopics [108, 109].

If the topic contains the same keywords repeated across several neighboring topics, it is
probably a sign that $k$ is too large.

#fig("fig29.png", [Coherence scores.], width: 70%)

The value of $k$ chosen in this context was $k = 20$, where it can be seen that at position
20 the chart begins to flatten out (Fig. 28) and shortly afterwards grows exponentially. With a
very large value of $k$, as mentioned earlier, keywords may be repeated across several topics.
This process of choosing the best number of topics takes a certain amount of time to consider,
because the function developed for this task computes coherence for each article to be examined
by the LDA model. Fig. 29 presents the coherence for each topic and shows the highest
coherence among them.

#fig("fig30.png", [Perplexity and coherence metrics used for the LDA and Mallet models.], width: 55%)

As mentioned earlier in subchapter 3.5.3, the lower the log perplexity the lower the error
rate, whereas for coherence points the higher the better. This can be confirmed in Fig. 30, with
the comparison between the LDA model and LDA used together with Mallet.

#fig("fig31.png", [Most representative document for each topic.])

Fig. 31 shows the percentage contribution of the topics (keywords) in each document
analyzed. With the results of the probabilistic model complete, a new #emph[corpus] is obtained
containing new parameters. This #emph[corpus] assembled by LDA is used by the supervised
SVM classifier, which has in its classification structure the aim of performing polarity analysis
into "relevant" or "not relevant" for the case of this dissertation.

The feature extraction process is then begun, through the training of the classifier; in this
dissertation the TF-IDF statistical measure is used together with the SVM classifier. To obtain
greater performance from the SVM technique, it was proposed to find the best hyperparameter
for this classifier, making adjustments to improve its performance and its learning rate.

SVM can generally offer many hyperparameters, and finding the right model for
classification can make the task very arduous; for this task, however, the technique called grid
search was used --- a searcher for the best hyperparameter solution that will evaluate all the
combinations passed through a dictionary and will use cross-validation calculations to arrive at
that result [38, 115].

In Fig. 32 the internal structure of the grid search can be seen, with its processing cycles.

#fig("fig32.png", [Illustration of the cycle of a grid search in the quest for optimal parameters [115].], width: 70%)

For this task it was necessary to divide the #emph[corpus] in a proportion of 70% of the
articles for training and 30% for testing, using the SVC() (support vector classification) function
model from the scikit-learn library. This function is used in its default form because the dataset
used in this dissertation is relatively small; in this case it will not be necessary to use more
specific classes such as LinearSVC(), also belonging to the scikit-learn library, which performs
better with large datasets [38, 117]. Without going through any adjustment in search of the best
hyperparameters, it can be seen that the classifier has a proportion favorable to the "not relevant"
class.

#fig("fig33.png", [Classes without any kind of hyperparameter adjustment.], width: 70%)

As can be seen in Fig. 33, the classes classified by SVC, without any kind of
hyperparameter adjustment, show in their form that the #emph[corpus], however much it has
been balanced by the oversampling process, still has its differences as regards the degree of
polarization.

In Fig. 34, on using the grid search method, the hyperparameter was adjusted for better
precision in the "relevant" classification, 1 at 100%. Note that these results are based on the state
of the #emph[corpus] balanced with processing by the LDA statistical method.

#fig("fig34.png", [Classes with hyperparameter adjustment.], width: 70%)

#noind[Best hyperparameter adjustment found using the grid search method:]

#fig("fig35.png", [Adjusted hyperparameters with linear kernel.], width: 75%)

#noind[where the parameters shown in Fig. 35 may be understood as:]

#set par(first-line-indent: 0pt)
#block(inset: (left: 1.25cm))[
  C: regularization of the hyperparameter, with a value equal to 1.

  Gamma: adjusting for linear hyperplanes; value 1, equal to linear.

  Kernel: linear hyperplane, separating the "relevant" from the "not relevant."
]
#set par(first-line-indent: (amount: 1.25cm, all: true))

After the grid search process was complete, the best hyperparameter adjustment is taken
to be C = 1 with kernel: linear, which offers an improvement in supervised classification, as
will be demonstrated shortly after the results with the adjustment.

== 4.3. Feature extraction based on the k-fold technique

To evaluate the classifier model used, the cross-validation technique is employed, which
performs the analysis from a dataset with the aim of estimating the precision of the classifier.
This technique tends to add data to the part that will be used to train the classifier. For the
development of cross-validation in this dissertation, the k-fold technique is used with the
scikit-learn library.

The k-folds technique has at its basis the concept of dividing the set of information into
smaller, mutually exclusive subsets, so that they can be used in estimating the parameters of the
classification model (training data), leaving the rest of the data from the subsets (validation or
test data) responsible for validating the model [38, 115].

The division in the cross-validation technique is governed by the following condition:
the #emph[corpus] to be analyzed in this example is denoted $d$ to present the #emph[corpus]
as a single document, and it is divided into $K$ parts, $(d_1, d_2, d_3, ..., d_k)$. This choice is
adopted by the developer of the classifier, but according to the author of [38] the standard is to
divide it into 10 parts of similar size $m_k$, where $sum_(k=1)^K m_k = n$, with $K$ being the
number of iterations of each validation sample, given by $d_k$, with $k = 1, 2, 3, 4, ..., K$.

After this training sample of the predictor, the set of the other $K - 1$ parts is analyzed,
remaining as follows: $d_(-k) = {d_1, d_2, d_k - 1, d_k + 1, ..., d_k}$. At the end of the
cross-validation process with the $K$ cycles, the data are used both in the training part and in
the validation part. This type of cross-validation, used in this dissertation, is called
$K"-folds"$, and is exemplified by the following mathematical formula:

$ k f K = 1/K sum_(k=1)^K 1/(m_k) sum_(i=1)^(m_k) L(y_(i k), hat(f)_((-k)) (x_(i k))) $

where the predictor $hat(f)_((-k))(x)$ is built for the training samples $d_(-k)$ and is evaluated
on the observations of the test sample $d_k$ for every $k = 1, 2, 3, 4, ..., K$ [115].

Cross-validation with the $k"-folds"$ method performs a division of the data through the
value $K$ (the number of parts) between the training and test samples. In carrying out this task
of dividing the documents in this validation technique, there is a tendency for the size of the
samples $m_k$ to decrease as the value of $K$ is increased; a very high value results in a high
computational cost, which implies small test samples and thereby increases the variance.
According to scholars of the subject, the ideal value of $K$ would lie between 2 and 10 [38, 15,
118].

In this dissertation the value $K = 4$ will be used, with the option of random number
generation with 2 attempts. This randomness is the option of shuffling the content of the
#emph[corpus] so that it can be divided by the k-folds technique, this value giving better
performance for the type of #emph[corpus] offered for this work. The reason is that these data
are not very voluminous, so there is no need to slice the #emph[corpus] into small units; on
another occasion, however, the need to implement the k-folds cross-validation technique with a
value of $K = 10$ would not be a bad idea.

Fig. 36 exemplifies the k-folds model with a dataset being divided into $K$ parts of size
$m_k$ and with a training set of $K - 1$, that is,
$d_(-k) = {d_1, d_2, d_k - 1, d_k + 1, ..., d_k}$.
