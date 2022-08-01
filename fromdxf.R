dxfin <- function(type) {
    layername <- paste0(type, "_spl_pont")
    file <- paste0(layername, ".dxf")
    raw.text <- scan(file, character(), fileEncod = "latin1")
    prepont <- which(raw.text == layername)
    pont <- prepont
    ## Koordináta helyének meghatározása
    kozel <- raw.text[prepont + 2] == "AcDbPoint"
    pont[kozel] <- pont[kozel] + 2
    pont[!kozel] <- pont[!kozel] + 4
    pont <- pont[raw.text[pont] == "AcDbPoint"]
    ## Koordináták kiszedésedxffileso
    Y.coo <- raw.text[pont + 2]
    X.coo <- raw.text[pont + 4]
    Z.coo <- raw.text[pont + 6]
    ## Adattábla
    data.frame(Y = round(as.numeric(Y.coo), 3),
               X = round(as.numeric(X.coo), 3),
               Z = round(as.numeric(Z.coo), 3),
               C = type
               )
}

kodok <- c("af", "as", "k", "kv", "ra", "us", "ut")
tinhez <- dxfin(kodok[1])
for(tti in kodok[-1])
    tinhez <- rbind(tinhez, dxfin(tti))

## A legmagasabb pontszám utáni 1001
row.names(tinhez) <- as.numeric(row.names(tinhez)) + 4000

write.table(tinhez, "Splinepontok.csv", sep = ",", quote = FALSE, eol = "\r\n", col.names = FALSE)

