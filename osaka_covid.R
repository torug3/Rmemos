library(tidyverse)
library(readxl)

#Read
cases <-read_xlsx("youseisyajyouhou.xlsx", skip = 1)

#報道提供日＝日ごとの患者数とする
#日付をDate型に（POSIXctでなくDate）
c_number <- cases %>% group_by(報道提供日) %>% count() 
c_number$報道提供日 <- as.Date(c_number$報道提供日)

#日にちの空白がないように
date <- seq(
  from=as.Date("2020-01-29"),
  to=as.Date("2020-07-12"),
  by="day"
) %>% tibble()
#join
c_number_byday <- left_join(date, c_number, by=c("."="報道提供日"))
#NAを0に
c_number_byday[is.na(c_number_byday)] <- 0 

#===========
#検査数
#これは特設サイトから手で拾うしかない
test_data <- read_csv("testnumbers.csv") #%>% mutate(day_week=weekdays(test_data$date))
test_data$date <- as.Date(test_data$date)
test_data <-  test_data %>% mutate(day_week=weekdays(test_data$date))


#検査件数の推移
ggplot(data=test_data)+
  geom_bar(aes(x=date, y=test),stat="identity")+
  labs(title = "検査件数の推移")


#曜日ごとの検査数
test_data %>% 
  ggplot(aes(y=test, x=day_week))+
  geom_bar(stat="identity")

#===========
#検査数と陽性者数を合わせる
data <- left_join(c_number_byday, test_data, by=c("."="date"))
#NAを0に
data$test[is.na(data$test)] <- 0 
#Add day of the week
#data <-  data %>% mutate(day_week=weekdays(data$.))
#Positive Percent
data <-  data %>% mutate(positive_rate=n/test*100)

#Visualise
#陽性率の推移
data %>% filter(positive_rate!=Inf) %>% 
  ggplot()+
  geom_bar(aes(y=positive_rate, x=.),stat="identity")+
  labs(x="日付", title="陽性率の推移")



#報道提供日ごとの数
cases %>% group_by(報道提供日) %>% count() %>% 
  ggplot(aes(x=報道提供日, y=n))+
  geom_bar(stat="identity")+
  labs(x="日付", title="陽性者数の推移")



#年代を順番に並べる
generation <- c("未就学児","就学児","10","20","30","40","50","60",
                "70","80","90","100","調査中")
cases2 <- cases %>% group_by(年代,報道提供日) %>% count() 
cases2$年代 <- factor(cases2$年代, levels=generation) 

#Visualise1
cases2 %>%
  ggplot(aes(x=年代, y=n))+
  geom_bar(stat="identity")

#Visualise2
ggplot(data=cases2, aes(x=報道提供日, y=n, fill=年代))+
  geom_bar(stat="identity")+
  scale_fill_brewer(palette = "Spectral")+
  labs(title = "大阪府の年代別感染者数")

#症状のカラムがいつからかなくなっている
cases %>% group_by(年代,症状) %>% count() %>% 
  ggplot(aes(x=年代, y=n,fill=症状),)+
  geom_bar(stat="identity")
