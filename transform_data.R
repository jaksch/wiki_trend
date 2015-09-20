library('readr')
library('lubridate')
library('stringr')
library('dplyr')
options(dplyr.width = Inf)


getwd()
setwd('./data')

files <- list.files()

t <- now()
data_out <- data_frame()
for (i in 1:length(files)) {
  file <- files[i]
  data <- read_delim(file, delim = ' ', col_names = FALSE)
  names(data) <- c('language', 'title', 'count', 'size')
  
  ## find date and hour for events
  date <- str_extract(file, '[0-9]{8}') %>% ymd() %>% as.character()
  hour <- str_extract(file, '[0-9]{6}[.]gz') %>% str_extract(., '^.{2}')
  
  ## find norwegian events
  no_data <- filter(data, language == 'no', count >= 10) %>% arrange(desc(count))
  no_data2 <- no_data %>% 
    select(-size)
  
  ## find english events
  en_data <- filter(data, language == 'en', count >= 100) %>% arrange(desc(count))
  en_data2 <- en_data %>% 
    select(-size)
  
  ## combine norwegian and english data
  temp_data <- bind_rows(no_data, en_data)
  
  ## add date and hour to data
  temp_data$date <- date
  temp_data$hour <- hour
  
  ## combine with other dates and hours
  data_out <- bind_rows(data_out, temp_data)
  
  print(file)
}
tt <- now()
tt-t ## 32 min for 3 days (2015-09-10 - 2015-09-12)

head(data_out)
nrow(data_out)

setwd('C:/R/wiki_trend/etl_data')

save(data_out, file = '2015-09-10_2015-09-12_compressed.RData')

## end