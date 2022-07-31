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

summary(factor(raw$Code))

## Kód homogenizálás
raw[raw$Code == "US", "Code"] <- "us"
raw[raw$Code == "UT", "Code"] <- "ut"
raw[raw$Code == "uk", "Code"] <- "ut"
raw[raw$Code == "usz", "Code"] <- "us"

Codes <- unique(raw$Code)
