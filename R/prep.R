# library(readr)
# library(readxl)
# library(dplyr)
# library(stringr)
# library(stringi)
#
# unicodes <- read_excel("data/unicodes.xlsx")
#
# common_words <- read_excel("data/common_words.xlsx") %>%
#   group_by(word_macron = Word) %>%
#   summarise(meaning = paste0(`Its more frequent meanings`, collapse = "; OR ")) %>%
#   filter(str_detect(word_macron, paste0(unicodes$vowel, collapse = "|")))
#
# place_names <- data.frame(read_csv("data/gaz_names.csv") %>%
#                             select(name) %>%
#                             filter(str_detect(name, paste0(unicodes$vowel, collapse = "|"))) %>%
#                             mutate(name = str_replace_all(name, "[/()]", " ")) %>%
#                             pull(name) %>%
#                             paste0(collapse = " ") %>%
#                             str_split(" "),
#                           stringsAsFactors = FALSE) %>%
#   distinct() %>%
#   rename(word_macron = 1) %>%
#   filter(str_detect(word_macron, paste0(unicodes$vowel, collapse = "|"))) %>%
#   mutate(word_macron = str_remove_all(word_macron, " "),
#          meaning = "Place")
#
# glossary <- bind_rows(common_words, place_names) %>%
#   distinct() %>%
#   mutate(word_ascii = stri_trans_general(word_macron, "Latin-ASCII"),
#          word_ascii_lower = tolower(word_ascii)) %>%
#   group_by(word_ascii_lower) %>%
#   slice(1)
#
# common_words_full <- read_excel("data/common_words.xlsx") %>%
#   group_by(word_macron = Word) %>%
#   summarise(meaning = paste0(`Its more frequent meanings`, collapse = "; OR ")) %>%
#   distinct() %>%
#   mutate(word_ascii = stri_trans_general(word_macron, "Latin-ASCII"),
#          word_ascii_lower = tolower(word_ascii))
#
# save(unicodes, file = "data/unicodes.rdata")
# save(glossary, file = "data/glossary.rdata")
# save(common_words_full, file = "data/common_words_full.rdata")
