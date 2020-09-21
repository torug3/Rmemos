library(tidyverse)


tgturl <- "https://www.city.osaka.lg.jp/seisakukikakushitsu/page/0000486959.html#shorijyoukyou"
shiminkoe <- tgturl %>% 
  xml2::read_html() %>% 
  rvest::html_node(xpath = '//*[@id="mol_contents"]/div[14]/div/table') %>% 
  rvest::html_table()

shiminkoe1 <- shiminkoe[1:32,1:13]
shiminkoe2 <- apply(shiminkoe1[,2:13],2,as.numeric) %>% as.data.frame()
shiminkoe3 <- cbind(shiminkoe[,1],shiminkoe2)
shiminkoe4 <- shiminkoe3 %>% rename(category=`shiminkoe[, 1]`)

shimin_nokoe <- pivot_longer(data = shiminkoe4, col=-category, names_to="month", values_to= "amount")

month_order <- c("4月","5月","6月","7月","8月","9月","10月","11月","12月","1月","2月","3月")
shimin_nokoe$month <- factor(shimin_nokoe$month, levels=month_order) 


ggplot(data = shimin_nokoe)+
  geom_histogram(aes(x=amount))

ggplot(data = shimin_nokoe)+
  geom_bar(aes(x=month,y=amount),stat = "identity")

ggplot(data = shimin_nokoe)+
  geom_tile(aes(x=month,y=category, fill=amount))+
  scale_fill_distiller(palette="Oranges", direction = 1)+
  labs(title="市民の声受付件数（平成30年度）", x=NULL, y=NULL, fill="件数")

