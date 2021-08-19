library(dplyr)
library(stringr)
library(readxl)
library(stringi)

common_words_full <- read_excel("data/common_words.xlsx") %>%
  group_by(word_macron = Word) %>%
  summarise(meaning = paste0(`Its more frequent meanings`, collapse = "; OR ")) %>%
  distinct() %>%
  mutate(word_ascii = stri_trans_general(word_macron, "Latin-ASCII"),
         word_ascii_lower = tolower(word_ascii))

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
