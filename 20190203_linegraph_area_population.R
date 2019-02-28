#�f�B���N�g���ύX
#���C�u����
library(ggplot2)
library(dplyr)
library(reshape2)#for melt

#�O�����Ƃ��Ċe�t�@�C���iCSV�j���u���O��t����CSV�v�ŕۑ��������K�v����

#�t�@�C�����p�Ƀx�N�g���쐬
time <- c("1809","1803","1709","1703","1609","1603","1509")
time2 <- c("201809","201803","201709","201703","201609","201603","201509")

#data�ǂݍ���
#����ɂ�assign
for(i in seq_along(time)){
assign(paste("hirano_",time[i],sep=""),read.csv(paste("population_",time2[i],"_hirano",".csv",sep="")))
}

#�j���ʂłȂ����v�̍srow�����Ńt�B���^
hirano_1809�@<- hirano_1809 %>% filter(�j����=="�v")
hirano_1803�@<- hirano_1803 %>% filter(�j����=="�v")
hirano_1709�@<- hirano_1709 %>% filter(�j����=="�v")
hirano_1703�@<- hirano_1703 %>% filter(�j����=="�v")
hirano_1609�@<- hirano_1609 %>% filter(�j����=="�v")

#�e�N�x�̃f�[�^����K�v�ӏ����������o���ĐV����DF�쐬
#���Ƃ��΂T�΁i�P�T�s�ڂ��T�΂̃J�����j
age_five <- data.frame(hirano_1809[,2],hirano_1809[,15],hirano_1803[,15],hirano_1709[,15],hirano_1703[,15],hirano_1609[,15])
colnames(age_five) <- (c("area","20180901","20180301","20170901","20170301","20160901"))
#���܂ł��ƂȂ������t�^�ɕϊ�����Ƃ���NA�ɂȂ�
#colnames(age_five) <- (c("area","201809","201803","201709","201703","201609"))

#�����̍s�͍폜
age_five <- age_five %>% filter(area!="����")

#�c���Ɍ���
data <- melt(age_five, id.vars = "area")

#column��rename
data <- rename(data,time=variable)

#���n��f�[�^�i�܂���O���t�j��x������t�^�ɂ��Ă����K�v
#���_����t�^�ɕϊ�
data$time <- as.character(data$time) #�����ł�as.Date�ł��Ȃ����ߕ����ɕϊ�
data$time <- as.Date(data$time, "%Y%m%d") #�����ɕϊ���A���t�ɕϊ�



#�`��
gg1 <-
ggplot(data=data)+
	geom_line(aes(x=time,y=value,colour=area),show.legend=FALSE)+
	geom_text(data=subset(data, time=="2018-09-01"),aes(x=time,y=value,label=area),size=2.8,nudge_x=50,family="Japan1GothicBBB")+
	labs(title="����撬���ڕʐl���i�T�΁j",x="���_",y="�l��")+
	theme_bw(base_family="Japan1GothicBBB")


#�O���t�t�@�C���o��(PDF,png)
ggsave(file = "23_population_hirano.png", plot = gg1)
ggsave(file = "23_population_hirano.pdf", plot = gg1)


#x���𒲐�����i�f�[�^�̎��_�ɍ��킹��j���@���킩��Ȃ�

	scale_x_continuous(breaks="time")

	scale_x_continuous(breaks=c(2016-09,2017-03,2017-09,2018-03,2018-09))

	theme(family="Japan1GothicBBB")

	theme(plot.title=element_text(family="Japan1GothicBBB"))	



theme(legend.position='none',plot.title=element_text(family="Japan1GothicBBB"))+�@#legend�ł���ƕ\���ł��Ȃ��̂�



ggplot(data)+
geom_jitter(aes(x=time,y=value,colour=area))+
theme(legend.position='none')


shape <- st_read("h27ka27126.shp")
plot(st_geometry(shape[1:24,4]))

#dataframe��csv�t�@�C���o�́AShift-JIS��
write.csv(data, file="population_hirano.csv", fileEncoding="CP932",row.names=F)