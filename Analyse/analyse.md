Consolidation OSIS-SAU (Novembre 2013)
========================================================

Fichier origine:

NB: utiliser le fichier **data4.csv** pour les modifications.

Fichier .csv: le fichier source est enregistré sous le nom de data3 avec les options:
- UTF8
- mettre des guillements autour des nom (sinon plantage à la lecture de R)
- séparateur = ';'

- SR serveur régional
- NR non réponse
- NA non disponible (Non Avalaible)
- INVS envoi direct à l'INVS
- INFORM. Le SU est-il informatisé ? (oui/non)
- CAPA Capacité à renvoyer des RPU ? (oui/non)

#### 2014-04-28 
__data4.csv__ enregistrement du fichier source au format .csv. Ajout des logiciels pour Champagne-Ardennes et complément pour Basse-Normandie

#### Juin 2014

ENQUETE LOGICIEL su_France.csv
fichier principal partage sur drive 
Enregistre dans le dossier sous le nom de __ENQUETE LOGICIEL su_France.csv__. Il semblerait qu'il ne soit plus possible d'exporter directement au format csv.

Creation de __functions.R__ pour normaliser les noms des logiciels. Creation  de __Logiciels.ods__ pour lister les logiciels existants et les firme correspondantes.




```r
library("epicalc")
```

```
## Loading required package: foreign
## Loading required package: survival
## Loading required package: splines
## Loading required package: MASS
## Loading required package: nnet
```

```r
# obsolete
# file <- "../DATA/data4.csv"
# d <- read.table(file, header = TRUE, sep = ";")

file <- "ENQUETE LOGICIEL su_France.csv"
d <- read.csv(file, header = TRUE)

d$INFORM.[d$INFORM. == ""] <- NA
d$INFORM. <- factor(d$INFORM.)

nrow(d)
```

```
## [1] 532
```

```r
names(d)
```

```
## [1] "REGION"         "Raison.sociale" "Nom.ES.usité"   "FINESS"        
## [5] "RPU.CAPA"       "RPU.QUI"        "LOGICIEL"       "INFORM."
```

```r
str(d)
```

```
## 'data.frame':	532 obs. of  8 variables:
##  $ REGION        : Factor w/ 22 levels "Alsace","Aquitaine",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Raison.sociale: Factor w/ 528 levels "","AMERICAN MEMORIAL HOSPITAL CHU REIMS",..: 471 5 349 380 378 59 301 258 101 423 ...
##  $ Nom.ES.usité  : Factor w/ 526 levels "","Alpha Santé - C.H. de Mont Saint-Martin",..: 477 25 366 394 392 143 202 252 204 430 ...
##  $ FINESS        : Factor w/ 528 levels "","100000090",..: 317 318 319 320 321 322 323 324 325 326 ...
##  $ RPU.CAPA      : Factor w/ 25 levels "","autre","expert santé",..: 12 NA 7 7 7 12 12 12 12 12 ...
##  $ RPU.QUI       : Factor w/ 41 levels ""," ","En attente réponse directrice",..: 8 NA 31 31 31 8 8 8 8 8 ...
##  $ LOGICIEL      : Factor w/ 47 levels "","Atalante",..: 17 17 NA 17 29 36 17 2 7 17 ...
##  $ INFORM.       : Factor w/ 12 levels "N/A","non","Non",..: NA 5 5 5 5 5 5 5 5 5 ...
```

```r

# colonne LOGICIEL
a <- as.character(d$LOGICIEL)
a[a == ""] <- NA
a[a == "autre"] <- NA
a[a == "Christalnet (module DMU)"] <- "Cristalnet"
a[a == "Clinicom (Siemens)"] <- "Clinicom"
a[a == "CORA McKesson"] <- "Cora"
a[a == "CrystalNet"] <- "Cristalnet"
a[a == "DMU (CristalNet)"] <- "Cristalnet"

a[a == "RESURGENCE"] <- "ResUrgences"
a[a == "Resurgences"] <- "ResUrgences"
a[a == "RESURGENCE (Adulte) DxCare Medasys (Pédiatrie)"] <- "ResUrgences"
a[a == "urqual"] <- "UrQual"
a[a == "UrQual (McKesson)"] <- "UrQual"
a[a == "Urqual (McKesson)"] <- "UrQual"

a[a == "Cristalnet"] <- "CristalNet"
a[a == "CORA"] <- "Cora"
a[a == "CLINICOM (Creil)"] <- "Clinicom"

a[a == "DxCare (Medasys)"] <- "DXCare"
a[a == "DXCARE (Medasys)"] <- "DXCare"
a[a == "DxCare MEDASYS"] <- "DXCare"
a[a == "dxcare (vittel)"] <- "DXCare"
a[a == "DxCare"] <- "DXCare"

a[a == "hopital manager"] <- "Hopital Manager"
a[a == "Osiris (Cormin)"] <- "Osiris"
a[a == "OSIRIS Evolucare"] <- "Osiris"
a[a == "OSOFT"] <- "Osoft"
a[a == "ﾠ"] <- NA
a[a == "cf ch lodeve"] <- NA
a[a == "Etablissement prioritaire !"] <- NA
a[a == "Pas de SAU"] <- NA
a[!is.na(a) & nchar(a) < 3] <- NA
d$LOGICIEL <- a

levels(as.factor(d$LOGICIEL))
```

```
##  [1] "Atalante"                 "Axigate"                 
##  [3] "Clinicom"                 "Cora"                    
##  [5] "CristalNet"               "Diamm Micro6"            
##  [7] "Dopa Urgences"            "DXCare"                  
##  [9] "emed"                     "expert santé"            
## [11] "Hopital Manager"          "Inclus dans GHPSO"       
## [13] "Millenium (Cerner)"       "myvisit"                 
## [15] "Orbis"                    "Osiris"                  
## [17] "Osoft"                    "Polymedis"               
## [19] "ResUrgences"              "Sillage"                 
## [21] "TechnoWeb (dev int)"      "Track Care (InterSystem)"
## [23] "TU-OruPaca"               "UrQual"
```

```r

summary(d$REGION)
```

```
##             Alsace          Aquitaine           Auvergne 
##                 20                 34                 16 
##         Basse-Nor.          Bourgogne           Bretagne 
##                 23                 24                 31 
##             Centre         Champ.Ard.              Corse 
##                 29                 16                  4 
##      Franche-Comté         Guadeloupe    Haute-Normandie 
##                 13                  5                 21 
##                IDF          Languedoc           Limousin 
##                 99                 32                 10 
##           Lorraine         Martinique      Midi-Pyrénées 
##                 28                  6                 37 
## Nord Pas-de-Calais      Pays de Loire           Picardie 
##                 32                 25                 24 
##            Réunion 
##                  3
```

```r
barplot(summary(d$REGION), main = "Nombre d'établissements avec service d'urgence", 
    ylab = "Nombre", las = 3)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-11.png) 

```r

summary(d$RPU.CAPA)
```

```
##                                 autre       expert santé 
##                136                  1                  1 
##                N/A                non                Non 
##                  4                 17                 24 
##               Non                 NON      Non renseigné 
##                  4                 11                  9 
##               non                 oui                Oui 
##                  5                 24                164 
##               Oui                 OUi                OUI 
##                  1                  2                 70 
##               oui      pas de réponse rattaché à belfort 
##                  2                  1                  1 
##               SMUR                non                Non 
##                  3                  3                  1 
##               Non                 oui                Oui 
##                  1                 17                 14 
##                OUI               NA's 
##                  3                 13
```

```r
t <- table(d$REGION, d$RPU.CAPA)
t
```

```
##                     
##                         autre expert santé N/A non Non Non  NON
##   Alsace              0     0            0   0   0   0    4   0
##   Aquitaine           0     0            0   0   0   0    0  11
##   Auvergne            0     0            0   0   0   0    0   0
##   Basse-Nor.          4     0            0   0   0   1    0   0
##   Bourgogne          20     0            0   0   0   0    0   0
##   Bretagne            0     0            0   0   0   3    0   0
##   Centre             20     0            0   0   0   0    0   0
##   Champ.Ard.          7     0            0   0   0   0    0   0
##   Corse               0     0            0   0   0   0    0   0
##   Franche-Comté       0     0            0   0   0   0    0   0
##   Guadeloupe          0     0            0   0   0   0    0   0
##   Haute-Normandie     7     0            0   0   0   2    0   0
##   IDF                63     0            0   0   0   6    0   0
##   Languedoc           3     1            1   0   0   0    0   0
##   Limousin            0     0            0   0   0   0    0   0
##   Lorraine            5     0            0   0   0   0    0   0
##   Martinique          4     0            0   0   0   0    0   0
##   Midi-Pyrénées       0     0            0   0   0   0    0   0
##   Nord Pas-de-Calais  1     0            0   0  17   0    0   0
##   Pays de Loire       2     0            0   0   0   0    0   0
##   Picardie            0     0            0   4   0  12    0   0
##   Réunion             0     0            0   0   0   0    0   0
##                     
##                      Non renseigné non  oui Oui Oui  OUi OUI oui 
##   Alsace                         0    0   0  14    0   0   0    0
##   Aquitaine                      0    0   0   0    0   0  23    0
##   Auvergne                       0    0   0   9    0   0   0    0
##   Basse-Nor.                     0    0   2  16    0   0   0    0
##   Bourgogne                      0    0   0   4    0   0   0    0
##   Bretagne                       0    0   0  13    0   0   0    0
##   Centre                         2    0   0   7    0   0   0    0
##   Champ.Ard.                     0    0   0   9    0   0   0    0
##   Corse                          0    0   4   0    0   0   0    0
##   Franche-Comté                  0    0   0  10    0   0   0    0
##   Guadeloupe                     0    0   0   0    0   0   0    0
##   Haute-Normandie                0    0   0  12    0   0   0    0
##   IDF                            7    0   0  23    0   0   0    0
##   Languedoc                      0    0   0  22    1   0   0    0
##   Limousin                       0    0   0   0    0   0  10    0
##   Lorraine                       0    0   2  19    0   0   0    0
##   Martinique                     0    0   1   0    0   0   0    0
##   Midi-Pyrénées                  0    0   0   0    0   0  37    0
##   Nord Pas-de-Calais             0    0  14   0    0   0   0    0
##   Pays de Loire                  0    5   1   0    0   0   0    2
##   Picardie                       0    0   0   6    0   2   0    0
##   Réunion                        0    0   0   0    0   0   0    0
##                     
##                      pas de réponse rattaché à belfort SMUR  non  Non
##   Alsace                          0                  0    0    0    0
##   Aquitaine                       0                  0    0    0    0
##   Auvergne                        0                  0    0    0    0
##   Basse-Nor.                      0                  0    0    0    0
##   Bourgogne                       0                  0    0    0    0
##   Bretagne                        0                  0    0    0    1
##   Centre                          0                  0    0    0    0
##   Champ.Ard.                      0                  0    0    0    0
##   Corse                           0                  0    0    0    0
##   Franche-Comté                   0                  1    2    0    0
##   Guadeloupe                      0                  0    0    0    0
##   Haute-Normandie                 0                  0    0    0    0
##   IDF                             0                  0    0    0    0
##   Languedoc                       0                  0    0    0    0
##   Limousin                        0                  0    0    0    0
##   Lorraine                        0                  0    1    0    0
##   Martinique                      1                  0    0    0    0
##   Midi-Pyrénées                   0                  0    0    0    0
##   Nord Pas-de-Calais              0                  0    0    0    0
##   Pays de Loire                   0                  0    0    3    0
##   Picardie                        0                  0    0    0    0
##   Réunion                         0                  0    0    0    0
##                     
##                       Non   oui  Oui  OUI
##   Alsace                 0    0    0    0
##   Aquitaine              0    0    0    0
##   Auvergne               0    0    7    0
##   Basse-Nor.             0    0    0    0
##   Bourgogne              0    0    0    0
##   Bretagne               1    5    7    0
##   Centre                 0    0    0    0
##   Champ.Ard.             0    0    0    0
##   Corse                  0    0    0    0
##   Franche-Comté          0    0    0    0
##   Guadeloupe             0    0    0    0
##   Haute-Normandie        0    0    0    0
##   IDF                    0    0    0    0
##   Languedoc              0    0    0    0
##   Limousin               0    0    0    0
##   Lorraine               0    0    0    0
##   Martinique             0    0    0    0
##   Midi-Pyrénées          0    0    0    0
##   Nord Pas-de-Calais     0    0    0    0
##   Pays de Loire          0   12    0    0
##   Picardie               0    0    0    0
##   Réunion                0    0    0    3
```

```r
barplot(t(t), las = 3)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-12.png) 

```r

```


Analyse globale
===============

Informatisation des urgences
----------------------------
La question n'a été posée qu'aux régions suivantes:
- Martinique
- Midi-Pyrénées
- Nord Pas de Calais
- Pays de Loire
- Picardie
- Poitou-Charentes
- PACA
- Rhone-Alpes
- Guyane


```r
table(d$REGION, d$INFORM., useNA = "always")
```

```
##                     
##                      N/A non Non NON oui Oui OUi OUI pas de réponse  non
##   Alsace               0   1   0   0  18   0   0   0              0    0
##   Aquitaine            0   0   0   0   0   0   0   0              0    0
##   Auvergne             0   0   0   0   0   0   0   0              0    0
##   Basse-Nor.           0   0   0   0   0   0   0   0              0    0
##   Bourgogne            0   0   0   0   0   0   0   0              0    0
##   Bretagne             0   0   0   0   0   0   0   0              0    0
##   Centre               0   0   0   0   0   0   0   0              0    0
##   Champ.Ard.           0   0   0   0   0   0   0   0              0    0
##   Corse                0   0   0   0   0   0   0   0              0    0
##   Franche-Comté        0   0   0   0   0   0   0   0              0    0
##   Guadeloupe           0   0   0   0   0   0   0   0              0    0
##   Haute-Normandie      0   0   0   0   0   0   0   0              0    0
##   IDF                  0   0   0   0   0   0   0   0              0    0
##   Languedoc            0   0   0   0   0   0   0   0              0    0
##   Limousin             0   0   0   0   0   0   0   0              0    0
##   Lorraine             0   0   0   0   0   0   0   0              0    0
##   Martinique           0   0   0   0   1   0   0   0              1    0
##   Midi-Pyrénées        0   0   0  18   0   0   0  19              0    0
##   Nord Pas-de-Calais   0   8   0   0  23   0   0   0              0    0
##   Pays de Loire        0   0   0   0   0   0   0   0              0    1
##   Picardie             4   0   3   0   0  14   3   0              0    0
##   Réunion              0   0   0   0   0   0   0   0              0    0
##   <NA>                 0   0   0   0   0   0   0   0              0    0
##                     
##                       oui  pas de remplissage OSIS <NA>
##   Alsace                0                        0    1
##   Aquitaine             0                        0   34
##   Auvergne              0                        0   16
##   Basse-Nor.            0                        0   23
##   Bourgogne             0                        0   24
##   Bretagne              0                        0   31
##   Centre                0                        0   29
##   Champ.Ard.            0                        0   16
##   Corse                 0                        0    4
##   Franche-Comté         0                        0   13
##   Guadeloupe            0                        0    5
##   Haute-Normandie       0                        0   21
##   IDF                   0                        0   99
##   Languedoc             0                        0   32
##   Limousin              0                        0   10
##   Lorraine              0                        0   28
##   Martinique            0                        0    4
##   Midi-Pyrénées         0                        0    0
##   Nord Pas-de-Calais    0                        0    1
##   Pays de Loire        23                        1    0
##   Picardie              0                        0    0
##   Réunion               0                        0    3
##   <NA>                  0                        0    0
```


Capacité à remonter des RPU
---------------------------


```r
table(d$REGION, d$RPU.CAPA, useNA = "always")
```

```
##                     
##                         autre expert santé N/A non Non Non  NON
##   Alsace              0     0            0   0   0   0    4   0
##   Aquitaine           0     0            0   0   0   0    0  11
##   Auvergne            0     0            0   0   0   0    0   0
##   Basse-Nor.          4     0            0   0   0   1    0   0
##   Bourgogne          20     0            0   0   0   0    0   0
##   Bretagne            0     0            0   0   0   3    0   0
##   Centre             20     0            0   0   0   0    0   0
##   Champ.Ard.          7     0            0   0   0   0    0   0
##   Corse               0     0            0   0   0   0    0   0
##   Franche-Comté       0     0            0   0   0   0    0   0
##   Guadeloupe          0     0            0   0   0   0    0   0
##   Haute-Normandie     7     0            0   0   0   2    0   0
##   IDF                63     0            0   0   0   6    0   0
##   Languedoc           3     1            1   0   0   0    0   0
##   Limousin            0     0            0   0   0   0    0   0
##   Lorraine            5     0            0   0   0   0    0   0
##   Martinique          4     0            0   0   0   0    0   0
##   Midi-Pyrénées       0     0            0   0   0   0    0   0
##   Nord Pas-de-Calais  1     0            0   0  17   0    0   0
##   Pays de Loire       2     0            0   0   0   0    0   0
##   Picardie            0     0            0   4   0  12    0   0
##   Réunion             0     0            0   0   0   0    0   0
##   <NA>                0     0            0   0   0   0    0   0
##                     
##                      Non renseigné non  oui Oui Oui  OUi OUI oui 
##   Alsace                         0    0   0  14    0   0   0    0
##   Aquitaine                      0    0   0   0    0   0  23    0
##   Auvergne                       0    0   0   9    0   0   0    0
##   Basse-Nor.                     0    0   2  16    0   0   0    0
##   Bourgogne                      0    0   0   4    0   0   0    0
##   Bretagne                       0    0   0  13    0   0   0    0
##   Centre                         2    0   0   7    0   0   0    0
##   Champ.Ard.                     0    0   0   9    0   0   0    0
##   Corse                          0    0   4   0    0   0   0    0
##   Franche-Comté                  0    0   0  10    0   0   0    0
##   Guadeloupe                     0    0   0   0    0   0   0    0
##   Haute-Normandie                0    0   0  12    0   0   0    0
##   IDF                            7    0   0  23    0   0   0    0
##   Languedoc                      0    0   0  22    1   0   0    0
##   Limousin                       0    0   0   0    0   0  10    0
##   Lorraine                       0    0   2  19    0   0   0    0
##   Martinique                     0    0   1   0    0   0   0    0
##   Midi-Pyrénées                  0    0   0   0    0   0  37    0
##   Nord Pas-de-Calais             0    0  14   0    0   0   0    0
##   Pays de Loire                  0    5   1   0    0   0   0    2
##   Picardie                       0    0   0   6    0   2   0    0
##   Réunion                        0    0   0   0    0   0   0    0
##   <NA>                           0    0   0   0    0   0   0    0
##                     
##                      pas de réponse rattaché à belfort SMUR  non  Non
##   Alsace                          0                  0    0    0    0
##   Aquitaine                       0                  0    0    0    0
##   Auvergne                        0                  0    0    0    0
##   Basse-Nor.                      0                  0    0    0    0
##   Bourgogne                       0                  0    0    0    0
##   Bretagne                        0                  0    0    0    1
##   Centre                          0                  0    0    0    0
##   Champ.Ard.                      0                  0    0    0    0
##   Corse                           0                  0    0    0    0
##   Franche-Comté                   0                  1    2    0    0
##   Guadeloupe                      0                  0    0    0    0
##   Haute-Normandie                 0                  0    0    0    0
##   IDF                             0                  0    0    0    0
##   Languedoc                       0                  0    0    0    0
##   Limousin                        0                  0    0    0    0
##   Lorraine                        0                  0    1    0    0
##   Martinique                      1                  0    0    0    0
##   Midi-Pyrénées                   0                  0    0    0    0
##   Nord Pas-de-Calais              0                  0    0    0    0
##   Pays de Loire                   0                  0    0    3    0
##   Picardie                        0                  0    0    0    0
##   Réunion                         0                  0    0    0    0
##   <NA>                            0                  0    0    0    0
##                     
##                       Non   oui  Oui  OUI <NA>
##   Alsace                 0    0    0    0    2
##   Aquitaine              0    0    0    0    0
##   Auvergne               0    0    7    0    0
##   Basse-Nor.             0    0    0    0    0
##   Bourgogne              0    0    0    0    0
##   Bretagne               1    5    7    0    1
##   Centre                 0    0    0    0    0
##   Champ.Ard.             0    0    0    0    0
##   Corse                  0    0    0    0    0
##   Franche-Comté          0    0    0    0    0
##   Guadeloupe             0    0    0    0    5
##   Haute-Normandie        0    0    0    0    0
##   IDF                    0    0    0    0    0
##   Languedoc              0    0    0    0    4
##   Limousin               0    0    0    0    0
##   Lorraine               0    0    0    0    1
##   Martinique             0    0    0    0    0
##   Midi-Pyrénées          0    0    0    0    0
##   Nord Pas-de-Calais     0    0    0    0    0
##   Pays de Loire          0   12    0    0    0
##   Picardie               0    0    0    0    0
##   Réunion                0    0    0    3    0
##   <NA>                   0    0    0    0    0
```


Où vont les remontés les RPU ?
-----------------------------


```r
summary(d$RPU.QUI)
```

```
##                                                                         
##                                                                     145 
##                                                                         
##                                                                       1 
##                                           En attente réponse directrice 
##                                                                       1 
##                                                                   Envoi 
##                                                                       1 
##                                                        \nEnvoi à l'INVS 
##                                                                       1 
##                                                          Envoi à l'INVS 
##                                                                       1 
##                                               envoi au serveur régional 
##                                                                       1 
##                                               envoi au serveur régional 
##                                                                     121 
##                                               Envoi au serveur régional 
##                                                                       4 
##                                                  envoi des RPU à l'INVS 
##                                                                       3 
##                                                   envoi direct à l'INVS 
##                                                                      32 
##                                                   Envoi direct à l'INVS 
##                                                                       1 
##                                                              Envoi INVS 
##                                                                       1 
## Informatisation avec le nouveau progiciel initialement prévue mars 2014 
##                                                                       1 
##                                                                     N/A 
##                                                                       4 
##                                                                     non 
##                                                                      21 
##                                                                     Non 
##                                                                      12 
##                                                                     NON 
##                                                                       4 
##                                                                     oui 
##                                                                      13 
##                                                                     Oui 
##                                                                       6 
##                                                                     OUi 
##                                                                       2 
##                                     OUI InVS et serveur régional ORULIM 
##                                                                      10 
##                                                                oui -SIB 
##                                                                       1 
##                                                             pas d'envoi 
##                                                                      47 
##                                                             Pas d’envoi 
##                                                                       5 
##                                  pas d'envoi- le CH a saisi son éditeur 
##                                                                       1 
##               pas d'envoi- mise en place de SILLAGE Urgences prévu 2014 
##                                                                       1 
##                 pas d'envoi - obstacles à lever au plan organisationnel 
##                                                                       1 
##                                              Serveur régional et  InVS  
##                                                                       1 
##                                                                      SR 
##                                                                      33 
##                                                                         
##                                                                       3 
##                                               envoi au serveur régional 
##                                                                       7 
##                                               Envoi au serveur régional 
##                                                                       5 
##                                                   envoi direct à l'INVS 
##                                                                       2 
##                                                                 non-SIB 
##                                                                      14 
##                                                               oui -INVS 
##                                                                       1 
##                                                                oui -SIB 
##                                                                       1 
##                                                                 oui-SIB 
##                                                                       8 
##                                                             pas d'envoi 
##                                                                       1 
##                 pas d'envoi - obstacles à lever au plan organisationnel 
##                                                                       1 
##                                              Serveur régional et  InVS  
##                                                                       2 
##                                                                    NA's 
##                                                                      11
```

```r
table(d$REGION, d$RPU.QUI, useNA = "always")
```

```
##                     
##                            En attente réponse directrice Envoi
##   Alsace              1  1                             0     0
##   Aquitaine           0  0                             0     0
##   Auvergne            0  0                             0     0
##   Basse-Nor.          4  0                             0     0
##   Bourgogne          20  0                             0     0
##   Bretagne            1  0                             0     1
##   Centre             20  0                             0     0
##   Champ.Ard.          7  0                             0     0
##   Corse               0  0                             0     0
##   Franche-Comté       3  0                             0     0
##   Guadeloupe          0  0                             0     0
##   Haute-Normandie     1  0                             1     0
##   IDF                63  0                             0     0
##   Languedoc          11  0                             0     0
##   Limousin            0  0                             0     0
##   Lorraine            8  0                             0     0
##   Martinique          5  0                             0     0
##   Midi-Pyrénées       0  0                             0     0
##   Nord Pas-de-Calais  1  0                             0     0
##   Pays de Loire       0  0                             0     0
##   Picardie            0  0                             0     0
##   Réunion             0  0                             0     0
##   <NA>                0  0                             0     0
##                     
##                      \nEnvoi à l'INVS Envoi à l'INVS
##   Alsace                            0              0
##   Aquitaine                         0              0
##   Auvergne                          0              0
##   Basse-Nor.                        1              1
##   Bourgogne                         0              0
##   Bretagne                          0              0
##   Centre                            0              0
##   Champ.Ard.                        0              0
##   Corse                             0              0
##   Franche-Comté                     0              0
##   Guadeloupe                        0              0
##   Haute-Normandie                   0              0
##   IDF                               0              0
##   Languedoc                         0              0
##   Limousin                          0              0
##   Lorraine                          0              0
##   Martinique                        0              0
##   Midi-Pyrénées                     0              0
##   Nord Pas-de-Calais                0              0
##   Pays de Loire                     0              0
##   Picardie                          0              0
##   Réunion                           0              0
##   <NA>                              0              0
##                     
##                       envoi au serveur régional envoi au serveur régional
##   Alsace                                      0                        13
##   Aquitaine                                   0                        21
##   Auvergne                                    1                         8
##   Basse-Nor.                                  0                         0
##   Bourgogne                                   0                         2
##   Bretagne                                    0                         8
##   Centre                                      0                         6
##   Champ.Ard.                                  0                         7
##   Corse                                       0                         4
##   Franche-Comté                               0                        10
##   Guadeloupe                                  0                         0
##   Haute-Normandie                             0                         0
##   IDF                                         0                         9
##   Languedoc                                   0                        14
##   Limousin                                    0                         0
##   Lorraine                                    0                        19
##   Martinique                                  0                         0
##   Midi-Pyrénées                               0                         0
##   Nord Pas-de-Calais                          0                         0
##   Pays de Loire                               0                         0
##   Picardie                                    0                         0
##   Réunion                                     0                         0
##   <NA>                                        0                         0
##                     
##                      Envoi au serveur régional envoi des RPU à l'INVS
##   Alsace                                     0                      0
##   Aquitaine                                  0                      0
##   Auvergne                                   0                      0
##   Basse-Nor.                                 0                      3
##   Bourgogne                                  0                      0
##   Bretagne                                   4                      0
##   Centre                                     0                      0
##   Champ.Ard.                                 0                      0
##   Corse                                      0                      0
##   Franche-Comté                              0                      0
##   Guadeloupe                                 0                      0
##   Haute-Normandie                            0                      0
##   IDF                                        0                      0
##   Languedoc                                  0                      0
##   Limousin                                   0                      0
##   Lorraine                                   0                      0
##   Martinique                                 0                      0
##   Midi-Pyrénées                              0                      0
##   Nord Pas-de-Calais                         0                      0
##   Pays de Loire                              0                      0
##   Picardie                                   0                      0
##   Réunion                                    0                      0
##   <NA>                                       0                      0
##                     
##                      envoi direct à l'INVS Envoi direct à l'INVS
##   Alsace                                 1                     0
##   Aquitaine                              0                     0
##   Auvergne                               0                     0
##   Basse-Nor.                            12                     0
##   Bourgogne                              2                     0
##   Bretagne                               1                     0
##   Centre                                 0                     0
##   Champ.Ard.                             0                     0
##   Corse                                  0                     0
##   Franche-Comté                          0                     0
##   Guadeloupe                             0                     0
##   Haute-Normandie                        8                     1
##   IDF                                    7                     0
##   Languedoc                              1                     0
##   Limousin                               0                     0
##   Lorraine                               0                     0
##   Martinique                             0                     0
##   Midi-Pyrénées                          0                     0
##   Nord Pas-de-Calais                     0                     0
##   Pays de Loire                          0                     0
##   Picardie                               0                     0
##   Réunion                                0                     0
##   <NA>                                   0                     0
##                     
##                      Envoi INVS
##   Alsace                      0
##   Aquitaine                   0
##   Auvergne                    0
##   Basse-Nor.                  0
##   Bourgogne                   0
##   Bretagne                    0
##   Centre                      0
##   Champ.Ard.                  0
##   Corse                       0
##   Franche-Comté               0
##   Guadeloupe                  0
##   Haute-Normandie             1
##   IDF                         0
##   Languedoc                   0
##   Limousin                    0
##   Lorraine                    0
##   Martinique                  0
##   Midi-Pyrénées               0
##   Nord Pas-de-Calais          0
##   Pays de Loire               0
##   Picardie                    0
##   Réunion                     0
##   <NA>                        0
##                     
##                      Informatisation avec le nouveau progiciel initialement prévue mars 2014
##   Alsace                                                                                   0
##   Aquitaine                                                                                0
##   Auvergne                                                                                 0
##   Basse-Nor.                                                                               0
##   Bourgogne                                                                                0
##   Bretagne                                                                                 0
##   Centre                                                                                   0
##   Champ.Ard.                                                                               0
##   Corse                                                                                    0
##   Franche-Comté                                                                            0
##   Guadeloupe                                                                               0
##   Haute-Normandie                                                                          1
##   IDF                                                                                      0
##   Languedoc                                                                                0
##   Limousin                                                                                 0
##   Lorraine                                                                                 0
##   Martinique                                                                               0
##   Midi-Pyrénées                                                                            0
##   Nord Pas-de-Calais                                                                       0
##   Pays de Loire                                                                            0
##   Picardie                                                                                 0
##   Réunion                                                                                  0
##   <NA>                                                                                     0
##                     
##                      N/A non Non NON oui Oui OUi
##   Alsace               0   0   0   0   0   0   0
##   Aquitaine            0   0   0   0   0   0   0
##   Auvergne             0   0   0   0   0   0   0
##   Basse-Nor.           0   0   0   0   0   0   0
##   Bourgogne            0   0   0   0   0   0   0
##   Bretagne             0   0   0   0   0   0   0
##   Centre               0   0   0   0   0   0   0
##   Champ.Ard.           0   0   0   0   0   0   0
##   Corse                0   0   0   0   0   0   0
##   Franche-Comté        0   0   0   0   0   0   0
##   Guadeloupe           0   0   0   0   0   0   0
##   Haute-Normandie      0   0   0   0   0   0   0
##   IDF                  0   0   0   0   0   0   0
##   Languedoc            0   2   0   0   0   0   0
##   Limousin             0   0   0   0   0   0   0
##   Lorraine             0   0   0   0   0   0   0
##   Martinique           0   1   0   0   0   0   0
##   Midi-Pyrénées        0   0   0   4   0   0   0
##   Nord Pas-de-Calais   0  18   0   0  13   0   0
##   Pays de Loire        0   0   0   0   0   0   0
##   Picardie             4   0  12   0   0   6   2
##   Réunion              0   0   0   0   0   0   0
##   <NA>                 0   0   0   0   0   0   0
##                     
##                      OUI InVS et serveur régional ORULIM oui -SIB
##   Alsace                                               0        0
##   Aquitaine                                            0        0
##   Auvergne                                             0        0
##   Basse-Nor.                                           0        0
##   Bourgogne                                            0        0
##   Bretagne                                             0        0
##   Centre                                               0        0
##   Champ.Ard.                                           0        0
##   Corse                                                0        0
##   Franche-Comté                                        0        0
##   Guadeloupe                                           0        0
##   Haute-Normandie                                      0        0
##   IDF                                                  0        0
##   Languedoc                                            0        0
##   Limousin                                            10        0
##   Lorraine                                             0        0
##   Martinique                                           0        0
##   Midi-Pyrénées                                        0        0
##   Nord Pas-de-Calais                                   0        0
##   Pays de Loire                                        0        1
##   Picardie                                             0        0
##   Réunion                                              0        0
##   <NA>                                                 0        0
##                     
##                      pas d'envoi Pas d’envoi
##   Alsace                       0           0
##   Aquitaine                   13           0
##   Auvergne                     0           0
##   Basse-Nor.                   2           0
##   Bourgogne                    0           0
##   Bretagne                     6           5
##   Centre                       3           0
##   Champ.Ard.                   2           0
##   Corse                        0           0
##   Franche-Comté                0           0
##   Guadeloupe                   0           0
##   Haute-Normandie              1           0
##   IDF                         20           0
##   Languedoc                    0           0
##   Limousin                     0           0
##   Lorraine                     0           0
##   Martinique                   0           0
##   Midi-Pyrénées                0           0
##   Nord Pas-de-Calais           0           0
##   Pays de Loire                0           0
##   Picardie                     0           0
##   Réunion                      0           0
##   <NA>                         0           0
##                     
##                      pas d'envoi- le CH a saisi son éditeur
##   Alsace                                                  0
##   Aquitaine                                               0
##   Auvergne                                                0
##   Basse-Nor.                                              0
##   Bourgogne                                               0
##   Bretagne                                                0
##   Centre                                                  0
##   Champ.Ard.                                              0
##   Corse                                                   0
##   Franche-Comté                                           0
##   Guadeloupe                                              0
##   Haute-Normandie                                         1
##   IDF                                                     0
##   Languedoc                                               0
##   Limousin                                                0
##   Lorraine                                                0
##   Martinique                                              0
##   Midi-Pyrénées                                           0
##   Nord Pas-de-Calais                                      0
##   Pays de Loire                                           0
##   Picardie                                                0
##   Réunion                                                 0
##   <NA>                                                    0
##                     
##                      pas d'envoi- mise en place de SILLAGE Urgences prévu 2014
##   Alsace                                                                     0
##   Aquitaine                                                                  0
##   Auvergne                                                                   0
##   Basse-Nor.                                                                 0
##   Bourgogne                                                                  0
##   Bretagne                                                                   0
##   Centre                                                                     0
##   Champ.Ard.                                                                 0
##   Corse                                                                      0
##   Franche-Comté                                                              0
##   Guadeloupe                                                                 0
##   Haute-Normandie                                                            1
##   IDF                                                                        0
##   Languedoc                                                                  0
##   Limousin                                                                   0
##   Lorraine                                                                   0
##   Martinique                                                                 0
##   Midi-Pyrénées                                                              0
##   Nord Pas-de-Calais                                                         0
##   Pays de Loire                                                              0
##   Picardie                                                                   0
##   Réunion                                                                    0
##   <NA>                                                                       0
##                     
##                      pas d'envoi - obstacles à lever au plan organisationnel
##   Alsace                                                                   0
##   Aquitaine                                                                0
##   Auvergne                                                                 0
##   Basse-Nor.                                                               0
##   Bourgogne                                                                0
##   Bretagne                                                                 0
##   Centre                                                                   0
##   Champ.Ard.                                                               0
##   Corse                                                                    0
##   Franche-Comté                                                            0
##   Guadeloupe                                                               0
##   Haute-Normandie                                                          1
##   IDF                                                                      0
##   Languedoc                                                                0
##   Limousin                                                                 0
##   Lorraine                                                                 0
##   Martinique                                                               0
##   Midi-Pyrénées                                                            0
##   Nord Pas-de-Calais                                                       0
##   Pays de Loire                                                            0
##   Picardie                                                                 0
##   Réunion                                                                  0
##   <NA>                                                                     0
##                     
##                      Serveur régional et  InVS  SR   
##   Alsace                                      0  0  3
##   Aquitaine                                   0  0  0
##   Auvergne                                    0  0  0
##   Basse-Nor.                                  0  0  0
##   Bourgogne                                   0  0  0
##   Bretagne                                    0  0  0
##   Centre                                      0  0  0
##   Champ.Ard.                                  0  0  0
##   Corse                                       0  0  0
##   Franche-Comté                               0  0  0
##   Guadeloupe                                  0  0  0
##   Haute-Normandie                             0  0  0
##   IDF                                         0  0  0
##   Languedoc                                   0  0  0
##   Limousin                                    0  0  0
##   Lorraine                                    0  0  0
##   Martinique                                  0  0  0
##   Midi-Pyrénées                               0 33  0
##   Nord Pas-de-Calais                          0  0  0
##   Pays de Loire                               0  0  0
##   Picardie                                    0  0  0
##   Réunion                                     1  0  0
##   <NA>                                        0  0  0
##                     
##                       envoi au serveur régional  Envoi au serveur régional
##   Alsace                                      0                          0
##   Aquitaine                                   0                          0
##   Auvergne                                    7                          0
##   Basse-Nor.                                  0                          0
##   Bourgogne                                   0                          0
##   Bretagne                                    0                          5
##   Centre                                      0                          0
##   Champ.Ard.                                  0                          0
##   Corse                                       0                          0
##   Franche-Comté                               0                          0
##   Guadeloupe                                  0                          0
##   Haute-Normandie                             0                          0
##   IDF                                         0                          0
##   Languedoc                                   0                          0
##   Limousin                                    0                          0
##   Lorraine                                    0                          0
##   Martinique                                  0                          0
##   Midi-Pyrénées                               0                          0
##   Nord Pas-de-Calais                          0                          0
##   Pays de Loire                               0                          0
##   Picardie                                    0                          0
##   Réunion                                     0                          0
##   <NA>                                        0                          0
##                     
##                       envoi direct à l'INVS  non-SIB  oui -INVS  oui -SIB
##   Alsace                                  0        0          0         0
##   Aquitaine                               0        0          0         0
##   Auvergne                                0        0          0         0
##   Basse-Nor.                              0        0          0         0
##   Bourgogne                               0        0          0         0
##   Bretagne                                0        0          0         0
##   Centre                                  0        0          0         0
##   Champ.Ard.                              0        0          0         0
##   Corse                                   0        0          0         0
##   Franche-Comté                           0        0          0         0
##   Guadeloupe                              0        0          0         0
##   Haute-Normandie                         2        0          0         0
##   IDF                                     0        0          0         0
##   Languedoc                               0        0          0         0
##   Limousin                                0        0          0         0
##   Lorraine                                0        0          0         0
##   Martinique                              0        0          0         0
##   Midi-Pyrénées                           0        0          0         0
##   Nord Pas-de-Calais                      0        0          0         0
##   Pays de Loire                           0       14          1         1
##   Picardie                                0        0          0         0
##   Réunion                                 0        0          0         0
##   <NA>                                    0        0          0         0
##                     
##                       oui-SIB  pas d'envoi
##   Alsace                    0            0
##   Aquitaine                 0            0
##   Auvergne                  0            0
##   Basse-Nor.                0            0
##   Bourgogne                 0            0
##   Bretagne                  0            0
##   Centre                    0            0
##   Champ.Ard.                0            0
##   Corse                     0            0
##   Franche-Comté             0            0
##   Guadeloupe                0            0
##   Haute-Normandie           0            1
##   IDF                       0            0
##   Languedoc                 0            0
##   Limousin                  0            0
##   Lorraine                  0            0
##   Martinique                0            0
##   Midi-Pyrénées             0            0
##   Nord Pas-de-Calais        0            0
##   Pays de Loire             8            0
##   Picardie                  0            0
##   Réunion                   0            0
##   <NA>                      0            0
##                     
##                       pas d'envoi - obstacles à lever au plan organisationnel
##   Alsace                                                                    0
##   Aquitaine                                                                 0
##   Auvergne                                                                  0
##   Basse-Nor.                                                                0
##   Bourgogne                                                                 0
##   Bretagne                                                                  0
##   Centre                                                                    0
##   Champ.Ard.                                                                0
##   Corse                                                                     0
##   Franche-Comté                                                             0
##   Guadeloupe                                                                0
##   Haute-Normandie                                                           1
##   IDF                                                                       0
##   Languedoc                                                                 0
##   Limousin                                                                  0
##   Lorraine                                                                  0
##   Martinique                                                                0
##   Midi-Pyrénées                                                             0
##   Nord Pas-de-Calais                                                        0
##   Pays de Loire                                                             0
##   Picardie                                                                  0
##   Réunion                                                                   0
##   <NA>                                                                      0
##                     
##                       Serveur régional et  InVS  <NA>
##   Alsace                                       0    1
##   Aquitaine                                    0    0
##   Auvergne                                     0    0
##   Basse-Nor.                                   0    0
##   Bourgogne                                    0    0
##   Bretagne                                     0    0
##   Centre                                       0    0
##   Champ.Ard.                                   0    0
##   Corse                                        0    0
##   Franche-Comté                                0    0
##   Guadeloupe                                   0    5
##   Haute-Normandie                              0    0
##   IDF                                          0    0
##   Languedoc                                    0    4
##   Limousin                                     0    0
##   Lorraine                                     0    1
##   Martinique                                   0    0
##   Midi-Pyrénées                                0    0
##   Nord Pas-de-Calais                           0    0
##   Pays de Loire                                0    0
##   Picardie                                     0    0
##   Réunion                                      2    0
##   <NA>                                         0    0
```

```r
t
```

```
##                     
##                         autre expert santé N/A non Non Non  NON
##   Alsace              0     0            0   0   0   0    4   0
##   Aquitaine           0     0            0   0   0   0    0  11
##   Auvergne            0     0            0   0   0   0    0   0
##   Basse-Nor.          4     0            0   0   0   1    0   0
##   Bourgogne          20     0            0   0   0   0    0   0
##   Bretagne            0     0            0   0   0   3    0   0
##   Centre             20     0            0   0   0   0    0   0
##   Champ.Ard.          7     0            0   0   0   0    0   0
##   Corse               0     0            0   0   0   0    0   0
##   Franche-Comté       0     0            0   0   0   0    0   0
##   Guadeloupe          0     0            0   0   0   0    0   0
##   Haute-Normandie     7     0            0   0   0   2    0   0
##   IDF                63     0            0   0   0   6    0   0
##   Languedoc           3     1            1   0   0   0    0   0
##   Limousin            0     0            0   0   0   0    0   0
##   Lorraine            5     0            0   0   0   0    0   0
##   Martinique          4     0            0   0   0   0    0   0
##   Midi-Pyrénées       0     0            0   0   0   0    0   0
##   Nord Pas-de-Calais  1     0            0   0  17   0    0   0
##   Pays de Loire       2     0            0   0   0   0    0   0
##   Picardie            0     0            0   4   0  12    0   0
##   Réunion             0     0            0   0   0   0    0   0
##                     
##                      Non renseigné non  oui Oui Oui  OUi OUI oui 
##   Alsace                         0    0   0  14    0   0   0    0
##   Aquitaine                      0    0   0   0    0   0  23    0
##   Auvergne                       0    0   0   9    0   0   0    0
##   Basse-Nor.                     0    0   2  16    0   0   0    0
##   Bourgogne                      0    0   0   4    0   0   0    0
##   Bretagne                       0    0   0  13    0   0   0    0
##   Centre                         2    0   0   7    0   0   0    0
##   Champ.Ard.                     0    0   0   9    0   0   0    0
##   Corse                          0    0   4   0    0   0   0    0
##   Franche-Comté                  0    0   0  10    0   0   0    0
##   Guadeloupe                     0    0   0   0    0   0   0    0
##   Haute-Normandie                0    0   0  12    0   0   0    0
##   IDF                            7    0   0  23    0   0   0    0
##   Languedoc                      0    0   0  22    1   0   0    0
##   Limousin                       0    0   0   0    0   0  10    0
##   Lorraine                       0    0   2  19    0   0   0    0
##   Martinique                     0    0   1   0    0   0   0    0
##   Midi-Pyrénées                  0    0   0   0    0   0  37    0
##   Nord Pas-de-Calais             0    0  14   0    0   0   0    0
##   Pays de Loire                  0    5   1   0    0   0   0    2
##   Picardie                       0    0   0   6    0   2   0    0
##   Réunion                        0    0   0   0    0   0   0    0
##                     
##                      pas de réponse rattaché à belfort SMUR  non  Non
##   Alsace                          0                  0    0    0    0
##   Aquitaine                       0                  0    0    0    0
##   Auvergne                        0                  0    0    0    0
##   Basse-Nor.                      0                  0    0    0    0
##   Bourgogne                       0                  0    0    0    0
##   Bretagne                        0                  0    0    0    1
##   Centre                          0                  0    0    0    0
##   Champ.Ard.                      0                  0    0    0    0
##   Corse                           0                  0    0    0    0
##   Franche-Comté                   0                  1    2    0    0
##   Guadeloupe                      0                  0    0    0    0
##   Haute-Normandie                 0                  0    0    0    0
##   IDF                             0                  0    0    0    0
##   Languedoc                       0                  0    0    0    0
##   Limousin                        0                  0    0    0    0
##   Lorraine                        0                  0    1    0    0
##   Martinique                      1                  0    0    0    0
##   Midi-Pyrénées                   0                  0    0    0    0
##   Nord Pas-de-Calais              0                  0    0    0    0
##   Pays de Loire                   0                  0    0    3    0
##   Picardie                        0                  0    0    0    0
##   Réunion                         0                  0    0    0    0
##                     
##                       Non   oui  Oui  OUI
##   Alsace                 0    0    0    0
##   Aquitaine              0    0    0    0
##   Auvergne               0    0    7    0
##   Basse-Nor.             0    0    0    0
##   Bourgogne              0    0    0    0
##   Bretagne               1    5    7    0
##   Centre                 0    0    0    0
##   Champ.Ard.             0    0    0    0
##   Corse                  0    0    0    0
##   Franche-Comté          0    0    0    0
##   Guadeloupe             0    0    0    0
##   Haute-Normandie        0    0    0    0
##   IDF                    0    0    0    0
##   Languedoc              0    0    0    0
##   Limousin               0    0    0    0
##   Lorraine               0    0    0    0
##   Martinique             0    0    0    0
##   Midi-Pyrénées          0    0    0    0
##   Nord Pas-de-Calais     0    0    0    0
##   Pays de Loire          0   12    0    0
##   Picardie               0    0    0    0
##   Réunion                0    0    0    3
```

```r
barplot(t(t), las = 3)
```

![plot of chunk qui](figure/qui1.png) 

```r
barplot(t(prop.table(t, 1)), las = 3, ylab = "pourcentage")
```

![plot of chunk qui](figure/qui2.png) 

```r

table(d$RPU.QUI, d$RPU.CAPA)
```

```
##                                                                          
##                                                                              
##                                                                           128
##                                                                             0
##   En attente réponse directrice                                             1
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   1
##   N/A                                                                       0
##   non                                                                       0
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                               0
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    2
##    non-SIB                                                                  2
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              1
##    pas d'envoi - obstacles à lever au plan organisationnel                  1
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           autre
##                                                                               1
##                                                                               0
##   En attente réponse directrice                                               0
##   Envoi                                                                       0
##   \nEnvoi à l'INVS                                                            0
##   Envoi à l'INVS                                                              0
##    envoi au serveur régional                                                  0
##   envoi au serveur régional                                                   0
##   Envoi au serveur régional                                                   0
##   envoi des RPU à l'INVS                                                      0
##   envoi direct à l'INVS                                                       0
##   Envoi direct à l'INVS                                                       0
##   Envoi INVS                                                                  0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014     0
##   N/A                                                                         0
##   non                                                                         0
##   Non                                                                         0
##   NON                                                                         0
##   oui                                                                         0
##   Oui                                                                         0
##   OUi                                                                         0
##   OUI InVS et serveur régional ORULIM                                         0
##   oui -SIB                                                                    0
##   pas d'envoi                                                                 0
##   Pas d’envoi                                                                 0
##   pas d'envoi- le CH a saisi son éditeur                                      0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                   0
##   pas d'envoi - obstacles à lever au plan organisationnel                     0
##   Serveur régional et  InVS                                                   0
##   SR                                                                          0
##                                                                               0
##    envoi au serveur régional                                                  0
##    Envoi au serveur régional                                                  0
##    envoi direct à l'INVS                                                      0
##    non-SIB                                                                    0
##    oui -INVS                                                                  0
##    oui -SIB                                                                   0
##    oui-SIB                                                                    0
##    pas d'envoi                                                                0
##    pas d'envoi - obstacles à lever au plan organisationnel                    0
##    Serveur régional et  InVS                                                  0
##                                                                          
##                                                                           expert santé
##                                                                                      0
##                                                                                      0
##   En attente réponse directrice                                                      0
##   Envoi                                                                              0
##   \nEnvoi à l'INVS                                                                   0
##   Envoi à l'INVS                                                                     0
##    envoi au serveur régional                                                         0
##   envoi au serveur régional                                                          0
##   Envoi au serveur régional                                                          0
##   envoi des RPU à l'INVS                                                             0
##   envoi direct à l'INVS                                                              0
##   Envoi direct à l'INVS                                                              0
##   Envoi INVS                                                                         0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014            0
##   N/A                                                                                0
##   non                                                                                1
##   Non                                                                                0
##   NON                                                                                0
##   oui                                                                                0
##   Oui                                                                                0
##   OUi                                                                                0
##   OUI InVS et serveur régional ORULIM                                                0
##   oui -SIB                                                                           0
##   pas d'envoi                                                                        0
##   Pas d’envoi                                                                        0
##   pas d'envoi- le CH a saisi son éditeur                                             0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                          0
##   pas d'envoi - obstacles à lever au plan organisationnel                            0
##   Serveur régional et  InVS                                                          0
##   SR                                                                                 0
##                                                                                      0
##    envoi au serveur régional                                                         0
##    Envoi au serveur régional                                                         0
##    envoi direct à l'INVS                                                             0
##    non-SIB                                                                           0
##    oui -INVS                                                                         0
##    oui -SIB                                                                          0
##    oui-SIB                                                                           0
##    pas d'envoi                                                                       0
##    pas d'envoi - obstacles à lever au plan organisationnel                           0
##    Serveur régional et  InVS                                                         0
##                                                                          
##                                                                           N/A
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       4
##   non                                                                       0
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                               0
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           non
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                      17
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                               0
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           Non
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     1
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       0
##   Non                                                                      12
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                              10
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 1
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           Non 
##                                                                              0
##                                                                              1
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              3
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                           NON
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       0
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                              11
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           Non renseigné
##                                                                                       0
##                                                                                       0
##   En attente réponse directrice                                                       0
##   Envoi                                                                               0
##   \nEnvoi à l'INVS                                                                    0
##   Envoi à l'INVS                                                                      0
##    envoi au serveur régional                                                          0
##   envoi au serveur régional                                                           0
##   Envoi au serveur régional                                                           0
##   envoi des RPU à l'INVS                                                              0
##   envoi direct à l'INVS                                                               0
##   Envoi direct à l'INVS                                                               0
##   Envoi INVS                                                                          0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014             0
##   N/A                                                                                 0
##   non                                                                                 0
##   Non                                                                                 0
##   NON                                                                                 0
##   oui                                                                                 0
##   Oui                                                                                 0
##   OUi                                                                                 0
##   OUI InVS et serveur régional ORULIM                                                 0
##   oui -SIB                                                                            0
##   pas d'envoi                                                                         9
##   Pas d’envoi                                                                         0
##   pas d'envoi- le CH a saisi son éditeur                                              0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                           0
##   pas d'envoi - obstacles à lever au plan organisationnel                             0
##   Serveur régional et  InVS                                                           0
##   SR                                                                                  0
##                                                                                       0
##    envoi au serveur régional                                                          0
##    Envoi au serveur régional                                                          0
##    envoi direct à l'INVS                                                              0
##    non-SIB                                                                            0
##    oui -INVS                                                                          0
##    oui -SIB                                                                           0
##    oui-SIB                                                                            0
##    pas d'envoi                                                                        0
##    pas d'envoi - obstacles à lever au plan organisationnel                            0
##    Serveur régional et  InVS                                                          0
##                                                                          
##                                                                           non 
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   5
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                           oui
##                                                                             1
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 5
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    2
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       2
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                      13
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                               0
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  1
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           Oui
##                                                                             8
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          1
##   Envoi à l'INVS                                                            1
##    envoi au serveur régional                                                1
##   envoi au serveur régional                                                94
##   Envoi au serveur régional                                                 1
##   envoi des RPU à l'INVS                                                    1
##   envoi direct à l'INVS                                                    32
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                1
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       1
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       6
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                              15
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    1
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   1
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           Oui 
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  1
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                           OUi
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                 0
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       0
##   Non                                                                       0
##   NON                                                                       0
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       2
##   OUI InVS et serveur régional ORULIM                                       0
##   oui -SIB                                                                  0
##   pas d'envoi                                                               0
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                        0
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           OUI
##                                                                             0
##                                                                             0
##   En attente réponse directrice                                             0
##   Envoi                                                                     0
##   \nEnvoi à l'INVS                                                          0
##   Envoi à l'INVS                                                            0
##    envoi au serveur régional                                                0
##   envoi au serveur régional                                                21
##   Envoi au serveur régional                                                 0
##   envoi des RPU à l'INVS                                                    0
##   envoi direct à l'INVS                                                     0
##   Envoi direct à l'INVS                                                     0
##   Envoi INVS                                                                0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014   0
##   N/A                                                                       0
##   non                                                                       0
##   Non                                                                       0
##   NON                                                                       4
##   oui                                                                       0
##   Oui                                                                       0
##   OUi                                                                       0
##   OUI InVS et serveur régional ORULIM                                      10
##   oui -SIB                                                                  0
##   pas d'envoi                                                               2
##   Pas d’envoi                                                               0
##   pas d'envoi- le CH a saisi son éditeur                                    0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                 0
##   pas d'envoi - obstacles à lever au plan organisationnel                   0
##   Serveur régional et  InVS                                                 0
##   SR                                                                       33
##                                                                             0
##    envoi au serveur régional                                                0
##    Envoi au serveur régional                                                0
##    envoi direct à l'INVS                                                    0
##    non-SIB                                                                  0
##    oui -INVS                                                                0
##    oui -SIB                                                                 0
##    oui-SIB                                                                  0
##    pas d'envoi                                                              0
##    pas d'envoi - obstacles à lever au plan organisationnel                  0
##    Serveur régional et  InVS                                                0
##                                                                          
##                                                                           oui 
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   1
##    oui -INVS                                                                 0
##    oui -SIB                                                                  1
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                           pas de réponse
##                                                                                        1
##                                                                                        0
##   En attente réponse directrice                                                        0
##   Envoi                                                                                0
##   \nEnvoi à l'INVS                                                                     0
##   Envoi à l'INVS                                                                       0
##    envoi au serveur régional                                                           0
##   envoi au serveur régional                                                            0
##   Envoi au serveur régional                                                            0
##   envoi des RPU à l'INVS                                                               0
##   envoi direct à l'INVS                                                                0
##   Envoi direct à l'INVS                                                                0
##   Envoi INVS                                                                           0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014              0
##   N/A                                                                                  0
##   non                                                                                  0
##   Non                                                                                  0
##   NON                                                                                  0
##   oui                                                                                  0
##   Oui                                                                                  0
##   OUi                                                                                  0
##   OUI InVS et serveur régional ORULIM                                                  0
##   oui -SIB                                                                             0
##   pas d'envoi                                                                          0
##   Pas d’envoi                                                                          0
##   pas d'envoi- le CH a saisi son éditeur                                               0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                            0
##   pas d'envoi - obstacles à lever au plan organisationnel                              0
##   Serveur régional et  InVS                                                            0
##   SR                                                                                   0
##                                                                                        0
##    envoi au serveur régional                                                           0
##    Envoi au serveur régional                                                           0
##    envoi direct à l'INVS                                                               0
##    non-SIB                                                                             0
##    oui -INVS                                                                           0
##    oui -SIB                                                                            0
##    oui-SIB                                                                             0
##    pas d'envoi                                                                         0
##    pas d'envoi - obstacles à lever au plan organisationnel                             0
##    Serveur régional et  InVS                                                           0
##                                                                          
##                                                                           rattaché à belfort
##                                                                                            1
##                                                                                            0
##   En attente réponse directrice                                                            0
##   Envoi                                                                                    0
##   \nEnvoi à l'INVS                                                                         0
##   Envoi à l'INVS                                                                           0
##    envoi au serveur régional                                                               0
##   envoi au serveur régional                                                                0
##   Envoi au serveur régional                                                                0
##   envoi des RPU à l'INVS                                                                   0
##   envoi direct à l'INVS                                                                    0
##   Envoi direct à l'INVS                                                                    0
##   Envoi INVS                                                                               0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014                  0
##   N/A                                                                                      0
##   non                                                                                      0
##   Non                                                                                      0
##   NON                                                                                      0
##   oui                                                                                      0
##   Oui                                                                                      0
##   OUi                                                                                      0
##   OUI InVS et serveur régional ORULIM                                                      0
##   oui -SIB                                                                                 0
##   pas d'envoi                                                                              0
##   Pas d’envoi                                                                              0
##   pas d'envoi- le CH a saisi son éditeur                                                   0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                                0
##   pas d'envoi - obstacles à lever au plan organisationnel                                  0
##   Serveur régional et  InVS                                                                0
##   SR                                                                                       0
##                                                                                            0
##    envoi au serveur régional                                                               0
##    Envoi au serveur régional                                                               0
##    envoi direct à l'INVS                                                                   0
##    non-SIB                                                                                 0
##    oui -INVS                                                                               0
##    oui -SIB                                                                                0
##    oui-SIB                                                                                 0
##    pas d'envoi                                                                             0
##    pas d'envoi - obstacles à lever au plan organisationnel                                 0
##    Serveur régional et  InVS                                                               0
##                                                                          
##                                                                           SMUR
##                                                                              3
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                            non
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   3
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                            Non
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                1
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                            Non 
##                                                                               0
##                                                                               0
##   En attente réponse directrice                                               0
##   Envoi                                                                       0
##   \nEnvoi à l'INVS                                                            0
##   Envoi à l'INVS                                                              0
##    envoi au serveur régional                                                  0
##   envoi au serveur régional                                                   0
##   Envoi au serveur régional                                                   0
##   envoi des RPU à l'INVS                                                      0
##   envoi direct à l'INVS                                                       0
##   Envoi direct à l'INVS                                                       0
##   Envoi INVS                                                                  0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014     0
##   N/A                                                                         0
##   non                                                                         0
##   Non                                                                         0
##   NON                                                                         0
##   oui                                                                         0
##   Oui                                                                         0
##   OUi                                                                         0
##   OUI InVS et serveur régional ORULIM                                         0
##   oui -SIB                                                                    0
##   pas d'envoi                                                                 0
##   Pas d’envoi                                                                 1
##   pas d'envoi- le CH a saisi son éditeur                                      0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                   0
##   pas d'envoi - obstacles à lever au plan organisationnel                     0
##   Serveur régional et  InVS                                                   0
##   SR                                                                          0
##                                                                               0
##    envoi au serveur régional                                                  0
##    Envoi au serveur régional                                                  0
##    envoi direct à l'INVS                                                      0
##    non-SIB                                                                    0
##    oui -INVS                                                                  0
##    oui -SIB                                                                   0
##    oui-SIB                                                                    0
##    pas d'envoi                                                                0
##    pas d'envoi - obstacles à lever au plan organisationnel                    0
##    Serveur régional et  InVS                                                  0
##                                                                          
##                                                                            oui
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   1
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 5
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   3
##    oui -INVS                                                                 1
##    oui -SIB                                                                  0
##    oui-SIB                                                                   7
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                            Oui
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      1
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  3
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                3
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  0
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 7
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 0
##                                                                          
##                                                                            OUI
##                                                                              0
##                                                                              0
##   En attente réponse directrice                                              0
##   Envoi                                                                      0
##   \nEnvoi à l'INVS                                                           0
##   Envoi à l'INVS                                                             0
##    envoi au serveur régional                                                 0
##   envoi au serveur régional                                                  0
##   Envoi au serveur régional                                                  0
##   envoi des RPU à l'INVS                                                     0
##   envoi direct à l'INVS                                                      0
##   Envoi direct à l'INVS                                                      0
##   Envoi INVS                                                                 0
##   Informatisation avec le nouveau progiciel initialement prévue mars 2014    0
##   N/A                                                                        0
##   non                                                                        0
##   Non                                                                        0
##   NON                                                                        0
##   oui                                                                        0
##   Oui                                                                        0
##   OUi                                                                        0
##   OUI InVS et serveur régional ORULIM                                        0
##   oui -SIB                                                                   0
##   pas d'envoi                                                                0
##   Pas d’envoi                                                                0
##   pas d'envoi- le CH a saisi son éditeur                                     0
##   pas d'envoi- mise en place de SILLAGE Urgences prévu 2014                  0
##   pas d'envoi - obstacles à lever au plan organisationnel                    0
##   Serveur régional et  InVS                                                  1
##   SR                                                                         0
##                                                                              0
##    envoi au serveur régional                                                 0
##    Envoi au serveur régional                                                 0
##    envoi direct à l'INVS                                                     0
##    non-SIB                                                                   0
##    oui -INVS                                                                 0
##    oui -SIB                                                                  0
##    oui-SIB                                                                   0
##    pas d'envoi                                                               0
##    pas d'envoi - obstacles à lever au plan organisationnel                   0
##    Serveur régional et  InVS                                                 2
```


Quels sont les logiciels utilisés ?
------------------------------------


```r

table(d$REGION, d$LOGICIEL, useNA = "always")
```

```
##                     
##                      Atalante Axigate Clinicom Cora CristalNet
##   Alsace                    6       0        1    0          3
##   Aquitaine                 0       0        0    0          0
##   Auvergne                  0       0        0    0          0
##   Basse-Nor.                0       1        0    1          1
##   Bourgogne                 0       0        0    0          0
##   Bretagne                  0       0        0    0          0
##   Centre                    0       0        0    0          0
##   Champ.Ard.                0       0        0    0          3
##   Corse                     0       0        0    0          0
##   Franche-Comté             0       0        0    0          0
##   Guadeloupe                0       0        0    0          0
##   Haute-Normandie           0       0        0    0          0
##   IDF                       0       0        0    0          0
##   Languedoc                 0       0        0    0          0
##   Limousin                  0       0        0    0          0
##   Lorraine                  0       0        0    0          0
##   Martinique                0       0        0    0          0
##   Midi-Pyrénées             0       0        0    0          0
##   Nord Pas-de-Calais        0       0        4    2          2
##   Pays de Loire             0       0        0    0          0
##   Picardie                  0       0        1    0          2
##   Réunion                   0       0        0    0          0
##   <NA>                      0       0        0    0          0
##                     
##                      Diamm Micro6 Dopa Urgences DXCare emed expert santé
##   Alsace                        0             0      5    0            0
##   Aquitaine                     0             0      0    0            0
##   Auvergne                      0             0      0    0            0
##   Basse-Nor.                    0             0      0    0            0
##   Bourgogne                     0             0      0    0            0
##   Bretagne                      0             0      0    0            0
##   Centre                        0             0      0    0            0
##   Champ.Ard.                    0             2      1    0            0
##   Corse                         0             0      0    0            0
##   Franche-Comté                 0             0      0    0            0
##   Guadeloupe                    0             0      0    0            0
##   Haute-Normandie               0             0      0    0            0
##   IDF                           0             0      0    0            0
##   Languedoc                     0             0      0    1            1
##   Limousin                      0             0      0    0            0
##   Lorraine                      0             0      1    0            0
##   Martinique                    0             0      0    0            0
##   Midi-Pyrénées                 0             0      0    0            0
##   Nord Pas-de-Calais            0             0      3    0            0
##   Pays de Loire                 0             0      0    0            0
##   Picardie                      2             0      3    0            0
##   Réunion                       0             0      0    0            0
##   <NA>                          0             0      0    0            0
##                     
##                      Hopital Manager Inclus dans GHPSO Millenium (Cerner)
##   Alsace                           0                 0                  0
##   Aquitaine                        0                 0                  0
##   Auvergne                         0                 0                  0
##   Basse-Nor.                       0                 0                  0
##   Bourgogne                        0                 0                  0
##   Bretagne                         0                 0                  0
##   Centre                           0                 0                  0
##   Champ.Ard.                       0                 0                  0
##   Corse                            0                 0                  0
##   Franche-Comté                    0                 0                  0
##   Guadeloupe                       0                 0                  0
##   Haute-Normandie                  0                 0                  0
##   IDF                              0                 0                  0
##   Languedoc                        1                 0                  0
##   Limousin                         0                 0                  0
##   Lorraine                         0                 0                  0
##   Martinique                       0                 0                  0
##   Midi-Pyrénées                    0                 0                  0
##   Nord Pas-de-Calais               1                 0                  1
##   Pays de Loire                    0                 0                  0
##   Picardie                         0                 1                  0
##   Réunion                          0                 0                  0
##   <NA>                             0                 0                  0
##                     
##                      myvisit Orbis Osiris Osoft Polymedis ResUrgences
##   Alsace                   0     1      0     0         0           1
##   Aquitaine                0     0      0     0         0           0
##   Auvergne                 0     0      0     0         0           0
##   Basse-Nor.               0     0      1     0         0           2
##   Bourgogne                0     0      0     0         0           0
##   Bretagne                 0     0      0     0         0           0
##   Centre                   0     0      0     0         0           0
##   Champ.Ard.               0     0      0     0         6           1
##   Corse                    0     0      0     0         0           0
##   Franche-Comté            0     0      0     0         0           0
##   Guadeloupe               0     0      0     0         0           0
##   Haute-Normandie          0     0      0     0         0           0
##   IDF                      0     0      0     0         0           0
##   Languedoc                4     0      0     1         0           0
##   Limousin                 0     0      0     0         0           0
##   Lorraine                 0     0      0     0         0           0
##   Martinique               0     0      0     0         0           0
##   Midi-Pyrénées            0     0      0     0         0           0
##   Nord Pas-de-Calais       0     0      1     1         1           2
##   Pays de Loire            0     0      0     0         0           0
##   Picardie                 0     0      1     1         0           4
##   Réunion                  0     0      0     0         0           0
##   <NA>                     0     0      0     0         0           0
##                     
##                      Sillage TechnoWeb (dev int) Track Care (InterSystem)
##   Alsace                   0                   0                        0
##   Aquitaine                0                   0                        0
##   Auvergne                 0                   0                        0
##   Basse-Nor.               0                   0                        0
##   Bourgogne                0                   0                        0
##   Bretagne                 0                   0                        0
##   Centre                   0                   0                        0
##   Champ.Ard.               0                   0                        0
##   Corse                    0                   0                        0
##   Franche-Comté            0                   0                        0
##   Guadeloupe               0                   0                        0
##   Haute-Normandie          0                   0                        0
##   IDF                      0                   0                        0
##   Languedoc                0                   0                        0
##   Limousin                 0                   0                        0
##   Lorraine                 0                   0                        0
##   Martinique               0                   0                        0
##   Midi-Pyrénées            0                   0                        0
##   Nord Pas-de-Calais       1                   1                        5
##   Pays de Loire            0                   0                        0
##   Picardie                 0                   0                        0
##   Réunion                  0                   0                        0
##   <NA>                     0                   0                        0
##                     
##                      TU-OruPaca UrQual <NA>
##   Alsace                      0      1    2
##   Aquitaine                   0      0   34
##   Auvergne                    0      0   16
##   Basse-Nor.                  0      0   17
##   Bourgogne                   0      0   24
##   Bretagne                    0      0   31
##   Centre                      0      0   29
##   Champ.Ard.                  0      3    0
##   Corse                       2      0    2
##   Franche-Comté               0      0   13
##   Guadeloupe                  0      0    5
##   Haute-Normandie             0      0   21
##   IDF                         0      0   99
##   Languedoc                   0      2   22
##   Limousin                    0      0   10
##   Lorraine                    0      0   27
##   Martinique                  0      0    6
##   Midi-Pyrénées               0      0   37
##   Nord Pas-de-Calais          0      3    4
##   Pays de Loire               0      0   25
##   Picardie                    0      3    6
##   Réunion                     0      0    3
##   <NA>                        0      0    0
```

```r

summary(as.factor(d$LOGICIEL))
```

```
##                 Atalante                  Axigate                 Clinicom 
##                        6                        1                        6 
##                     Cora               CristalNet             Diamm Micro6 
##                        3                       11                        2 
##            Dopa Urgences                   DXCare                     emed 
##                        2                       13                        1 
##             expert santé          Hopital Manager        Inclus dans GHPSO 
##                        1                        2                        1 
##       Millenium (Cerner)                  myvisit                    Orbis 
##                        1                        4                        1 
##                   Osiris                    Osoft                Polymedis 
##                        3                        3                        7 
##              ResUrgences                  Sillage      TechnoWeb (dev int) 
##                       10                        1                        1 
## Track Care (InterSystem)               TU-OruPaca                   UrQual 
##                        5                        2                       12 
##                     NA's 
##                      433
```

```r
tab1(d$LOGICIEL, missing = FALSE, sort.group = "increasing", main = "Logiciels utilisés", 
    xlab = "Fréquence")
```

![plot of chunk logiciels](figure/logiciels.png) 

```
## d$LOGICIEL : 
##                          Frequency   %(NA+)   %(NA-)
## Axigate                          1      0.2      1.0
## emed                             1      0.2      1.0
## expert santé                     1      0.2      1.0
## Inclus dans GHPSO                1      0.2      1.0
## Millenium (Cerner)               1      0.2      1.0
## Orbis                            1      0.2      1.0
## Sillage                          1      0.2      1.0
## TechnoWeb (dev int)              1      0.2      1.0
## Diamm Micro6                     2      0.4      2.0
## Dopa Urgences                    2      0.4      2.0
## Hopital Manager                  2      0.4      2.0
## TU-OruPaca                       2      0.4      2.0
## Cora                             3      0.6      3.0
## Osiris                           3      0.6      3.0
## Osoft                            3      0.6      3.0
## myvisit                          4      0.8      4.0
## Track Care (InterSystem)         5      0.9      5.1
## Atalante                         6      1.1      6.1
## Clinicom                         6      1.1      6.1
## Polymedis                        7      1.3      7.1
## ResUrgences                     10      1.9     10.1
## CristalNet                      11      2.1     11.1
## UrQual                          12      2.3     12.1
## DXCare                          13      2.4     13.1
## <NA>                           433     81.4      0.0
##   Total                        532    100.0    100.0
```


