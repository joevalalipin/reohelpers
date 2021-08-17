library(dplyr)
library(stringr)
library(readr)
library(readxl)
library(stringi)

unicodes <- read_excel("data/unicodes.xlsx")

common_words <- read_excel("data/common_words.xlsx") %>%
  group_by(word_macron = Word) %>%
  summarise(meaning = paste0(`Its more frequent meanings`, collapse = "; OR ")) %>%
  filter(str_detect(word_macron, paste0(unicodes$vowel, collapse = "|")))

place_names <- data.frame(read_csv("data/gaz_names.csv") %>%
                            select(name) %>%
                            filter(str_detect(name, paste0(unicodes$vowel, collapse = "|"))) %>%
                            mutate(name = str_replace_all(name, "[/()]", " ")) %>%
                            pull(name) %>%
                            paste0(collapse = " ") %>%
                            str_split(" "),
                          stringsAsFactors = FALSE) %>%
  distinct() %>%
  rename(word_macron = 1) %>%
  filter(str_detect(word_macron, paste0(unicodes$vowel, collapse = "|"))) %>%
  mutate(word_macron = str_remove_all(word_macron, " "),
         meaning = "Place")

glossary <- bind_rows(common_words, place_names) %>%
  distinct() %>%
  mutate(word_ascii = stri_trans_general(word_macron, "Latin-ASCII"),
         word_ascii_lower = tolower(word_ascii)) %>%
  group_by(word_ascii_lower) %>%
  slice(1)

add_macron <- function(string, sep) {
  data.frame(str_split(string, sep), stringsAsFactors = FALSE) %>%
    rename(word_ascii_input = 1) %>%
    mutate(word_ascii_lower = tolower(word_ascii_input)) %>%
    left_join(glossary, by = "word_ascii_lower") %>%
    mutate(word_macron = ifelse(meaning != "Place" & str_detect(str_sub(word_ascii_input, 1, 1), "[A-Z]"), str_to_sentence(word_macron), word_macron)) %>%
    mutate(word_macron = ifelse(is.na(word_macron), word_ascii_input, word_macron)) %>%
    pull(word_macron) %>%
    paste0(collapse = sep)
}
add_macron <- Vectorize(add_macron)
