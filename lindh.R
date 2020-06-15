#install.packages("tidyverse")
library(tidyverse)

# SCRAPING

#install.packages('pdftools')
library(pdftools)

#install.packages("tabulizer")
library("tabulizer")

#install.packages("tabulizerjars")
library(tabulizerjars)

pdf.file <- "Lindh.pdf"

pdf.dat <- extract_tables(pdf.file, pages = c(38:39), method = "decide")

pdf.tbl <- lapply(pdf.dat, as.data.frame) %>% bind_rows()

names(pdf.tbl) <- as.matrix(pdf.tbl[1,])

pdf.tbl <- pdf.tbl[-1,]

for(row in 1:nrow(pdf.tbl)) {
    table <- pdf.tbl
    species <- table[row, 'Species']
    vern <- table[row, 'Vernacular name']
    use <- table[row, 'Use']
    source <- table[row, 'Source']
    # print(paste(species, vern, use, source))
    if(table[row, 'Family'] == "")
        print(
            pdf.tbl[row - 1, 'Use'] <- paste(pdf.tbl[row - 1, 'Use'], " ", pdf.tbl[row, 'Use'])
        )
    # print(paste(row, pdf.tbl[row, 'Species']))
}
