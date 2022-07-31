## Fájlok beolvasása
rawfirst <- read.csv2("first.csv", head = FALSE)
rawsecond <- read.csv2("secondfull.csv", head = FALSE)

## Egyesítés
raw  <- rbind(rawfirst, rawsecond)

names(raw) <- c("Ssz", "Y", "X", "Z", "Code")

## Dupla?
which(duplicated(raw[, "Ssz"]))
raw[644,]
raw[raw[,1] == 4,]
raw <- raw[-644,]

