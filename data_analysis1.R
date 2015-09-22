library('stringr')
library('dplyr')
import::from('Hmisc', '%nin%')

getwd()
setwd('./etl_data')

list.files()

load(list.files())
head(data_out)
nrow(data_out)

data_no <- filter(data_out, language == 'no')
head(data_no)
nrow(data_no)


length(unique(data_no$title))
data_no %>% arrange(desc(count)) %>% head(20)



remove <- c('index.html', 'Portal:Forside', 'Https//dmp.pro.cn/html')
data_no2 <- filter(data_no, title %nin% remove)

data_no2 %>% arrange(desc(count)) %>% head(20)


data_no2[!str_detect(data_no2$title, 'Spesial:|Special:'), ] %>% head(20)

data_no2[str_detect(data_no2$title, 'Wikipedia:'), ]$title %>% unique()
