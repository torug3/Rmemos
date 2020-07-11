library(tidyverse)
library(readxl)

#ファイルはe-stat
#住民基本台帳に基づく人口、人口動態及び世帯数調査、より
#表番号19-03、【総計】市区町村別人口、人口動態及び世帯数、を使用

#Read and divide into each municipality type
village <- read_xlsx("1903ssjin.xlsx", skip = 3) %>% 
  filter(str_detect(...3,"村$")) 

town <- read_xlsx("1903ssjin.xlsx", skip = 3) %>% 
  filter(str_detect(...3,"町$")) 

city <- read_xlsx("1903ssjin.xlsx", skip = 3) %>% 
  filter(str_detect(...3,"市$")) 


#人口合計
sum(city$計,town$計,village$計)


#市町村別人口の平均
mean(village$計)
mean(town$計)
mean(city$計)

#Easy hist
hist(village$計, breaks=200)

#指数表記の回避
options(scipen=1)

#ggplot
ggplot(data=village)+
  geom_histogram(aes(x=計))+
  labs(x="人口")

ggplot(data=town)+
  geom_histogram(aes(x=計))+
  labs(x="人口")

ggplot(data=city)+
  geom_histogram(aes(x=計))+
  labs(x="人口")
