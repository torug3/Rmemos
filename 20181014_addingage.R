#tidyverse�̓ǂݍ���
library(tidyverse)

setwd("*:/*****/***/***/****")
lung <- read.csv("****.csv")

#���N��������t�^�ɕϊ�
birth <- as.Date(lung$���N����)

#���ݓ��t��ݒ�
current <- rep(as.Date("2018-10-01"),length(birth))

#�N����v�Z���ė�ǉ�
#�i�[�ꏊ��\��
birthy <- numeric(length=length(birth))
#�J��Ԃ������Ōv�Z
for(i in 1:length(birth)) {
birthy[i] <- c(length(seq(birth[i],current[i],by="year")))-1
}

#age�̗��ǉ�
lung <- lung %>% mutate(age=birthy)

#ggplot�ł�����ƃO���t��
gg <- ggplot(data=lung) 
gg  +aes(x=age,fill=����) +geom_histogram()

gg <- ggplot(data=lung) 
gg  +aes(x=age,fill=��f���) +geom_histogram()+
�@�@labs(x="�N��", y="�l��")
