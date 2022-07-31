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

## ACAD szkript gyártó
write.acad.points <- function(x, file, code, file.append = FALSE, pointnum = FALSE) {
    acadlayer <- paste0("Points_", code)
    if(file.append) {
        write(paste("-FÓLIA ÚJ",acadlayer, "\r"),sep="\r", file = file, append = TRUE)
    } else {
        write(paste("-FÓLIA ÚJ",acadlayer, "\r"), sep="\r", file = file)
    }
    write(paste("-FÓLIA BEÁLLÍT",acadlayer, "\r"), sep="\r", file = file, append = TRUE)
    pointcoord <- x[x[, "Code"] == code, 2:4]
    pointcoord[,1] <- paste("pont", pointcoord[,1])
    write.table(pointcoord, file= file ,sep=",",row=F,col=F,eol="\r\n",quot=F,append=TRUE)
    if(pointnum){
        write.table(pointcoord, file= file ,sep=",",row=F,col=F,eol="\r\n",quot=F,append=TRUE)
    }
    ## write("\r", file, append = TRUE)
}

## Első kód
write.acad.points(raw, "Points.scr", Codes[1])

## Többi kód
for(ttakt in Codes[-1]){
    write.acad.points(x = raw, file = "Points.scr", code = ttakt, file.append = TRUE)
}
