#import "lib.typ": *

= 1. Introduction

A defining characteristic of modern science is that it is a cumulative achievement. The
knowledge attained at any given moment rests on the vast #emph[corpus] of knowledge
previously discovered and communicated. Every researcher can echo the famous words of Isaac
Newton: "If I have seen further it is by standing on the shoulders of giants" [1]. For this reason,
reviews --- that is, syntheses of the most relevant knowledge on a given topic --- are crucial in
science [2]. They make it possible to determine whether what has been published in a given
field allows interpretable patterns or trends to be identified, to aggregate empirical results in a
way that enables evidence-based practice (in medicine, for example), to create new theories, or
to uncover questions that require further investigation [3].

There are two types of literature review [4]. The first and more common is the one
carried out in any scientific article or dissertation, which, in sections titled, for example, "state
of the art," seeks to synthesize what has been published on the topic of interest, and may also
provide the context of the problem to be addressed and the theoretical framework for the
solution proposed to the identified problem [5]. The second type is called a systematic literature
review and is itself a work of research. It seeks to synthesize a given scientific field completely
and rigorously, striving to eliminate as far as possible any subjectivity in the choice of the works
to be cited. A systematic literature review article aims to be a starting point for the members of
a given scientific community, without any analysis of primary data taking place [6].

In fields of knowledge where time is a crucial factor, because obtaining the knowledge
is urgent, systematic literature reviews take on special importance, since they place research
teams at the frontier of knowledge and in possession of a reliable overview of what has been
done in the past. Such is the case of the life sciences. For example, in managing the current
COVID-19 pandemic, accelerated systematic reviews have been produced, notably to obtain
scientific evidence regarding the use of masks [7] and regarding the effect of COVID-19 on
pregnancy [8], among many others. In the same way, when health technology assessments are
carried out, particularly of pharmaceuticals, conducting systematic reviews as quickly as
possible is essential for patients, physicians, and industry [9].

Over the past few decades, the number of scientific articles published globally has been
growing at rates of around 8% [10]. In the life sciences that growth has been somewhat higher
still [10]. PubMed, the most widely used repository of articles in the life sciences (though it
does not represent everything that is published), receives more than 1 million articles deposited
annually [11]. Given this exponential growth in publications, it is understandable that preparing
systematic literature reviews is a task that consumes a great deal of time and resources, both
human and financial, with an average duration that can range from 6 months to several years
[12, 13].

The development of machine learning methods to semi-automate the preparation of
systematic literature reviews has been a focus of interest in recent years, constituting a research
and development subfield of its own [14], to the point that systematic literature reviews on this
very subject exist, e.g., [15, 16]. Most of these techniques perform text classification, data
extraction, or summarization [17]. Text classification aims to develop models that make it
possible to organize documents automatically according to a predefined set of categories (for
example, related to Alzheimer's disease versus not related to that disease). Data extraction
models aim to identify words, numbers, or short excerpts of text that correspond to a particular
piece of desired information (for example, a chemical formula representing a protein, when the
goal is to extract references to proteins, or to extract the number of people taking part in a given
clinical trial). Summarization aims to synthesize a new text document whose content
constitutes a summary of the original document.

The purpose of this dissertation is to present a machine learning solution to
semi-automate the process of preparing a systematic literature review on the topic "Quality of
life in patients with Congenital Disorders of Glycosylation (CDG) and their families." Any
systematic literature review begins by defining a set of inclusion and exclusion criteria for the
articles to be considered. Part of those criteria is a set of keywords, and combinations of them,
chosen so as to perform an initial extraction of articles from a repository. Naturally that
extraction is very coarse, so the set of articles obtained in this way --- usually numbering in the
tens or hundreds of thousands --- contains a high percentage of articles that are not relevant to
the intended literature review.

A fundamental step in preparing a literature review is the initial screening based on the
abstracts of the articles in that set. This screening represents a trade-off: assessing all of the
articles, but on the basis of their abstract and title alone. In this way the number of articles can
be reduced substantially with moderate effort, by limiting the analysis to the article's abstract.
It should be noted that, despite this trade-off, this is still a task that represents a great deal of
effort and is normally very time-consuming. This dissertation presents a machine learning
model to automate this screening on the basis of the titles and abstracts of the articles.
