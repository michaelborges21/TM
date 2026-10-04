#import "lib.typ": *

= Annex

Script used to collect the articles coming from PubMed.

#text(size: 9pt, raw(read("annex_script.py"), lang: "python", block: true))

#pagebreak()

List of keywords used in the script in order to access the articles coming from PubMed.

#set par(first-line-indent: 0pt)
#set text(size: 9.5pt)
#table(
  columns: (1fr, 1.25fr, 1.15fr),
  stroke: 0.4pt,
  inset: 4pt,
  align: left,
  table.header([*Symptoms / Manifestations*], [*AND PRO term*], [*AND QoL Terms*]),
  [Cardiomyopathy], [Patient reported outcomes], [Quality of Life],
  [Pericardial effusion], [Patient reported outcome measures], [Health related quality of life],
  [Hepatomegaly], [Observer reported outcomes], [HRQOL],
  [Cirrhosis], [Observer reported outcome measures], [Disease specific quality of life],
  [Liver fibrosis], [Caregiver reported outcomes], [Symptom specific quality of life],
  [Steatosis], [Caregiver reported outcomes measures], [],
  [Feeding problems], [Patient centered outcomes], [],
  [Feeding difficulties], [Patient centred outcomes], [],
  [Gastrostomy], [Proxy reported outcomes], [],
  [G-tube], [proxy reported outcome measures], [],
  [Enteral feeding], [], [],
  [Diarrhea], [], [],
  [Vomiting], [], [],
  [Renal cysts], [], [],
  [Nephrotic syndrome], [], [],
  [Tubulopathy], [], [],
  [Osteopenia], [], [],
  [Kyphosis], [], [],
  [Scoliosis], [], [],
  [Joint contractures], [], [],
  [Hypotonia], [], [],
  [Psychomotor retardation], [], [],
  [Ataxia], [], [],
  [Hyporeflexia], [], [],
  [Stroke-like episodes], [], [],
  [Seizures], [], [],
  [Epilepsy], [], [],
  [Cerebellar hypoplasia], [], [],
  [Peripheral neuropathy], [], [],
  [Hypothyroidism], [], [],
  [Hypogonadism], [], [],
  [Thrombosis], [], [],
  [Development delay], [], [],
  [infections], [], [],
  [intelectual disability], [], [],
  [sleep disturbances], [], [],
  [strabismus], [], [],
  [retinitis pigmentosa], [], [],
  [nystagmus], [], [],
  [blindness], [], [],
  [behavioural problems], [], [],
  [behavioral problems], [], [],
  [behaviour], [], [],
  [behavior], [], [],
  [autism], [], [],
  [mood swings], [], [],
  [hyperinsulinemic], [], [],
  [hypoglicemia], [], [],
  [functional disability], [], [],
  [physical disability], [], [],
)
#set text(size: 12pt)

#v(1em)
Link to the code and #emph[corpus] used in the dissertation:

#text(size: 10.5pt, link("https://github.com/michaelborges21/AUTOMATIC-LEARNING-TO-SUPPORT-SYSTEMATIC-LITERATURE-REVIEW"))
