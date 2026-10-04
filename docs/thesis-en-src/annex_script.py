import pandas as pd
import numpy as np
import pickle
from Bio import Entrez, Medline

file_loc = "keywordsbulk.xls"
df = pd.read_excel(file_loc, na_values=['NA'], usecols = "A")
df=df.dropna()
alpha = df['Alpha'].tolist()

df = pd.read_excel(file_loc, na_values=['NA'], usecols = "B")
df=df.dropna()
beta = df['Beta'].tolist()

df = pd.read_excel(file_loc, na_values=['NA'], usecols = "C")
df=df.dropna()
gamma = df['Gamma'].tolist()

tripleterms = []
for i in alpha:
   for j in beta:
      for k in gamma:
         aterm = i.lower() + ' ' + j.lower() + ' ' + k.lower()
         tripleterms.append(aterm)

doubleterms = []
for i in alpha:
  for j in beta:
      aterm = i.lower() + ' ' + j.lower()
      doubleterms.append(aterm)

allterms = tripleterms + doubleterms


Entrez.email = "goncalovaladao@gmail.com"
allpmids = []

for ttt in allterms:
  handle = Entrez.esearch(db='pubmed',
                    sort='relevance',
                    retmax='20',
                    term=ttt,
                    usehistory="y")


  pmids = Entrez.read(handle)['IdList']
  allpmids.extend(pmids)

allpmids = list(set(allpmids))

out_handle = open("auxiliary.txt", "w")

allpmidsaux = ','.join(allpmids)
fetch_handle = Entrez.efetch(db='pubmed',
               rettype='medline',
               retmode='text',
              id=allpmidsaux)
data = fetch_handle.read()
fetch_handle.close()
out_handle.write(data)
out_handle.close()

with open("auxiliary.txt") as auxilhandle:
     therecords = Medline.parse(auxilhandle)
     recordslst = list(therecords)

auxilhandle.close()


with open('papers.dat','wb') as filename:
  pickle.dump(recordslst, filename)
