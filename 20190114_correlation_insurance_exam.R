#�f�B���N�g���ύX
#���C�u����
library(stringr)#for extract
library(dplyr)#rename
library(ggplot2)

#�P�D2017�N
#�f�[�^�ǂݍ���
lung17 <- read.csv("lung_2017.csv")
stomach17 <- read.csv("stomach_2017.csv")
breast17 <- read.csv("breast_2017.csv")
uterine17 <- read.csv("uterine_2017.csv")
intestine17 <- read.csv("intestine_2017.csv")


#�n����於�܂łɂ���ward�̗�ǉ�
lung17$ward <- str_extract(lung17$�n��,"\\w+��")
stomach17$ward <- str_extract(stomach17$�n��,"\\w+��")
breast17$ward <- str_extract(breast17$�n��,"\\w+��")
uterine17$ward <- str_extract(uterine17$�n��,"\\w+��")
intestine17$ward <- str_extract(intestine17$�n��,"\\w+��")

#�悲�ƂɃJ�E���g���ĐV����data.frame�쐬
lung <- data.frame(table(lung17$ward))
colnames(lung) <- c("ward_name","lung")

stomach <- data.frame(table(stomach17$ward))
colnames(stomach) <- c("ward_name","stomach")

breast <- data.frame(table(breast17$ward))
colnames(breast) <- c("ward_name","breast")

uterine <- data.frame(table(uterine17$ward))
colnames(uterine) <- c("ward_name","uterine")

intestine <- data.frame(table(intestine17$ward))
colnames(intestine) <- c("ward_name","intestine")


#�e����f�[�^������
lungandstomach <- left_join(lung,stomach,by="ward_name")
twoplusbreast <- left_join(lungandstomach,breast,by="ward_name")
threeplusuterine <- left_join(twoplusbreast,uterine,by="ward_name")
cancer <- left_join(threeplusuterine,intestine,by="ward_name")

#sum���ǉ�
cancer <- cancer %>% mutate(sum=(apply(cancer[2:6],1,sum)))


#KDB�f�[�^�ǂݍ���
kdb17 <- read.csv("kdbdata_2017.csv")

#�킩��₷��rename���Ă���
kdb17 <- rename(kdb17,ward_name=ward)

#�������v�Z���ė�ǉ�
kdb17 <- mutate(kdb17,percentage=round(kdb17[,2]/kdb17[,3]*100, digits=2))

#KDB�f�[�^�ƌ���
data <- left_join(kdb17,cancer,by="ward_name")

#���s�S�̂̍s���폜
data <- data[-1,]

#��f���i��f�Ґ�/�l���j�̗��ǉ�
data <- mutate(data,exampercent=round(data$sum/data$population*100, digits=2))


#�P�|�Q�D�S����i��f���j

#�ǂ̃f�[�^��ggplot���邩�Ax����y�������ɂ��邩
gg1 <- ggplot(data, aes(x=data$percentage,y=data$exampercent))
#�ǂ̃^�C�v�̕`�ʂ����邩�i�U�z�}��geom_point�j
gg2 <- gg1 + geom_point(size=2)
#��A��������
gg3 <- gg2 + geom_smooth(method="lm",se=FALSE)
#�e�[�}��ݒ�A�t�H���g��
gg4 <- gg3 + theme_bw(base_family="Japan1GothicBBB")
#���̕ҏW
gg5 <- gg4 + labs(x="���ۗ��i���ۉ����Ґ��^�l���j",y="�T�����f���i��f�Ґ��^�l���j")


#expression�͐����̕`��Ɏg��
#2���R^2�Ƃ��A�~��%*%�Ƃ�
#format�͐����̌��������낦�邽��
#�l�̌ܓ��Ƃ��Ƃ͂�����ƈႤ�H

#����W������������
linerm_per <- lm(data$percentage~data$exampercent)
rs <- format(summary(linerm_per)$r.squared, digits = 3)
rsquared <- paste(expression("R^2=="),rs)
gg6 <- gg5 + annotate("text",x=29,y=6,label=rsquared,parse=TRUE)

#���֌W������������
#���֌W��
#-0.6165335
core <- format(cor(data$percentage,data$exampercent), digits=3)
coefficient <- paste(expression("r=="),core)
gg7 <- gg6 + annotate("text",x=30,y=14,label=coefficient,parse=TRUE)

#�s�A�\���̖����֌���
cor.test(data$percentage,data$exampercent, method="pearson")


#��A������������
#��������܂�
a <- format(coef(linerm)[1], digits=2)
b <- format(coef(linerm)[2], digits=2)

a_and_b <- paste(expression("y=="),a,expression(ifelse(b<0,"-",ifelse(b=0,"","+"))),b,expression("%*%"),"x")
gg6 <- gg5 + annotate("text",x=27,y=6,label=a_and_b,parse=TRUE)
gg6

plot(gg7)

a_and_b

#�Ȃ�����ł͂�����̂�
a_and_b <- paste(expression("y=="),a,expression("+"),b,expression("%*%"),"x")
gg6 <- gg5 + annotate("text",x=30,y=15000,label=a_and_b,parse=TRUE)
gg6

#����ł͂��߁H
a_and_b <- paste(expression("y=="),a,expression("+"),b,"x")
gg6 <- gg5 + annotate("text",x=30,y=15000,label=a_and_b,parse=TRUE)
gg6

plot(gg7)

#����W����
#Rsquared:0.3801
#adjusted:0.3519
summary(linerm_per)


#�O���t�t�@�C���o��(PDF)
ggsave(file = "74_2017_correlation_exampercent_sum_nationalinsurance.pdf", plot = gg7)


#�P�|�R�D�S����i��f�Ґ��j

#�ǂ̃f�[�^��ggplot���邩�Ax����y�������ɂ��邩
gg1 <- ggplot(data, aes(x=data$percentage,y=data$sum))
#�ǂ̃^�C�v�̕`�ʂ����邩�i�U�z�}��geom_point�j
gg2 <- gg1 + geom_point(size=2)
#��A��������
gg3 <- gg2 + geom_smooth(method="lm",se=FALSE)
#�e�[�}��ݒ�A�t�H���g��
gg4 <- gg3 + theme_bw(base_family="Japan1GothicBBB")
#���̕ҏW
gg5 <- gg4 + labs(x="���ۗ��i���ۉ����Ґ��^�l���j",y="�T�����f�Ґ�")


#expression�͐����̕`��Ɏg��
#2���R^2�Ƃ��A�~��%*%�Ƃ�
#format�͐����̌��������낦�邽��
#�l�̌ܓ��Ƃ��Ƃ͂�����ƈႤ�H

#����W������������
linerm <- lm(data$percentage~data$sum)
rs <- format(summary(linerm)$r.squared, digits = 3)
rsquared <- paste(expression("R^2=="),rs)
gg6 <- gg5 + annotate("text",x=30,y=15000,label=rsquared,parse=TRUE)

#��A������������
#��������܂�
a <- format(coef(linerm)[1], digits=2)
b <- format(coef(linerm)[2], digits=2)

a_and_b <- paste(expression("y=="),a,expression(ifelse(b<0,"-",ifelse(b=0,"","+"))),b,expression("%*%"),"x")
gg6 <- gg5 + annotate("text",x=30,y=15000,label=a_and_b,parse=TRUE)
gg6

plot(gg6)

a_and_b

#�Ȃ�����ł͂�����̂�
a_and_b <- paste(expression("y=="),a,expression("+"),b,expression("%*%"),"x")
gg6 <- gg5 + annotate("text",x=30,y=15000,label=a_and_b,parse=TRUE)
gg6

#����ł͂��߁H
a_and_b <- paste(expression("y=="),a,expression("+"),b,"x")
gg6 <- gg5 + annotate("text",x=30,y=15000,label=a_and_b,parse=TRUE)
gg6

#���֌W��
#-0.4080177
cor(data$percentage,data$sum)

#����W����
#Rsquared:0.1665
#adjusted:0.1286
linerm <- lm(data$percentage~data$sum)
summary(linerm)


#�O���t�t�@�C���o��(PDF)
ggsave(file = "75_correlation_examnumbers_sum_nationalinsurance.pdf", plot = gg6)









#�Q�|�P�D2016�N
#�f�[�^�ǂݍ���
lung16 <- read.csv("lung_2016.csv")
stomach16 <- read.csv("stomach_2016.csv")
breast16 <- read.csv("breast_2016.csv")
uterine16 <- read.csv("uterine_2016.csv")
intestine16 <- read.csv("intestine_2016.csv")


#�n����於�܂łɂ���ward�̗�ǉ�
lung16$ward <- str_extract(lung16$�n��,"\\w+��")
stomach16$ward <- str_extract(stomach16$�n��,"\\w+��")
breast16$ward <- str_extract(breast16$�n��,"\\w+��")
uterine16$ward <- str_extract(uterine16$�n��,"\\w+��")
intestine16$ward <- str_extract(intestine16$�n��,"\\w+��")

#�悲�ƂɃJ�E���g���ĐV����data.frame�쐬
lung <- data.frame(table(lung16$ward))
colnames(lung) <- c("ward_name","lung")

stomach <- data.frame(table(stomach16$ward))
colnames(stomach) <- c("ward_name","stomach")

breast <- data.frame(table(breast16$ward))
colnames(breast) <- c("ward_name","breast")

uterine <- data.frame(table(uterine16$ward))
colnames(uterine) <- c("ward_name","uterine")

intestine <- data.frame(table(intestine16$ward))
colnames(intestine) <- c("ward_name","intestine")


#�e����f�[�^������
lungandstomach <- left_join(lung,stomach,by="ward_name")
twoplusbreast <- left_join(lungandstomach,breast,by="ward_name")
threeplusuterine <- left_join(twoplusbreast,uterine,by="ward_name")
cancer <- left_join(threeplusuterine,intestine,by="ward_name")

#sum���ǉ�
cancer <- cancer %>% mutate(sum=(apply(cancer[2:6],1,sum)))


#KDB�f�[�^�ǂݍ���
kdb16 <- read.csv("kdbdata_2016.csv")

#�킩��₷��rename���Ă���
kdb16 <- rename(kdb16,ward_name=ward)

#�������v�Z���ė�ǉ�
kdb16 <- mutate(kdb16,percentage=round(kdb16[,2]/kdb16[,3]*100, digits=2))

#KDB�f�[�^�ƌ���
data <- left_join(kdb16,cancer,by="ward_name")

#���s�S�̂̍s���폜
data <- data[-1,]

#��f���i��f�Ґ�/�l���j�̗��ǉ�
data <- mutate(data,exampercent=round(data$sum/data$population*100, digits=2))


#�Q�|�P�D�S����i��f���j

#�ǂ̃f�[�^��ggplot���邩�Ax����y�������ɂ��邩
gg1 <- ggplot(data, aes(x=data$percentage,y=data$exampercent))
#�ǂ̃^�C�v�̕`�ʂ����邩�i�U�z�}��geom_point�j
gg2 <- gg1 + geom_point(size=2)
#��A��������
gg3 <- gg2 + geom_smooth(method="lm",se=FALSE)
#�e�[�}��ݒ�A�t�H���g��
gg4 <- gg3 + theme_bw(base_family="Japan1GothicBBB")
#���̕ҏW
gg5 <- gg4 + labs(x="���ۗ��i���ۉ����Ґ��^�l���j",y="�T�����f���i��f�Ґ��^�l���j")


#expression�͐����̕`��Ɏg��
#2���R^2�Ƃ��A�~��%*%�Ƃ�
#format�͐����̌��������낦�邽��
#�l�̌ܓ��Ƃ��Ƃ͂�����ƈႤ�H

#����W������������
linerm_per <- lm(data$percentage~data$exampercent)
rs <- format(summary(linerm_per)$r.squared, digits = 3)
rsquared <- paste(expression("R^2=="),rs)
gg6 <- gg5 + annotate("text",x=38,y=7.2,label=rsquared,parse=TRUE)

#���֌W������������
#���֌W��
#-0.6165335
core <- format(cor(data$percentage,data$exampercent), digits=3)
coefficient <- paste(expression("r=="),core)
gg7 <- gg6 + annotate("text",x=40,y=15,label=coefficient,parse=TRUE)

#��A������������
#��������܂�


#����W����
#Rsquared:0.3801
#adjusted:0.3519
summary(linerm_per)

plot(gg7)

#�O���t�t�@�C���o��(PDF)
ggsave(file = "73_2016_correlation_exampercent_sum_nationalinsurance.pdf", plot = gg7)


#1.covariance����v�Z
per<-data$percentage
sum<-data$sum

#mean
permean<-mean(per)
summean<-mean(sum)
#numerator for cov
cornumerator<-sum((per-permean)*(sum-summean))
#calculation(numarator for R)
cornumerator<-cornumerator/length(per)
cornumerator

#comparison
cov(data$percentage,data$sum)


#2.R(cor)����v�Z

#SD
persd<-sd(per)
sumsd<-sd(sum)
#calculation(denominator for R)
cordenominator<-persd*sumsd
numberR <- cornumerator/cordenominator
numberR
#comparison
cor(data$percentage,data$sum)


#��A���������ꍇ��alternative�i���U�@�j
slopea <- cov(data$percentage,data$sum)/var(data$percentage)
interceptb <- mean(data$sum)-slopea*mean(data$percentage)
slopea
interceptb

gg3 <- gg2 + geom_abline(slope=slopea,intercept=interceptb,colour="purple")
plot(gg3)





