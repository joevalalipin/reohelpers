#' @import dplyr
#' @import stringr
#' @import readxl

library(dplyr)
library(stringr)
library(readxl)

unicodes <- read_excel("data/unicodes.xlsx")

macron_vowel <- function(string) {
  data.frame(str_split(string, ""), stringsAsFactors = FALSE) %>%
    rename(vowel_ascii = 1) %>%
    left_join(unicodes, by = "vowel_ascii") %>%
    mutate(vowel = ifelse(is.na(vowel), vowel_ascii, vowel)) %>%
    pull(vowel) %>%
    paste0(collapse = "")
}
vowel_macron <- Vectorize(macron_vowel)
