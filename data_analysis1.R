library('stringr')
library('dplyr')
library('ggplot2')
library('lubridate')
import::from('Hmisc', '%nin%')

options(dplyr.width = Inf)

getwd()
setwd('./wiki_trend/etl_data')

list.files()

load(list.files()[2])
head(data_out)
nrow(data_out)
data_out <- unique(data_out)

data_no <- filter(data_out, language == 'no')
head(data_no)
nrow(data_no)

length(unique(data_no$title))
data_no %>% arrange(desc(count)) %>% head(20)

remove <- c('index.html', 'Portal:Forside', 'Https//dmp.pro.cn/html')
data_no2 <- filter(data_no, title %nin% remove)
data_no2 %>% arrange(desc(count)) %>% head(20)

data_no3 <- data_no2[!str_detect(data_no2$title, 'Kategori:'), ]
data_no3 %>% arrange(desc(count)) %>% head(20)

data_no4 <- data_no3[!str_detect(data_no3$title, 'Wikipedia'), ]
data_no4 %>% arrange(desc(count)) %>% head(20)

data_no5 <- data_no4[!str_detect(data_no4$title, 'Portal:'), ]
data_no5 %>% arrange(desc(count)) %>% as.data.frame() %>% head(50)

nrow(data_no5)

filter(data_no5, title == 'Ostekake') %>% arrange(date, hour)



## english events
data_en <- filter(data_out, language == 'en')
head(data_en)
nrow(data_en)

data_en2 <- data_en[nchar(data_en$title)<50, ]
nrow(data_en2)
data_en2 %>% arrange(desc(count)) %>% head(20)

remove <- c('Main_Page', 'index.html')
data_en3 <- filter(data_en2, title %nin% remove)
data_en3 %>% arrange(desc(count)) %>% head(20)

data_en4 <- data_en3[!str_detect(data_en3$title, 'Special:'), ]
data_en4 %>% arrange(desc(count)) %>% as.data.frame() %>% head(100)

data_en5 <- data_en4[!str_detect(data_en4$title, '^[0-9]+$'), ]
data_en5 %>% arrange(desc(count)) %>% as.data.frame() %>% head(100)




## test
plot_data <- filter(data_en4, title == 'Roger_Federer') %>% arrange(date, hour) %>% 
  mutate(date_time = ymd_h(paste(date, hour)))
ggplot(data = plot_data, aes(x = date_time, y = count)) +
  geom_bar(stat = 'identity')

plot_data2 <- filter(data_out, title == 'Starship_Troopers_(film)') %>% arrange(date, hour) %>% 
  mutate(date_time = ymd_h(paste(date, hour)))
ggplot(data = plot_data2, aes(x = date_time, y = count)) +
  geom_bar(stat = 'identity')


unique(plot_data2$language)
filter(plot_data2, language == 'no.m')

## end