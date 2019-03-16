library(ggplot2)
library(dplyr)

#�P�D��u����
#data�ǂݍ���
#�O�������Ȃ��Ă�skip�ŕs�v�ȍs�͓ǂݍ��܂Ȃ�
history <- read.csv("******.csv", skip=4, fileEncoding="CP932")

#����u�������A��u�������Ō���
history$�R�[�X��u������ <- as.POSIXct(history$�R�[�X��u������, format="%Y/%m/%d %H:%M:%S", tz = "Japan")

#��u�󋵂̔c��
table(history$�R�[�X��u��)


#�Q�D�e�X�g
#data�ǂݍ���
#�O�������Ȃ��Ă�skip�ŕs�v�ȍs�͓ǂݍ��܂Ȃ�
history <- read.csv("********.csv", skip=4, fileEncoding="CP932")


#�R�D�A���P�[�g
#data�ǂݍ���
#�O�������Ȃ��Ă�skip�ŕs�v�ȍs�͓ǂݍ��܂Ȃ�
questionnaire <- read.csv("******.csv", skip=6, fileEncoding="CP932")

#�񓚏󋵂̔c��
table(questionnaire$�ݖ�ԍ�)

#���Ԃ̂��̂�POSIXct�^��
questionnaire$���{���� <- as.POSIXct(questionnaire$���{����, format="%Y/%m/%d %H:%M:%S", tz = "Japan")

#�e�X�g�̒l�͏���
questionnaire <- questionnaire %>% filter(���{���� > as.POSIXct("2019-02-04 00:00:00"))

#�A���P�[�g�̐ݖ₲�Ƃŕ���
q1 <- questionnaire[questionnaire$�ݖ�ԍ�==1,]
q2 <- questionnaire[questionnaire$�ݖ�ԍ�==2,]
q3 <- questionnaire[questionnaire$�ݖ�ԍ�==3,]
q4 <- questionnaire[questionnaire$�ݖ�ԍ�==4,]
q5 <- questionnaire[questionnaire$�ݖ�ԍ�==5,]


#�ݖ₲�Ƃɉ񓚏󋵂�����
#Q1
qq1 <- ggplot(data=q1)+
geom_bar(aes(x=�񓚔ԍ�),fill="hotpink1")+
xlab("Q1�F���Ȃ��́A���̌��C���󂯂�܂ŁA�I�[�v���f�[�^�ɂ��Ăǂ̒��x�����m�ł�����")+
ylim(0,6000)+
scale_x_discrete(labels=c("�悭�m���Ă���","�m���Ă���","���܂�m��Ȃ�����","�S���m��Ȃ�����"))

ggsave(plot = qq1, file = "Q1.png")

#Q2
qq2 <- ggplot(data=q2)+
geom_bar(aes(x=�񓚔ԍ�),fill="plum")+
xlab("Q2�F���Ȃ��́A���s�I�[�v���f�[�^�|�[�^���T�C�g�ɂ��Ăǂ̒��x�m���Ă��܂�����")+
ylim(0,6000)+
scale_x_discrete(labels=c("�f�[�^���������Ƃ�����","�f�[�^�͌������Ƃ��Ȃ�","�T�C�g�͒m���Ă���","�T�C�g��m��Ȃ�����"))

ggsave(plot = qq2, file = "Q2.png")


#Q3
qq3 <- ggplot(data=q3)+
geom_bar(aes(x=�񓚔ԍ�),fill="orange")+
xlab("Q3�F���̌��C���󂯂āA�u�l�����₷���f�[�^�v�Ɓu�@�B���ǐ��̍����f�[�^�v�̈Ⴂ�ɂ��ė����ł��܂�����")+
scale_x_discrete(labels=c("�悭�����ł���","�����ł���","���܂藝���ł��Ȃ�����","�S�������ł��Ȃ�����"))

ggsave(plot = qq3, file = "Q3.png")

#Q4
qq4 <- ggplot(data=q4)+
geom_bar(aes(x=�񓚔ԍ�),fill="yellowgreen")+
ylim(0,8400)+
xlab("Q4�F���Ȃ��́A����܂ŋƖ���Word�t�@�C����������Excel�t�@�C�����쐬�������Ƃ�����܂���")+
scale_x_discrete(labels=c("�͂�","������","�킩��Ȃ�"))

ggsave(plot = qq4, file = "Q4.png")

#Q5
qq5 <- ggplot(data=q5)+
geom_bar(aes(x=�񓚔ԍ�),fill="skyblue")+
ylim(0,8400)+
xlab("Q5�F���Ȃ��́A����܂ŋƖ���CSV�t�@�C�����쐬�������Ƃ�����܂���")+
scale_x_discrete(labels=c("�͂�","������","�킩��Ȃ�"))

ggsave(plot = qq5, file = "Q5.png")



#�A���P�[�g�̎��R�L�q�ɂ��ă��[�h�N���E�h�ƃl�b�g���[�N�O���t

#data�ǂݍ���
data <- read.csv("***********.csv", skip=6, fileEncoding="CP932")

#����ɑ΂���񓚂̕����ŁA���ݖ�U���������o��
datax <- data[data$�ݖ�ԍ�==6,7]

#���ɂȂ��A�Ȃǂ��폜
datay <- datax[-which(datax %in% c("�����Ȃ��B","��������܂���","�Ƃ��ɂȂ�","�ʂɂȂ�","���ɂȂ�","���ɂȂ��ł��B","nasi","�Ȃ�","���L�����Ȃ�","���ɁA�������܂���B","���ɂȂ��B","���ɂȂ��B","���ɂȂ�","���ɖ���","���ɖ����B","���ɖ����B","�Ȃ�","�Ȃ��B","���i�Ȃ�","����","���ɂ������܂���B","���ɂ���܂���","���ɂ���܂���B","�@���ɂ���܂���B","���Ɏv��������܂���B","���i����܂���B"))]

#���R�񓚕����݂̂��e�L�X�g�ŏ����o��
write.table(datay, "C:/Users/*****/Desktop/output.txt", quote=F, col.names=F, row.names=F)

#package
library(RMeCab)

#�P��̏o���p�x�𒲂ׂ�

#term��freqency�𐔂���
freq1 <- RMeCabFreq("output.txt")#�W�v�܂ł��Ă����

#�����Ɠ����݂̂𒊏o
freq2 <- subset(freq1, Info1 %in% c("����", "����", "�`�e��"))

#�ו��ށiInfo2�j����s�v�Ȃ��̂����O
freq3 <- subset(freq2, !Info2 %in% c("��", "�񎩗�", "�ڔ�"))

#decreasing��30���Ă݂�
head(freq3[order(freq3$Freq,decreasing=T),],30)

#�o���p�x�̍����P��Ń��[�h�N���E�h�쐬
#���C�u����
library(wordcloud)

#�s�v�ȒP����폜
freq <- freq3[(!freq3$Term=="����"&
		�@  !freq3$Term=="����"&
		�@  !freq3$Term=="�Ȃ�"&
		�@  !freq3$Term=="�v��"
		   ),]

#���[�h�N���E�h
wordcloud(  words=freq$Term, 
		freq=freq$Freq,
		min.freq=4,
		color=brewer.pal(8, "Dark2"),
		scale=c(7,1.5),#��ԑ傫�Ȍ`�ԑf�Ńt�H���g�T�C�Y�ő�V�A�ŏ�1.5�ŕ`��
		family="IPAMincho",
		random.order=TRUE
	    )

#Ngram�ɂ����
#�`�ԑf�̑g�ݍ��킹�̑������J�E���g
ngram <- NgramDF2("output.txt",type=1,pos=c("����","�`�e��","����","����"),N=3,minFreq=3)

#ngram���l�b�g���[�N����
#���C�u����
library(igraph)

#Ngram���O���t�f�[�^�t���[���ɕϊ�
graph <- graph.data.frame(ngram)

#�`��
plot(graph, 
	vertex.label=V(graph)$name,
	vertex.size=15, 
	vertex.color="lightgreen",
	vertex.label.cex=.9,
	edge.color="orange",
	edge.lty=1,
	)
