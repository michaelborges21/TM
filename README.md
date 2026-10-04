# Machine Learning for Supporting Systematic Literature Reviews

> Master's project in Computer Science and Telecommunications Engineering
> Universidade Autónoma de Lisboa "Luís de Camões" — July 2020
> Author: **Michael Dionísio Borges** · Advisor: **Prof. Dr. Gonçalo Ramiro Valadão Matias**

📄 **[Read the full master's thesis — English edition (PDF, 80 pages)](docs/Thesis_30001171_Michael_Borges_2020_EN.pdf)**
📄 **[Read the original thesis as defended (PDF, 96 pages, Portuguese)](docs/Dissertacao_30001171_Michael_Borges_2020.pdf)**
🇵🇹 **[Ler este documento em português](docs/README.pt.md)**

---

## 1. The problem, in plain language

Imagine a team of medical researchers who need to answer a scientific question. Before they
can start, they have to read **everything** that has already been published on the subject.
That is what a *systematic literature review* is.

That is exactly what happened here. The team searched **PubMed** (the largest medical
article database in the world) using a list of keywords about quality of life and health,
and the search engine returned **17,132 articles**.

The problem is arithmetic, and it is brutal:

| | |
|---|---|
| Articles returned by the search | 17,132 |
| Articles the team managed to read and classify by hand | **327** |
| Average time to assess 1 article (title + abstract only) | ~10 minutes |
| Time spent on those 327 articles | **54.5 hours** |
| Estimated time for all 17,132 articles at the same pace | **~118 days** (nearly 4 months) |

In other words: the most exhausting part of research is not the research itself — it is
**separating what is worth reading from what is not**. That separation is called *screening*.

**The question this thesis asked:** can a computer learn from the 327 articles that humans
already classified, and then do the screening on its own for the rest?

The short answer: **yes, with caveats** — and the rest of this document explains how.

### Why these solutions, and not others?

That is a fair question in 2026, when the instinctive answer would be "just send the
abstracts to a language model." In 2019–2020, when this research was carried out, that path
did not exist in practice. The context of the time was:

- **BERT was barely a year old** and required GPUs that a master's student did not have at
  home. ChatGPT would not appear for another two years.
- **The corpus is tiny**: 327 labeled texts. Large neural models need thousands of examples;
  with 327, they memorize instead of learning.
- **Interpretability was a requirement, not a luxury.** A researcher will not accept a
  "don't read this article" without a justification. They need to see *why*.

So the choice fell on a set of classic, mature, explainable techniques:

- **LDA (Latent Dirichlet Allocation)** — discovers, without supervision, the "hidden
  themes" across the collection of articles. This is what provides the human-readable
  explanation: *"this article belongs to topic 72, whose keywords are cancer, treatment, …"*
- **SVM (Support Vector Machine)** — the supervised classifier. It is well established as
  the best performer in its class when there is **little data and many dimensions** (which
  is exactly the shape of a text problem). It draws a boundary between "relevant" and
  "not relevant," and stops there.
- **TF-IDF** — turns text into numbers, giving more weight to words that distinguish one
  article from the others and less to words that show up everywhere.
- **Oversampling** — to fix the corpus imbalance (explained in section 3).

None of this is obsolete: it remains the right choice for small corpora where every decision
has to be justified.

---

## 2. The screening done by the team (and what lives in `data/`)

Before any code, there was human work. And it was careful work.

The team first defined **explicit rules** for what gets in and what stays out (for example:
*include* studies with "patient or observer PROMs"; *exclude* articles not written in
English, or that are themselves reviews). Then **two researchers read the same sample of
articles independently** — Carlota and Rita (the initials "CP, RF, SB" in the file names are
the reviewers'). When the two disagreed, a third spreadsheet was used to **resolve the
disagreement and settle the final label**.

That independent double reading is what makes the labels trustworthy enough to train a
model. It is what is known as *ground truth* — the "truth" the machine is measured against.

The [data/](data/) folder holds that work:

### `data/csv/`

| File | What it is |
|---|---|
| `ArticleSelection_Sample_CP_RF_SB.csv` | The **inclusion and exclusion criteria** agreed on by the team. It documents the rules the humans followed while reading. It contains no articles — it contains the *method*. |

### `data/dat/` — the raw texts

Binary files in Python's `pickle` format (a way of writing Python objects straight to disk).

| File | What it is |
|---|---|
| `records.dat` | The **raw article database**, exactly as it came back from PubMed. A dictionary mapping each article's ID to its metadata — chiefly the title (`'TI'`) and the abstract (`'AB'`). This is the source of the text that feeds the entire pipeline. |
| `testIndicesClassesTitlesAbstracts.dat` | The **test set**, already preprocessed and frozen: a list in which each item is `[ID, true label, title, abstract]`. It exists so that model evaluation always runs against exactly the same data, with no need to rebuild it. |

### `data/xlsx/` — the manual labeling

| File | What it is |
|---|---|
| `Carlota_V1.xlsx` / `Rita_V1.xlsx` | Each researcher's **individual, independent** classifications. |
| `Decision.xlsx` | The **consensus** spreadsheet, where disagreements between reviewers were resolved. |
| `ArticleSelection_Sample_CP_RF_SB.xlsx` | The **consolidated *ground truth***. The notebook reads the `Indexes` sheet of this file: column 0 = article ID, column 9 = final classification. This is the file the model learns from. |
| `ArticleSelection_Sample_CP_RF_SB_copia.xlsx` | Backup copy of the above. |
| `df_data.xlsx` / `df_records.xlsx` | **Exports generated by the code itself** (pandas `DataFrames`), joining texts and labels into a table. They exist purely for human inspection — so you can see with your own eyes what is being fed to the model. |

The final corpus is a list of four fields per article:

```
[ index ] [ classification ] [ title ] [ abstract ]
    0             1              2          3
```

Note what was left **out**: the full text of the articles. Screening — both human and
automated — uses **title and abstract only**. That is a deliberate decision: it is how real
reviewers work, and it is what keeps the task feasible.

---

## 3. Results, step by step

Each step below corresponds to a block in the notebook
[notebooks/SVM_LDA_0.2v_passe_25_numTopic_100_enviado_professor.ipynb](notebooks/SVM_LDA_0.2v_passe_25_numTopic_100_enviado_professor.ipynb).

### Step 1 — The corpus is imbalanced

The notebook's first chart, and already bad news:

```
Classification 0 (not relevant): 265
Classification 1 (relevant)....:  62
Ratio..........................: 4.27 : 1
```

![Class counts before balancing](docs/images/01_corpus_desbalanceado.png)

> **How to read it:** each bar is one category. On the left (blue), the 265 articles the
> reviewers marked as **not relevant**; on the right (orange), the 62 **relevant** ones.
> The blue bar is more than 4× taller — and that visual disproportion is what defines the
> problem tackled in the next step.

**The reasoning:** out of every ~5 articles read, only 1 was of interest. That is normal in
a systematic review — but it is poison for a classifier. A lazy model could answer "not
relevant" to everything and be right 81% of the time without having learned anything. Worse:
all of its errors land on the side that hurts most — **discarding an article that was
actually relevant**.

### Step 2 — Balancing with *oversampling*

```
Classification 0: 265
Classification 1: 265
Ratio...........: 1.0 : 1   →   530 articles
```

![Class counts after balancing](docs/images/02_corpus_balanceado.png)

> **How to read it:** the same chart, after oversampling. The two bars are now exactly the
> same height (265 each). No article was removed — the minority bar rose, through the
> statistical replication of 203 "relevant" articles. The corpus went from 327 to 530
> articles.

**The reasoning:** instead of throwing away "not relevant" articles (*undersampling*) —
which, with only 327 texts, would mean discarding information that took 54 hours to produce
— the minority class was statistically replicated, synthesizing 203 additional "relevant"
articles. With a corpus this small, **the choice was to preserve information, not discard
it**.

> This is the decision that weighs most heavily on the final result. The comparison is in
> Step 7.

### Step 3 — Cleaning the text

Tokenization → *stopword* removal → **lemmatization** (reducing each word to its base form)
→ building bigrams and trigrams.

**The reasoning:** *lemmatization* was chosen over *stemming*. Stemming chops words by brute
force ("studies" → "studi"); lemmatization understands the grammar ("studies" → "study").
Since the next step joins words into pairs and triples, **expressions broken in half would
destroy the meaning** — and meaning is precisely what LDA needs to find. Only nouns,
adjectives, verbs, and adverbs were kept.

### Step 4 — Discovering the hidden themes (LDA)

LDA takes a dictionary and a *Bag of Words* and returns topics — each one a weighted list of
words. Two models were trained: one with **gensim's LDA** (`LdaMulticore`) and another with
**MALLET**, a Java implementation recognized for more accurate sampling.

A real example of a discovered topic (MALLET):

```
Topic 0: 0.054*"epilepsy" + 0.042*"life" + 0.029*"related" + 0.029*"quality" + 0.025*"health" …
Topic 3: 0.054*"treatment" + 0.031*"group" + 0.026*"patients" + 0.017*"cancer" + 0.012*"qol" …
```

**The reasoning:** this is readable by a human. Topic 0 is clearly *epilepsy and quality of
life*; topic 3 is *cancer treatment*. That readability is what "black box" models lack, and
it is what justifies LDA in this project.

The same information in visual form — each panel is one topic, and the size of each word is
its weight within that topic:

![Word clouds of the first topics](docs/images/05_wordcloud_topicos.png)

> **How to read it:** **Topic 1** (orange) is unambiguous — *visual, vision, binocular,
> dystrophy*: this is **vision**. **Topic 2** (green) is *epilepsy, qol, child, health*:
> **quality of life in children with epilepsy**. **Topic 3** (red) is more abstract —
> *appraisal, recall, bias, discrepancy* — and corresponds to articles about **questionnaire
> methodology**, not a disease. **Topic 0** (blue), on the other hand, mixes *treatment,
> patients, eating_disorder, bdd, greater, significant*: it is a **diffuse** topic with no
> clear theme. Topics like this are normal and expected — they are the "leftovers" the model
> could not separate, and their presence is one of the signals used to judge whether the
> number of topics is right.

#### The interactive visualization: pyLDAvis

![Intertopic distance map produced by pyLDAvis](docs/images/03_pyldavis_topicos.png)

> **How to read the left panel** (*Intertopic Distance Map*): each **bubble is a topic**.
> The **size** shows what share of the corpus that topic covers; the **distance** between
> bubbles shows how different the themes are from one another (nearby topics share
> vocabulary). The PC1 and PC2 axes have no meaning of their own — they are just the
> two-dimensional projection of a much higher-dimensional space.
>
> **What this chart says:** bubble **1** is enormous and dominates the right-hand side — it
> is the corpus's central theme (quality of life in patients). Bubbles **2, 3, and 4**,
> overlapping it, are variations on the same subject. More important is the **cluster on the
> left**, near the origin: dozens of tiny bubbles piled on top of one another. **That is the
> warning sign** — these are topics the model created that have neither substance nor an
> identity of their own. It is exactly the "too many topics" symptom that motivates the next
> step.
>
> **The right panel** lists the 30 most salient terms in the corpus (*patients, sleep,
> quality, life, health…*). Clicking a bubble makes the bars show, in red, how often those
> terms occur **inside** the selected topic — that is how you confirm what each topic is
> about.
>
> *(Figure from the thesis, p. 64. The visualization is interactive HTML and produces no
> static image; in the notebook it corresponds to execution cell no. 25.)*

### Step 5 — How many topics are "the right number"?

There is no theoretical answer. The practical approach is to train several models and
measure **coherence** (how much the words in each topic actually co-occur in reality). The
coherence-versus-topic-count chart shows the curve rising and then flattening out.

| Number of topics | 2 | 8 | 14 | 20 | 26 | 32 | 38 | 44 |
|---|---|---|---|---|---|---|---|---|
| Coherence — thesis (2020) | 27% | 33% | 33% | 36% | 35% | 36% | 37% | **40%** |
| Coherence — re-run (2026) | 30% | 30% | 32% | 35% | 38% | 38% | **41%** | 40% |

![Coherence curve as a function of the number of topics](docs/images/04_coerencia_topicos.png)

> **How to read it:** the horizontal axis is the number of topics tested; the vertical axis
> is the coherence obtained. The curve **rises quickly up to roughly 20–26 topics** and then
> **flattens** (note the plateau between 26 and 32, and again past 38). Every point on that
> line cost a full LDA model to train — which is why this is the slowest cell in the
> notebook.
>
> *(Chart generated in the 2026 re-run; it corresponds to the bottom row of the table above.)*

**The reasoning:** the chosen value is **not the maximum of the curve**, and that is
intentional. You pick the point where growth *slows down* — because beyond it, new topics
stop being distinct themes and become repeated slices of earlier ones (the same keywords
reappearing across neighboring topics is the red flag). In the original thesis, k = 20 was
the inflection point chosen.

The model is also assessed by **perplexity** (the lower it is, the less "surprised" the
model is by new text) and by a direct comparison between the coherence of plain LDA and that
of LDA + MALLET.

### Step 6 — From topic to decision (TF-IDF + SVM)

LDA produces an enriched corpus: each article now carries, alongside its text, its dominant
topic and that topic's percentage contribution. That corpus goes into the SVM.

- **TF-IDF** converts the text into vectors (`min_df=5`, `max_df=0.8`, `ngram_range=(1,2)`).
- **Grid search** tests combinations of hyperparameters and picks the best by
  cross-validation.
- **k-fold cross-validation with K = 4**: the corpus is split into 4 parts; each one takes a
  turn as the test set while the other 3 train. Result: 354 articles for training and 176
  for testing on every round.

Best configuration found:

```
{'C': 1, 'gamma': 1, 'kernel': 'linear'}
```

**The reasoning:** `kernel='linear'` means a **straight line** is enough to separate relevant
from not relevant. That is good news — more complicated boundaries, with so little data,
would memorize the training set instead of generalizing. And `K = 4` rather than the usual
`K = 10` because, with 530 articles, thinner slices would yield test sets too small to
trust.

### Step 7 — The result that matters: balanced vs. imbalanced

This is the thesis's central finding. The two confusion matrices, side by side:

**Balanced corpus** (530 articles)

```
                      Predicted: Not Rel.   Predicted: Relevant
Actual: Not Relevant          216                   49          ← 49 false positives
Actual: Relevant               33                  232          ← 33 false negatives
```

**Imbalanced corpus** (327 articles, no oversampling)

```
                      Predicted: Not Rel.   Predicted: Relevant
Actual: Not Relevant           81                   82
Actual: Relevant               94                   70          ← 94 false negatives
```

The same balanced matrix as the notebook draws it — the **darker** the cell, the more
articles it holds:

![Confusion matrix for the SVM classifier](docs/images/06_matriz_confusao_svm.png)

> **How to read it:** the rows are the **truth** (what the reviewers decided), the columns
> are the **model's guess**. The **diagonal** — top-left and bottom-right — holds the
> **correct calls**, which is why both are dark blue. The two light corners are the errors,
> and there are few of them. **A perfect classifier would have a dark diagonal and the other
> two corners completely white** — which this matrix very nearly achieves.
>
> *(2026 re-run: `[[221, 44], [38, 227]]`.)*

The same cell also trains a **Naive Bayes** classifier on exactly the same data, for
comparison:

![Confusion matrix for the Naive Bayes classifier](docs/images/07_matriz_confusao_nb.png)

> **How to read it — and why it is interesting:** notice that the top-right corner is almost
> **white**: Naive Bayes almost never labels an article "relevant" when it isn't (98.1%
> precision). But now look at the **bottom row**: the two cells have similar mid-tones,
> meaning it **splits the genuinely relevant articles nearly down the middle** — around 106
> of them end up in the wrong column. That is a recall of only 60%.
>
> In plain terms: Naive Bayes is **too cautious**. When it says "relevant," it is almost
> always right; the trouble is that it lets two out of every five articles that mattered slip
> through. For a systematic review, that is the worst kind of error — and it is exactly why
> **the SVM was the classifier chosen**, despite its lower precision (83.8%).

> ⚠️ **A note for reading the notebook:** in the text output, the matrix printed under the
> heading "classificador naveis bayes" mistakenly shows the SVM's numbers (the wrong variable
> is passed to `print`). **The chart is correct** — it is drawn from the Naive Bayes matrix,
> as are the reported metrics. The slip is in the original 2020 code and was left as is.

| Metric | Imbalanced | Balanced |
|---|---|---|
| Precision | 48.9% | **96.6%** |
| Recall | 40% | **63%** |
| Accuracy | 49% | **81%** |
| F1 score | 45% | **56%** |

**The reasoning — and this is where everything connects:** look at the bottom-left corner of
both matrices. In the imbalanced corpus, **94 relevant articles were thrown out as
irrelevant**. In a systematic review, that is *the* error you cannot afford: a false positive
costs 10 minutes of wasted reading; a false negative costs an important article that nobody
will ever see again. With balancing, that number drops to 33.

This is what validates the decision made back in Step 2.

### Step 8 — Helping the human read faster

Two final layers, which classify nothing — they only save the reviewer time:

- **Summarization** of the abstracts (TextRank, via gensim), so the reviewer gets a sense of
  the article before reading it in full.
- **Named Entity Recognition** (spaCy), highlighting people, organizations, numbers, and
  dates within the abstract.

**The reasoning:** the thesis is explicit on this point, and it bears repeating — **the
classifier does not replace the human reviewer**. It reorders the queue, puts what is likely
to matter at the front, and gives the researcher back the time they would have spent
discarding obvious articles.

### The result in one sentence

> **An estimated 118 days of manual screening → ~45 minutes of automated processing** for
> the same 17,132 articles, with 96.6% precision on the validated sample.

---

## 4. Notes on this re-run (2026)

The notebook was ported so it would run again, six years later. The numbers reproduce
closely, but they are **not identical** to the thesis's — which is expected: library
versions changed, and several steps have a random component (oversampling, k-fold shuffling,
LDA sampling).

| | Thesis (2020) | Re-run (2026) |
|---|---|---|
| Best coherence | 40% (k=44) | 41% (k=38) |
| Perplexity | −14.74 | −7.51 |
| Best SVM hyperparameters | `C=1, gamma=1, linear` | `C=1, gamma=1, linear` (identical) |
| Confusion matrix (balanced) | `[[216, 49], [33, 232]]` | `[[221, 44], [38, 227]]` |

All of the qualitative conclusions hold — and, notably, the grid search once again landed on
exactly the same hyperparameters.

**About the numbers and images in section 3:** the performance metrics quoted are the
**original thesis's**, since those are the ones that were defended. The **embedded charts,
however, were exported from the 2026 re-run**, since those are what the notebook produces
today — with two exceptions flagged in their own captions: the coherence curve carries both
series side by side, and the pyLDAvis bubble map comes from the thesis (p. 64), because it
is an interactive visualization that generates no static image.

---

## 5. Technical decisions

### Why `ldamallet_compat.py` exists

The notebook trains topics with **MALLET** — a Java package, in
`tools/mallet-2.0.8/` — because MALLET produces higher-quality topics
than the pure LDA implementation. gensim never implemented MALLET itself: it only offered a
*wrapper* that wrote files to disk, called the Java binary from the command line, and read
the results back.

That class lived in `gensim.models.wrappers.LdaMallet`. **The `gensim.models.wrappers`
module was removed entirely in gensim 4.0**, with no built-in replacement. The original code
simply stopped starting up:

```python
from gensim.models.wrappers import LdaMallet   # ModuleNotFoundError on gensim 4.x
```

There were three ways out:

1. **Pin the project to gensim 3.8.3** — which would drag along an ancient NumPy and SciPy,
   and make modern Python impossible to use.
2. **Swap MALLET for gensim's plain LDA** — but that would change the results and stop
   reproducing the thesis, which explicitly compares the two.
3. **Bring the class into the project.** ← this is the one.

[notebooks/ldamallet_compat.py](notebooks/ldamallet_compat.py) is the `LdaMallet` class
*vendored* from gensim 3.8.3, with no changes to its logic. It depends only on gensim APIs
that still exist in 4.x (`utils`, `matutils`, `basemodel`), so it works with the current
version. The original license is preserved (**GNU LGPL v2.1**, Radim Řehůřek).

It is a small, stable piece — the MALLET 2.0.8 file format has not changed since 2015 — and
it lets a 2020 notebook run on a 2026 scientific stack **without touching the science**.

### Why Python 3.12

The project is pinned to **3.12.14** ([`.python-version`](.python-version),
[`pyproject.toml`](pyproject.toml)). The reason is practical: 3.12 is the most recent version
on which the **entire** required stack — gensim, spaCy, scikit-learn, pandas, pyLDAvis — is
available together, with prebuilt wheels and no need to compile C extensions from source.

Going higher always depends on the weakest link in the chain, and there are several packages
here with native extensions. Going lower, on the other hand, buys nothing. 3.12 is the point
where the project is both **modern and installable with a single command** — which, for work
that is already six years old, is exactly the property that matters.

---

## 6. How to run it

**Prerequisites:** [uv](https://docs.astral.sh/uv/) and a **Java Runtime** (MALLET is Java —
tested with OpenJDK 21).

```bash
# 1. Install dependencies (creates the .venv and installs Python 3.12.14 if needed)
uv sync

# 2. The spaCy English language model, used for lemmatization and NER
uv run python -m spacy download en_core_web_sm

# 3. Download MALLET 2.0.8 — third-party software, not included in this repository
curl -LO http://mallet.cs.umass.edu/dist/mallet-2.0.8.tar.gz
mkdir -p tools && tar -xzf mallet-2.0.8.tar.gz -C tools && rm mallet-2.0.8.tar.gz
chmod +x tools/mallet-2.0.8/bin/mallet

# 4. Open the notebook
uv run jupyter lab notebooks/
```

> MALLET is not versioned here because it is 26 MB of third-party binaries; its download page is
> [mallet.cs.umass.edu](http://mallet.cs.umass.edu/download.php) if the link above ever moves.
> The only MALLET-related code that belongs to this project is the wrapper in
> [notebooks/ldamallet_compat.py](notebooks/ldamallet_compat.py) (see section 5).

In the notebook, the **first configuration cell** detects the operating system and sets the
paths to `data/xlsx/`, `data/dat/`, and the MALLET binary. **Adjust those paths for your own
machine before running the rest.**

> The notebook also uses the `wordcloud` package in one visualization cell; if you don't have
> it, install it with `uv add wordcloud` or skip that cell.

---

## 7. Project structure

```
TM/
├── data/
│   ├── csv/     Inclusion and exclusion criteria
│   ├── dat/     Raw articles (pickle) + frozen test set
│   └── xlsx/    Manual labeling, consensus, and ground truth
├── docs/
│   ├── Dissertacao_30001171_Michael_Borges_2020.pdf   Original thesis (Portuguese)
│   ├── Thesis_30001171_Michael_Borges_2020_EN.pdf     English edition (reconstructed)
│   ├── thesis-en-src/            Typst sources + figures for the English edition
│   ├── README.pt.md              Portuguese version of this document
│   └── images/                   Charts exported from the notebook (used in this README)
├── notebooks/
│   ├── SVM_LDA_0.2v_passe_25_numTopic_100_enviado_professor.ipynb
│   └── ldamallet_compat.py       MALLET wrapper (see section 5)
├── tools/
│   └── mallet-2.0.8/             MALLET (Java) — downloaded separately, not versioned
├── pyproject.toml
└── .python-version
```

---

## 8. Quick glossary

| Term | In plain language |
|---|---|
| **Systematic review (SR)** | Reading and summarizing *everything* already published on a scientific question, following explicit rules. |
| **Screening** | Deciding, from title and abstract alone, which articles are worth reading. |
| ***Corpus*** | The collection of texts being worked with. |
| ***Ground truth*** | The labels assigned by humans, which serve as the machine's answer key. |
| **TF-IDF** | Turning text into numbers, favoring the words that set one text apart from the others. |
| **LDA** | An algorithm that discovers, on its own, the hidden themes in a collection of texts. |
| **SVM** | A classifier that draws the best possible boundary between two categories. |
| ***Oversampling*** | Replicating examples from the rare category to balance the data. |
| **Coherence** | A measure of how well the words in a topic "belong together." Higher is better. |
| **Perplexity** | A measure of how "surprised" the model is by new text. Lower is better. |
| **False negative** | A relevant article the model discarded. **The most expensive error here.** |
| **Cross-validation (k-fold)** | Splitting the data into k parts and testing k times, so the result doesn't hinge on one lucky split. |
| **NER** | Named Entity Recognition: automatically highlighting people, places, dates, and numbers in a text. |

---

## License and credits

The academic work is by **Michael Dionísio Borges** (Universidade Autónoma de Lisboa, 2020).
The code in this repository is released under the **MIT License** — see [LICENSE](LICENSE).

The data under [data/](data/) and the thesis PDFs under [docs/](docs/) are research material,
not code: cite the dissertation if you use them.

[notebooks/ldamallet_compat.py](notebooks/ldamallet_compat.py) derives from gensim 3.8.3
(© Radim Řehůřek) and retains the **GNU LGPL v2.1** license.
[MALLET](http://mallet.cs.umass.edu/) is distributed under the **Common Public License**.
