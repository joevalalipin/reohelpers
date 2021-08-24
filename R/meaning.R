#' @import dplyr
#' @import stringr
#' @import magrittr

library(dplyr)
library(stringr)
library(magrittr)

load("data/common_words_full.rdata")

meaning <- function(string, sep = " ") {
  data.frame(str_split(string, sep), stringsAsFactors = FALSE) %>%
    rename(word_ascii_input = 1) %>%
    mutate(word_ascii_lower = tolower(word_ascii_input)) %>%
    left_join(common_words_full, by = "word_ascii_lower") %>%
    mutate(word_macron = ifelse(meaning != "Place" & str_detect(str_sub(word_ascii_input, 1, 1), "[A-Z]"), str_to_sentence(word_macron), word_macron)) %>%
    mutate(word_macron = ifelse(is.na(word_macron), word_ascii_input, word_macron),
           meaning = ifelse(is.na(meaning), "Not found", meaning)) %>%
    select(word = word_macron, meaning)
}
