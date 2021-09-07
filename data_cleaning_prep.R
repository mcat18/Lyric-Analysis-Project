# Package names
packages <- c("dplyr", "ggplot2", "lubridate", "here", "knitr", "stringr", "tidytext", 
              "wordcloud", "devtools", "RColorBrewer", "ggridges", "wordcloud2", 
              "highcharter", "tm", "ggwordcloud", "syuzhet", "stm", "quanteda", 
              "data.table", "plotly", "tidyverse", "reshape2", "gapminder", "textdata")
# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
# Packages loading
invisible(lapply(packages, library, character.only = TRUE))
#devtools::install_github("lchiffon/wordcloud2", force=TRUE)

#Reading in the data library(quanteda)

here()


debut = read.csv(here("Input", "taylor_swift_debut.csv"))
fearless = read.csv(here("Input", "fearless.csv"))
speak_now = read.csv(here("Input", "speak_now.csv"))
red = read.csv(here("Input", "red.csv"))
ts_1989 = read.csv(here("Input", "ts_1989.csv"))
reputation = read.csv(here("Input", "reputation.csv"))
lover = read.csv(here("Input","lover.csv"))
folklore = read.csv(here("Input", "folklore.csv"))
evermore = read.csv(here("Input", "evermore.csv"))

#checking structure of 1989 to make sure the album is a character 

str(ts_1989)

#it is an interger so we will change it to be a character 

ts_1989$album = as.character(ts_1989$album)

#re-check the structure of 1989 

str(ts_1989)

#Renaming columns names 
evermore = rename(evermore, song = song.title, lyrics = song.lyrics)
fearless = rename(fearless, song = song.title, lyrics = song.lyrics)
folklore = rename(folklore, song = song.title, lyrics = song.lyrics)
red = rename(red, song = song.title, lyrics = song.lyrics)
reputation = rename(reputation, song = song.title, lyrics = song.lyrics)
lover = rename(lover, song = song.title, lyrics = song.lyrics)
speak_now = rename(speak_now, song = song.title, lyrics = song.lyrics)
ts_1989 = rename(ts_1989, song = song.title, lyrics = song.lyrics)


#Creating the tokens for each album, I did this for the initial check to see if there were anymore stop words 
#that needed to be included in the stop words dictionary 

#tokens for debut
tokens = debut %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for evermore
tokens_evermore = evermore %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for fearless 
tokens_fearless = fearless %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for folklore 
tokens_folklore = folklore %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for lover
tokens_lover = lover %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for red
tokens_red = red %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for reputation 
tokens_reputation = reputation %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for speak now 
tokens_speak_now = speak_now %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#tokens for 1989
tokens_1989 = ts_1989 %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))


#Adding more words to the stop words dictionary after looking at the tokens for each album 

other_words = c("wanna", "gonna", "yeah", "da", "tryna", "bout", "la", 
                "lot", "bet", "gettin", "hey", "huh", "mmmm", "ooh", 
                "pre", "uh", "ah", "lettin", "til", "ya", "tis", "woo", 
                "gotta", "la", "mm", "mmm", "whoa", "ha", "shoulda", 
                "wears", "wear", "outta", "woah", "lots", "tee", 
                "eeh", "em", "ya", "ayy", "ho", "ew", "ugh", 
                "di", "da", "ra", "ahh", "gon", "mmh", "git", 
                "mm", "bein", "eh", "haha", "ta", "whoah", "yeugh", 
                "hehe", "hmm", "ya", "na")

type = c("other", "other", "other", "other", "other", "other", "other", "other", "other", "other", 
         "other", "other", "other", "other", "other", "other", "other", "other", "other", "other", 
         "other", "other", "other", "other", "other", "other", "other", "other", "other", "other", 
         "other", "other", "other", "other", "other", "other", "other", "other", "other", "other", 
         "other", "other", "other", "other", "other", "other", "other", "other", "other", "other", 
         "other", "other", "other", "other", "other", "other", "other", "other", "other", "other")

other = data.frame(other_words, type)

colnames(other) = c("word", "lexicon")

stop_words = rbind(stop_words, other)


#Re-running the tokens code with the new stop words
tokens = debut %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_evermore = evermore %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))


tokens_fearless = fearless %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_folklore = folklore %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))


tokens_lover = lover %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_red = red %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_reputation = reputation %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_speak_now = speak_now %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

tokens_1989 = ts_1989 %>% 
  select(song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))


#Creating an dataframe with all the albums 
all_albums = rbind(debut, evermore, fearless, folklore, lover, red, reputation, speak_now, ts_1989)

#tokens of all album lyrics 
clean_all_albums = all_albums %>% 
  select(album, song, lyrics) %>% 
  tidytext::unnest_tokens(output = word, input = lyrics) %>% 
  anti_join(stop_words) %>% 
  filter(!str_detect(word, "[:digit:]")) %>% 
  filter(!str_detect(word, "[:punct:]"))

#Creating top 10 words in all albums dataframe to make a visualization of the top 10 words that appear 
#in all of Taylor Swift's albums 
word_counts_df = clean_all_albums %>% 
  count(word, sort = TRUE)

top_10 = word_counts_df %>% 
  filter(n >= 76)



