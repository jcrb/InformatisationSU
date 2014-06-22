# Normalise la liste des logiciels

standardise_logiciels <- function(liste){
a <- as.character(liste)
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
a[a == "CRISTALNET"] <- "CristalNet"

a[a == "Cotexte"] <- "Coretexte"
a[a == "Cortexe"] <- "Coretexte"

a[a == "CROSSWAY"] <- "Crossway"
a[a == "crossway"] <- "Crossway"
a[a == "crosway"] <- "Crossway"

a[a == "CORA"] <- "Cora"
a[a == "CLINICOM (Creil)"] <- "Clinicom"

a[a == "DxCare (Medasys)"] <- "DXCare"
a[a == "DXCARE (Medasys)"] <- "DXCare"
a[a == "DxCare MEDASYS"] <- "DXCare"
a[a == "dxcare (vittel)"] <- "DXCare"
a[a == "DX CARE"] <- "DXCare"
a[a == "DxCare"] <- "DXCare"

a[a == "hopital manager"] <- "Hopital Manager"

a[a == "Osiris (Cormin)"] <- "Osiris"
a[a == "OSIRIS Evolucare"] <- "Osiris"
a[a == "Oriris (cormin)"] <- "Osiris"

a[a == "OSOFT"] <- "Osoft"

a[a == "ATALANTE Pmsi"] <- "Atalante"
a[a == "ATALANTE"] <- "Atalante"

a[a == "CORETEXTE"] <- "Cortext"

a[a == "POLIMEDIS - EQUAFILE"] <- "Polymedis"

a[a == "ﾠ"] <- NA
a[a == "cf ch lodeve"] <- NA
a[a == "Etablissement prioritaire !"] <- NA
a[a == "Pas de SAU"] <- NA
a[!is.na(a) & nchar(a) < 3] <- NA
as.factor(toupper(a))

}