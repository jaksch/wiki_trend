library('stringr')

url1 <- 'http://dumps.wikimedia.org/other/pagecounts-raw/2015/2015-09/'

start_date <- '2015-09-10'
end_date <- '2015-09-18'

day1 <- str_extract(start_date, '[0-9]{2}$')
day2 <- str_extract(end_date, '[0-9]{2}$')
day1 <- as.numeric(str_replace(day1, '^[0]{1}', ''))
day2 <- as.numeric(str_replace(day2, '^[0]{1}', ''))

days <- day1:day2

hours <- 0:23
hours2 <- c(paste0('0', hours[nchar(hours) == 1]), hours[nchar(hours) == 2])

setwd('./data')
for (i in 1:length(days)) {
  date <- days[i]
  for (j in 1:24) {
    hour <- hours2[j]
    
    temp_file <- paste0('pagecounts-201509', date, '-', hour, '0000.gz')
    download.file(url = paste0(url1, temp_file), destfile = temp_file)
  }
}
setwd('~/R/wiki_trend')


file <- 'pagecounts-20150901-000000.gz'

