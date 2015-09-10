FEDORU SI 2015

Pour compléter le tableau de l'enquête, utiliser la routine __synthese.completude__ de _rapport 2014.R_ (trame_commune). Permet de calculer les taux de complétude globalement ou par établissement.

```
load("~/Documents/Stat Resural/RPU_2014/rpu2015d0112_provisoire.Rda")
source('~/Documents/RESURAL/Trame_Commune/Rapport/rapport_2014.R')
library(plyr)

dsi <- d15[as.Date(d15$ENTREE) < as.Date("2015-04-01"),]
min(as.Date(dsi$ENTREE))
max(as.Date(dsi$ENTREE))
synthese.completude(dsi[dsi$FINESS == "Hus",])
```
Calcul des jours manquants

