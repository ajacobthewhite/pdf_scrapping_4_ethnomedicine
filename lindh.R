---
title: "lindh"
output: html_document
---

``` {r}
install.packages("tidyverse")
library(tidyverse)

# SCRAPING

install.packages('pdftools')
library(pdftools)

install.packages("tabulizer")
library("tabulizer")

install.packages("tabulizerjars")
library(tabulizerjars)
```

``` {r}
pdf.file <- "Lindh.pdf"

# todo: make page numbers program arguments
pdf.dat <- extract_tables(pdf.file, pages = c(38:39), method = "decide")

pdf.tbl <- lapply(pdf.dat, as.data.frame) %>% bind_rows()

# todo: remove once mvp exists; just for basic debugging
pdf.tbl <- pdf.tbl[c(1:30),]

names(pdf.tbl) <- headers <- as.matrix(pdf.tbl[1,])

pdf.tbl <- pdf.tbl[-1,]

for(row in 1:nrow(pdf.tbl)) {
    if(pdf.tbl[row, 'Family'] == "") {
        for(header in headers) {
            pdf.tbl[row - 1, header] <- paste(pdf.tbl[row - 1, header], pdf.tbl[row, header])
            pdf.tbl[row, header] <- NA
        }
    }
}

pdf.tbl <- pdf.tbl %>% drop_na()

# todo: make this a program argument
write.csv(pdf.tbl, file = "Lindh1.csv")
```
