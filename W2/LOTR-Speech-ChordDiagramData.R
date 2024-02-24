# Gerekli kütüphaneleri yükle
library(tidyverse)
library(readr)

# Veriyi oku
url <-"https://raw.githubusercontent.com/jennybc/lotr/master/lotr_clean.tsv"
 # .tsv dosyasını oku
lotr_data <- read_tsv(url)

# Yüzük Kardeşliği karakterlerini ve Gandalf'ı filtrele
fellowship_characters <- c("Sam", "Frodo", "Aragorn", "Merry", "Pippin", "Gimli", "Legolas", "Boromir", "Gandalf")
filtered_data <- lotr_data %>%
  filter(Character %in% fellowship_characters)

# Film ve karakterlere göre konuşma sayılarını hesapla
speech_counts <- filtered_data %>%
  group_by(Film, Character) %>%
  summarise(Speech_Count = n(), .groups = 'drop')

# Source-target çiftlerini oluştur
links <- speech_counts %>%
  mutate(source = Character, target = Film, value = Speech_Count) %>%
  select(source, target, value)

write.table(links,"lotr_FOTR.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)