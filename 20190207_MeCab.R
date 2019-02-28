#�o�͂���CSV�̑O����
#�P�`�V�s�ڂ��폜

#data�ǂݍ���
data <- read.csv("*******.csv")

#����ɑ΂���񓚂̕����ŁA���ݖ�U���������o��
data2 <- data[data$�ݖ�ԍ�==6,]

#���R�L�q�̐ݖ�U���������o��
data3 <- data2[,7]

#???????????
#�ꏏ�ɂ͂ł��Ȃ��̂��ȁH
datax <- data[data$�ݖ�ԍ�==6,7]


#���R�񓚕����݂̂��e�L�X�g�ŏ����o��
write.table(data3, "C:/Users/i*******/Desktop/output.txt", quote=F,
		col.names=F, row.names=F)

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
head(freq1[order(freq1$Freq,decreasing=T),],30)

#�o���p�x�̍����P��Ń��[�h�N���E�h�쐬
#���C�u����
library(wordcloud)
library(dplyr)

freq1 %>% head(40)

#�s�v�ȒP����폜
freq <- freq3[(!freq3$Term=="����"&
		�@  !freq3$Term=="����"
		   ),]

#���[�h�N���E�h
wordcloud(  words=freq$Term, 
		freq=freq$Freq,
		min.freq=4,
		color=brewer.pal(8, "Dark2"),
		scale=c(7,1.5),#��ԑ傫�Ȍ`�ԑf�Ńt�H���g�T�C�Y�ő�V�A�ŏ��Q�ŕ`��
		family="IPAMincho",
		random.order=TRUE
	    )

#Ngram�ɂ����
#�`�ԑf�̑g�ݍ��킹�̑������J�E���g
ngram <- NgramDF2("output.txt",type=1,pos=c("����","�`�e��","����","����"),N=4,minFreq=3)
ngram <- NgramDF2("output.txt",type=1,pos=c("����","�`�e��","����"),N=4,minFreq=2)
ngram <- NgramDF2("output.txt",type=1,pos=c("����"),N=3,minFreq=2)
ngram[order(ngram$output.txt,decreasing=T),]

ngram %>% head(decreasing=T)
ngram %>% ngram[order(decreasing=T),]
ngram[order(ngram$output.txt,decreasing=T),]





#ngram���l�b�g���[�N����
#���C�u����
library(igraph)

#Ngram���O���t�f�[�^�t���[���ɕϊ�
graph <- graph.data.frame(ngram)

#�`��
plot(graph, 
	vertex.label=V(graph)$name,
	vertex.size=20, 
	vertex.color="#e24565",
	vertex.label.cex=.9,
	edge.color="orange",
	edge.lty=1,
	)

#otehr options
layout=layout.grid
vertex.shape="none"
edge.arrow.size=0

#plot guide
#http://www.nemotos.net/igraph-tutorial/NetSciX_2016_Workshop_ja.html





#�e�L�X�g�}�C�j���O

#2-6
#�O���������Ă���`�ԑf���
#2-7�`�ԑf��͂̊�b
#�`�ԑf���i���������͒P�ꁁ�Ӗ������ŏ��̒P��
#2-8�K�v�ȃ\�t�g�E�F�A���`�ԑf��͊�
#MeCab
#Chasen�AIgo�A
#RMeCab�̃p�b�P�[�W�𗘗p
#R�Ƃ̃p�b�P�[�W������̂�MeCab�̂�
#2-9���ӓ_
#����\����V��i�`�ԑf��͊�̎����ɂȂ��j�A�Г��p��͋��
#MeCab���C���X�g�[������ƃf�X�N�g�b�v�ɃA�C�R���A�J����DOS�v�����v�g
#������2007�N���݁H�H���̍u�`�̎��_
#�ł������̃J�X�^�}�C�Y�͗e�Ձi���@�̃J�X�^�}�C�Y�͓���j
#�E�B�L�̌��o����̕ϊ��c�[��������
#2-10

#http://rmecab.jp�̃T�C�g�ɍs���ăC���X�g�[�������i2019.2.6�j
#mecab-0.996
#R�Ńp�b�P�[�W�̃C���X�g�[���i�v���_�E���ɂ͏o�Ă��Ȃ��j
install.packages("RMeCab" , repos="http://rmecab.jp/R")
library(RMeCab)
#�֐��̈ꗗ���{���ł���H�H
??RMeCab
#2-11
RMeCabC("���͍����̂������т��ƂĂ��y���݂ɂ��Ă��܂�")
#MeCab�̏o�͌��ʂ̑�����list�`���ŋA���Ă���
RMeCabText("example.txt")

#
result <- RMeCabText("example01.txt")
result[[62]]
result[[62]][2]
#
data <- read.csv("example02.csv", header=T)
RMeCabDF(data,"comment",mypref=1)#�񖼂��w�肵�Č`�ԑf��͂��ł���
RMeCabDF(data,3,mypref=1)#����ł�OK

#2-12
#DF�̓f�[�^�t���[��
#mypref���u�P�v�Ǝw�肷��ƌ`�ԑf�����^�ɕϊ����ďo��
#���^�Ƃ͊��p���ꂽ���̂����^�߂��AEX:�Ԃ����Ԃ�
#���ʂ͌`�ԑf��͂͌��^�ł���̂�mypref�͂P�ɂȂ�̂�����	
result <- RMeCabFreq("example03.txt")#�W�v�܂ł��Ă����
#
head(result)
result[order(result$Freq,decreasing=T),]
head(result[order(result$Freq,decreasing=T),])

#2-13 �P��̋��N
#�O��ɗאڂ���`�ԑf���m�̊֌W�����N�Ƃ���������`�ԑf�Ƃ悭�ꏏ�ɏo�Ă���`�ԑf���ĂȂ񂾁H�𒲂ׂ�
#���N���W�v���邽�߂ɂ�collocate�֐����g��
result <- collocate("example04.txt", node="�I�����s�b�N", span=3)
#node="�m�肽�����N�֌W�̕Е����w��"
#span=node�Ŏw�肵���P��̑O�㉽�܂ł��J�E���g�Ώۂɂ��邩
result[order(result$Total),]
tail(result[order(result$Total),])
tail(result[order(result$Total),],10)
#�����΂�����o�Ă���͓̂��{��Ȃ̂œ�����O������ł͕��͂ɂȂ�Ȃ���collScores���g��
#CollScores��T���悭�o�Ă��鋤�N���d�݂Â������w�W
#CollScores��MI���Ⴆ�΃I�����s�b�N�Ƃ������N�������Ȃ�����ȋ��N�ɏd����u���w�W
result2 <- collScores(result,node="�I�����s�b�N",span=3)
result2[(result2$T>=2&result$MI>=2),])

#2-14 Ngram
#Ngram�Ƃ����e�L�X�g�}�C�j���O�̍l����
#����`�ԑf�̑O��ɏo������`�ԑf�̑g�ݍ��킹��Ngram�Ƃ���
#R-����-��{�A�Ƃ��A����-�킩��-�₷���A�Ƃ�
#Ngram��N�͔C�ӂ̐�
#��ʓI�ɂ�N�͂Q����S���炢
Ngram("example05-1.txt", type=1, pos=c("����","����","�`�e��"), N=3)
#type=1�͌��^�ɂ���A�̈Ӗ�
#�܂Ƃ߂����`�ԑf�̎�ނ�pos�Ŏw��
#NgramDF�Ȃ�f�[�^�t���[���ŏo�͂��Ă����
NgramDF("example05-1.txt", type=1, pos=c("����","����","�`�e��"), N=3)
result <- NgramDF("example05-1.txt", type=1, pos=c("����","����","�`�e��"), N=3)
head(result[order(result$Freq,decreasing=T),],10)

#2-15�@�e�L�X�g�Ԃ̊֌W�𕪐́idocDF�j
#docDF�̈����̓f�B���N�g��
#�e�L�X�g�����Ă��邩���Ă��Ȃ���
result <- docDF("example06", type=1, pos=c("����","����","�`�e��"), N=3)
head(result)
#�����̃t�@�C���ɋ��ʐ�������΁A���ʂ��ďo�Ă���Ngram���������t�@�C�����̐����������Ȃ�͂�
#��r����t�@�C���̌������Ⴄ�ƁA���m�Ȕ�r���ł��Ȃ��̂ŁA���̏ꍇ�͎w�W������
#�d�݂Â��̃I�v�V������"tf*idf*norm"������w�̐��E�ł悭�g����d�݂Â��̎w�W
result <- docDF("example06", type=1, pos=c("����","����","�`�e��"), N=3, weight="tf*idf*norm")
#�ǂ�����ĕ\���H�H
result[(result[4]>0.1|result[5]>0.1),0]
#2-16�܂Ƃ�

#2-17�@���͌��ʂ̎��o�I�c���E�l�b�g���[�N����
#�O���t���_
library(igraph)
#
#DF2�ł͍ŏ��p�x��minFreq=�Ƃ��Ďw��ł���
#�Q��ȏ�o�Ă�����̂����𒊏o
ng <- NgramDF2("example05-1.txt",type=1,pos=c("����","�`�e��","����","����"),N=3,minFreq=2)
ng.net <- graph.data.frame(ng)#igraph�̊֐�
#�l�b�g���[�N�}��`��
plot(ng.net,vertex.label=V(ng.net)$name)
plot(ng.net)
#���_�i���̐�[�j��`�ʂ��Ȃ�
plot(ng.net,vertex.label=V(ng.net)$name,vertex.shape="none",edge.arrow.size=0)

#�ǂ̂悤�ɕ��ׂ�ΐ��w�I�ɈӖ������邩�H�͌����Ώ�
#�G�b�W�i�v�f�j�̕��јa���A���S���Y�����w��
plot(ng.net,vertex.label=V(ng.net)$name,layout=layout.kamada.kawai)

plot(ng.net,vertex.label=V(ng.net)$name,layout=layout.circle)
#layout.�Ń^�u�L�[�������ƁA�ق��ɂǂ�ȃ��C�A�E�g�����邩�m�F�ł���
#�ȉ���variation
plot(ng.net,vertex.label=V(ng.net)$name,layout=layout.fruchterman.reingold)
#���x���i�i���j�̃T�C�Y���w��
V(ng.net)$label.cex=1.8
#���_�Ɩ���`�悵�Ȃ�
plot(ng.net,vertex.label=V(ng.net)$name,layout=layout.fruchterman.reingold,vertex.shape="none",edge.arrow.size=0)

#2-18 ���[�h�N���E�h
install.packages("wordcloud")
library(wordcloud)
#
wc <- RMeCabFreq("example08.txt")
#�s�v�Ȍ`�ԑf��remove����
part_wc <- wc[(wc$Info1=="����"|wc$Info1=="������"|wc$Info1=="�`�e��"|wc$Info1=="����")&
	(!wc$Info2=="��"&!wc$Info2=="�ڔ�"&!wc$Info2=="�񎩗�"&!wc$Info2=="�A���t�@�x�b�g"&!wc$Info2=="�i�C�`�e���ꊲ")&
	(!wc$Term=="RT"&!wc$Term==".co"&!wc$Term=="http"&!wc$Term=="www"&!wc$Term=="httptco"&
	 !wc$Term=="bot"&!wc$Term=="����"&!wc$Term=="�t�H���["&!wc$Term=="�t�H��"&!wc$Term=="�l"&!wc$Term=="��"&
	 !wc$Term=="���"&!wc$Term=="����"&!wc$Term=="�"&!wc$Term=="�"&!wc$Term=="�Ȃ�"&!wc$Term=="����"&
	 !wc$Term=="����"&!wc$Term=="���"&!wc$Term=="����"&!wc$Term=="����"&!wc$Term=="����"&!wc$Term=="����"&
	 !wc$Term=="����"&!wc$Term=="������"&!wc$Term=="�Ȃ�"&!wc$Term=="����"&!wc$Term=="�Ȃ�"&!wc$Term=="���"&
	 !wc$Term=="����"&!wc$Term=="�ǂ�"&!wc$Term=="����"&!wc$Term=="����"&!wc$Term=="�C"),]

part_wc<-part_wc[(!part_wc$Term=="a"&!part_wc$Term=="b"&!part_wc$Term=="c"&
!part_wc$Term=="d"&!part_wc$Term=="e"&!part_wc$Term=="f"&!part_wc$Term=="g"&
!part_wc$Term=="h"&!part_wc$Term=="i"&!part_wc$Term=="j"&!part_wc$Term=="k"&
!part_wc$Term=="l"&!part_wc$Term=="m"&!part_wc$Term=="n"&!part_wc$Term=="o"&
!part_wc$Term=="p"&!part_wc$Term=="q"&!part_wc$Term=="r"&!part_wc$Term=="s"&
!part_wc$Term=="t"&!part_wc$Term=="u"&!part_wc$Term=="v"&!part_wc$Term=="w"&
!part_wc$Term=="x"&!part_wc$Term=="y"&!part_wc$Term=="z"&!part_wc$Term=="A"&
!part_wc$Term=="B"&!part_wc$Term=="C"&!part_wc$Term=="D"&!part_wc$Term=="E"&
!part_wc$Term=="F"&!part_wc$Term=="G"&!part_wc$Term=="H"&!part_wc$Term=="I"&
!part_wc$Term=="J"&!part_wc$Term=="K"&!part_wc$Term=="L"&!part_wc$Term=="M"&
!part_wc$Term=="N"&!part_wc$Term=="O"&!part_wc$Term=="P"&!part_wc$Term=="Q"&
!part_wc$Term=="R"&!part_wc$Term=="S"&!part_wc$Term=="T"&!part_wc$Term=="U"&
!part_wc$Term=="V"&!part_wc$Term=="W"&!part_wc$Term=="X"&!part_wc$Term=="Y"&!part_wc$Term=="Z"),]

part_wc<-part_wc[(!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="�A"&
!part_wc$Term=="�C"&!part_wc$Term=="�E"&!part_wc$Term=="�G"&!part_wc$Term=="�I"&
!part_wc$Term=="�J"&!part_wc$Term=="�L"&!part_wc$Term=="�N"&!part_wc$Term=="�P"&
!part_wc$Term=="�R"&!part_wc$Term=="�T"&!part_wc$Term=="�V"&!part_wc$Term=="�X"&
!part_wc$Term=="�Z"&!part_wc$Term=="�\"&!part_wc$Term=="�^"&!part_wc$Term=="�`"&
!part_wc$Term=="�c"&!part_wc$Term=="�e"&!part_wc$Term=="�g"&!part_wc$Term=="�i"&
!part_wc$Term=="�j"&!part_wc$Term=="�k"&!part_wc$Term=="�l"&!part_wc$Term=="�m"&
!part_wc$Term=="�n"&!part_wc$Term=="�q"&!part_wc$Term=="�t"&!part_wc$Term=="�w"&
!part_wc$Term=="�z"&!part_wc$Term=="�}"&!part_wc$Term=="�~"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&!part_wc$Term=="��"&
!part_wc$Term=="�@"&!part_wc$Term=="�B"&!part_wc$Term=="�D"&!part_wc$Term=="�F"&
!part_wc$Term=="�H"&!part_wc$Term=="�["),]
part_wc<-head(part_wc[order(part_wc$Freq,decreasing=T),],n=100)
#�����܂ł��K�v����́H�H��

head(part_wc)
#palette�̐ݒ�(RColorBrewer�Ɉˑ�)
#RColorBrewer�ł�brewer.pal�Ńp���b�g�����
palette <- brewer.pal(8,"Dark2")
palette
#�`��
#�������Œ�Q�K�v
#Freq�͑傫���ɂȂ�
#scale=c(7,2)����ԑ傫�Ȍ`�ԑf�Ńt�H���g�T�C�Y�V�A��ԏ����Ȃ��̂łQ�ŕ`�ʂ��Ă�������
wordcloud(part_wc$Term,part_wc$Freq,scale=c(7,1.5),max.words=Inf,random.order=T,random.color=F,colors=palette)

#Windows���Ɍ����āA�t�H���g��ς�����
#WindowsFont�֐���WindowsFonts�֐��Ƃ����Q������
#WindowsFonts�֐��Ŏg�������t�H���g�̖��O���w�肷��
#���̃t�H���g�ɑ΂���R�̒��ŌĂяo�����߂̃��x���i�����ł�JP1�j������
windowsFonts(JP1=windowsFont("MS Mincho"))
palette <- brewer.pal(9,"Set1")
#�I�v�V������family="JP1"���w��
wordcloud(part_wc$Term,part_wc$Freq,scale=c(7,1.5),max.words=Inf,random.order=T,random.color=F,colors=palette,family="JP1")

#RColorBrewer�p�b�P�[�W�Ŏg�p�\�ȃp���b�g���ꗗ�\��
display.brewer.all()

#2-19 �l�K�|�W����
#�P��ɐ��������|�C���g�A�`�ԑf���Ƀ|�W�e�B�u�ǂ̓_�������Ă���C���[�W
#�����������ɍ��A��荞�ނ��A���L�[�ɂȂ�
#���������ɂǂ�����Ă��̂��킩��Ȃ����


#2-20 ��������
#�N���X�^���͂Ƒ������ړx�@
#term�ƕ����s����쐬����֐��Ƃ���docMatrix
#�����̓f�B���N�g���i�t�H���_�j
#�e�t�@�C���ł���`�ԑf���ǂꂭ�炢�̊����ŏo��������
#�����̏o�������Ă���t�@�C���͎��Ă���
#��ʂ̃e�L�X�g�t�@�C�����������̃O���[�v�ɕ��ނł���
#����������ۂ�
#�N���X�^���͂Ƒ������ړx�@
#�����̎Z�o�i���Ă���x�����j�𐔎��ŕ\����
dist
#������t
#t�A�s��̓]�u�i�s��̓���ւ��j���s���֐�
#canberra�͋������v�Z�����@�̈��
#�f���h���O�����i���`�}�j�Adendrogram
#�������ړx�@��2�����Ŗ������\�L
library(MASS)
#�������Z�o����Ƃ���܂ł͏�Ƌ���

result<-docMatrix("good_point",pos=c("����","����","�`�e��"),weight="tf*idf*norm")
result<-result[row.names(result) != "[[LESS-THAN-1]]",]
result<-result[row.names(result) != "[[TOTAL-TOKENS]]",]
result.dist<-dist(t(result),"canberra")
result.clust<-hclust(result.dist,"ward.D2")
plot(result.clust)
lines(c(1,200),c(750,750),lty=2,lwd=2,col=2)

c<-rect.hclust(result.clust,k=6)

result<-docMatrix("bad_point",pos=c("����","����","�`�e��"),weight="tf*idf*norm")
result<-result[row.names(result) != "[[LESS-THAN-1]]",]
result<-result[row.names(result) != "[[TOTAL-TOKENS]]",]
result.dist<-dist(t(result),"canberra")
result.clust<-hclust(result.dist,"ward.D2")
plot(result.clust)
lines(c(1,150),c(880,880),lty=2,lwd=2,col=2)

c<-rect.hclust(result.clust,k=4)

require(MASS)
#result.samm<-sammon(result.dist)
result.isoMDS<-isoMDS(result.dist)
result.name<-unlist(strsplit(colnames(result),".txt"))
#plot(result.samm$points,type="n")
#text(result.samm$points,lab=result.name)
plot(result.isoMDS$points,type="n")
text(result.isoMDS$points,lab=result.name)
