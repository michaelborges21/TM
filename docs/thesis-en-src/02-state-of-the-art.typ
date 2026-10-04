#import "lib.typ": *

= 2. Review of the state of the art

Research challenges today call for the search for new techniques and new ideas, leading the
scientific community to create the means for new technologies to emerge. As an introduction to
the concepts of machine learning in systematic literature review, this chapter presents some of
the reviews of related work that employ machine learning methods, together with the principles
of their approach and the means for developing the topic well.

The systematic literature review aims to identify, analyze, and interpret the available
evidence related to a particular research topic or phenomenon of interest, and is one of the main
means of producing summarization [18], which has made this method increasingly popular, as
can be seen in works such as [18, 19].

This method for discovering knowledge in texts is widely used today in fields of research
such as history, medicine, biomedicine, and pharmacy [20, 21]. According to the authors in [22],
the systematic review (SR) originated in the field of medicine, becoming a key fact-based
research method. Investigations of this kind showed that expert opinions based solely on the
experts' own medical experience were not as reliable as those grounded in the results of
scientific experiments --- that is, in evidence.

As the SR method developed, positive results accumulated and many specialists came to
adopt it. In 2004 it was brought into line with what is practiced in medicine, with procedures
being proposed for carrying out SRs in software engineering [23]. In [24] the authors show that
the SR has become the best-known research method where summarization and evidence in
software engineering and computer science are concerned, which has led to significant growth
in its use in recent years [18, 19, 24].

Researchers and health policy makers increasingly contribute to the development of this
method. As mentioned earlier, conducting an SR can be a time-consuming task, which confronts
developers of clinical practice, and other decision makers, with the need to make informed
decisions in a timely manner --- for example, in infection outbreaks or health technology
assessments in hospitals. In order to bring precision to the question of SR production, the
following options were analyzed: (a) implementing process parallelization (for example, having
two or more human reviewers available to screen the articles), (b) adapting and applying
innovative technologies, and (c) modifying SR processes (for example, study eligibility criteria,
search sources, data extraction, or quality assessment) [12].

As regards option (b), implementing SRs with the use of new technologies is a subject
receiving ever greater attention, given the importance of improving it, since it helps reduce the
workload and improves efficiency in production. However, according to [12], new technologies
need to be assessed for accuracy, reliability, practicality, and cost. The authors in [25] illustrate
option (b) by showing that instruments such as online catalogs --- the Systematic Review (SR)
Toolbox site, for instance --- provide a list of tools available for download in support of SRs,
demonstrating the use of technological means for this type of situation. One example is the use
of technological tools such as machine learning methods in areas that allow the automation of
specific SR processes, particularly those involving time-consuming and resource-intensive
tasks, such as language translation [12, 26], study selection, data extraction, and risk-of-bias
assessment [12].

In [27] the authors propose evaluating the use of DistillerAI, a tool built into the
DistillerSR literature review software [28], a commercially available web application. The
authors in [27] assembled five teams of systematic reviewers who screened 2,472 proposed
articles in parallel; each of these teams trained the DistillerAI tool, which replaced one human
reviewer on each team and provided predictions about the relevance of the records.

The results obtained in [27] for this tool showed that its sensitivity for software-assisted
screening across the five teams was inadequate to temporarily replace a human reviewer during
article screening for an SR, making the tool better suited to rapid reviews, which do not require
the detection of all relevant evidence, and placing semi-automation tools on a higher scale of
usefulness than traditional reviews.

To address the questions raised by the authors in [27], where tools for carrying out SRs
are not always adequate, new kinds of possibilities for acquiring information have been created
--- for example, the PubMed search engine, where researchers have easier means of finding
articles grounded in biomedicine. Even so, for the SR method to be practiced well, the data
gathered cannot be imbalanced, and text processing and classification methods and techniques
must be used to that end.

In [29] the authors show that even experienced researchers have difficulty screening in
search engines of the PubMed kind, which do not always afford the opportunity to find
information that composes a balanced #emph[corpus]. It is therefore necessary to employ new
technologies, using procedures that build keyword queries, giving researchers a minimum
number of articles that are relevant to the questions under investigation while generating a larger
quantity of non-relevant articles, which produces data imbalance in the investigation.

In a situation like this, the use of machine learning methods can help minimize the
imbalance of the data collected. This can be seen in [17, 29]. In [30] the authors devise research
methods for processing the texts collected, in which they present the training of four types of
binary classifiers --- SVM, k-nearest neighbor, random forest, and generalized linear models
with elastic net --- showing combinations of these four techniques that can solve or alleviate the
class imbalance problem through text processing using text mining techniques [29].

A similarity can be observed in [30], where the researchers used the PubMed search
engine to carry out screening, reducing the workload in preclinical reviews of animal studies.
They applied two independent machine learning approaches to screen a large number of
citations. In the first approach they used features such as the n-gram model to form the text
representation sample known as Bag of Words (BoW), and the SVM classifier with stochastic
gradient descent (SGD) to classify the samples. In the second approach they used the
probabilistic model known as latent Dirichlet allocation (LDA) with singular value
decomposition (SVD), showing the importance of words within a given article by means of the
TF-IDF statistical measure. From this it can be concluded that, for carrying out the SR of articles
using new technologies, there is no single way, but rather the best choice for each situation that
can resolve the question of supporting the SR.

For the construction of the machine learning classifier for SR in this dissertation, the
proposed solution is based on machine learning and will be strongly integrated with text mining
techniques, facilitating the reduction of the workload involved in carrying out SRs. Reference
[31] defines text mining as a set of processes that discovers innovative knowledge in text, which
in this dissertation is accompanied by the use of NLP techniques, a computational technique
involving languages [32].

Text mining techniques together with NLP assist in the process of knowledge discovery
and hypothesis generation, given the volume of the literature [33]. The main objective of
combining these two techniques in this work is to extract new information, such as hidden
relationships in the texts between named entities, making it easier for researchers to discover
systematically and efficiently, collecting, interpreting, and organizing what is needed for the
investigation [34].

Reducing the screening burden draws on machine learning methods; these methods
helped the computer learn on the basis of the manual screening, employing two types of label:
"relevant" and "not relevant" [35]. To carry out automatic classification, the supervised learning
strategy is used --- a technique that can begin with a small training set and, through iteration,
grow the data collection in size and usefulness, although for this work the number of articles is
fixed [34, 36].

The development of supervised learning proposes the use of the SVM classifier to
perform the classification of the instances. This classifier is one of the most widely used where
supervised training is concerned, finding a hyperplane that separates the training instances of
the not-relevant class from the relevant one by a maximum margin boundary [37]. To refine
supervised classification properly, the LDA technique is applied beforehand. The authors in [20,
39] show that the LDA technique is a probabilistic model based on a set of algorithms whose
purpose is to discover thematic structures hidden in large collections of documents. The idea of
hiddenness in thematic structures reflects the need to reveal terms that might go unnoticed by
other techniques such as TF-IDF. LDA treats texts as a mixture of distributions of hidden topics,
with each topic represented by a floating-point value. It proves promising when little manually
assigned information is available, forming clusters of the information to be analyzed and
increasing the performance of active learning without manual annotation.

In what follows, the development of the machine learning solution for semi-automating
the SR process is explained in greater detail, helping in the search for and organization of the
articles on which possible investigations into the desired topic are to be carried out, with the
technologies used and the methods of using them explained more fully.
