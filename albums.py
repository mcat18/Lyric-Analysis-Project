import lyricsgenius

genius = lyricsgenius.Genius("token")

ts_1 = genius.search_album("Taylor Swift", "Taylor Swift")
ts_1.save_lyrics()

ts_2 = genius.search_album("Fearless", "Taylor Swift")
ts_2.save_lyrics()

ts_3 = genius.search_album("Speak Now", "Taylor Swift")
ts_3.save_lyrics()

ts_4 = genius.search_album("Red", "Taylor Swift")
ts_4.save_lyrics()

ts_5 = genius.search_album("1989", "Taylor Swift")
ts_5.save_lyrics()

ts_6 = genius.search_album("Reputation", "Taylor Swift")
ts_6.save_lyrics()

ts_7 = genius.search_album("Lover", "Taylor Swift")
ts_7.save_lyrics()

ts_8 = genius.search_album("Folklore", "Taylor Swift")
ts_8.save_lyrics()

ts_9 = genius.search_album("Evermore", "Taylor Swift")
ts_9.save_lyrics()
