## Fájlok beolvasása
rawfirst <- read.csv2("first.csv", head = FALSE)
rawsecond <- read.csv2("secondfull.csv", head = FALSE)

## Egyesítés
raw  <- rbind(rawfirst, rawsecond)
