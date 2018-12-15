#�f�B���N�g���ύX
#���C�u����
library(ggplot2)
library(dplyr)
#�f�[�^�̏c���ϊ��p
library(reshape2)

#���f�[�^�i�T���v���Łj
year <- seq(as.Date("2006-01-01"), as.Date("2015-01-01"), by="years")
hosp <- c(7.4,7.3,7.2,7.1,7,7,6.9,6.9,6.9,6.8)
clinic <- c(128.6,129.2,125.6,125.4,125.7,124.7,124.5,125.3,125.8,126.4)
dent <-  c(83.6,84.0,83.6,83.6,83.7,83.7,83.8,84.3,83.9,84.0)
#�f�[�^�t���[���쐬
health <- data.frame(year=year,hospitals=hosp,clinics=clinic,dentists=dent)

#plot�̑O�Ƀf�[�^���c����
health2 <- melt(health, id.vars = "year")
health2 <- rename(health2,category=variable)

#ggplot
graph <- ggplot(health2) + aes(x=year,y=value, colour=category)
#���̑�����size�Ŏw��i�ȗ��j
graph <- graph + geom_line(size=1)
graph <- graph+ scale_colour_brewer(palette = "Set1")
#�`��
plot(graph)

#�O���t�t�@�C���o��
ggsave(file = "something.png", plot = graph)

#dataframe��csv�t�@�C���o�́AShift-JIS��
write.csv(health, file="health.csv", fileEncoding="CP932",row.names=F)