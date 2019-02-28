library(dplyr)
library(stringr)#for extract
library(sf)
library(ggplot2)

#��Ë@�ֈꗗ�̑O����
#1�s�ڂ��폜
#csv�`���ŕۑ�
#����̃T�C�g�ŃA�h���X�}�b�`���O����coordinate�t�^���Ă���
#�J�����𐮂�


#��f�҃f�[�^�ǂݍ���
data <- read.csv("stomach_2017.csv")

#��Ë@�ֈꗗ�f�[�^�ǂݍ���
clinics <- read.csv("clinics.csv")

#left_join�̂��߂�rename
data <- data %>% rename(code="���f�@�փR�[�h")
clinics <- clinics %>% rename(code="��ÃR�[�h")

#��f�҈ꗗ�Ɉ�Ë@�ւ�combine����coordinate�t�^
data <- data %>% left_join(clinics, by="code")

#��f�҂̏Z���i���Z��j��No���ӂ�
data$ward_name <- str_extract(data$�n��,"\\w+��")
ward_No <- 1:24
ward_name <- c("�k��","�s����","������","���ԋ�","������","����","�`��","�吳��","�V������","�Q����","�������","�����","�������","������","�����","����","�铌��","�ߌ���","���{���","�Z�V�]��", "�Z�g��", "���Z�g��", "�����","������")
ward <- data.frame(ward_No, ward_name)
data <- data %>% left_join(ward, by="ward_name")

#�Z���悲�Ƃ̎�f�ҕϐ����쐬�i1=�k�悩��24=������j
for(i in 1:24){
	assign(paste("data_",i,sep=""), filter(data, ward_No==i))
}

#�]�v�ȃJ�������폜���Č��₷���������I
for(i in 1:24){
	data_i <- data_[i][,c(-18:-31)]
}
paste("data_",1,"[,c(-18:-31)]",sep="")

data_1[,18:31] <- NULL
head(data_1[c(-18:-31)])
for(i in 1:24){
	assign(paste("data_",i,"[,c(-18:-31)]",sep=""),NULL)
}
data_12 %>% head
data_1 %>% names
data %>% head(100) %>% filter(ward_No==21)
data_12 %>% ncol
data %>% nrow
ward %>% head
clinics %>% head

#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
shape <- st_read("h27_did_27.shp") 
#��̕��т𐮂���
shape <- shape[c(23,1,2,3,24,4,5,6,7,8,9,19,10,11,12,13,14,20,15,21,16,17,22,18),]
#�K�v�Ȍ��̂ݎ��o���i���̏����s�v�H�j
shape <- shape[1:24,5:7]
#�F�h�肵������Ƀt���O�i1�j�𗧂Ă�
tag_1 <- c(1,rep(0,23))
x <- 1:23
for(i in x){
assign(paste("tag_",x[i],sep=""), c(rep(0,length=i-1),1,rep(0,length=(24-i))))
}
tag_24 <- c(rep(0,23),1)
#�V�F�[�v�t�@�C���Ƀt���O��ǉ�
for(i in 1:24){
shape <-
	eval(
	parse(
	text=paste("transform(shape,tag_",i,"=tag_",i,")",sep="")
	)
	)
}

#�`��



#��f�҂������Ƃ���͑傫���v���b�g������
#���o���J������
name <- c("code","lon","lat","��Ë@�֖�","���f�@��")
#�K�v�ȃJ���������o����24�敪�쐬�iplace_n�ō쐬�j
z <- 1:24
for(i in z){
	assign(paste("place_",i,sep=""),
	eval(
	parse(
	text=paste("data_",i,"[,name]",sep="")
	))
	)
}

#�����W�v���ăJ�E���g
for(i in z){
	assign(paste("place_",i,sep=""),
		 get(paste("place_",i,sep="")) %>% group_by(code,���f�@��) %>% summarise(n=n())
		)
}

#�ʒu���t�^
for(i in z){
	assign(paste("place_",i,sep=""),
	left_join(get(paste("place_",i,sep="")),get(paste("data_",i,sep="")),by=c("code"="code"))
		)
}

#data.frame��
for(i in z){
	assign(
	paste("place_",i,sep=""),
	data.frame(get(paste("place_",i,sep=""))
	))
}

#�`�ʌ��ʂ�gg_n�ɑ��
for(i in 1:24){
	assign(paste("gg_",i,sep=""),
	ggplot()+
	geom_sf(data=shape,aes(fill=shape[,3+i]),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�������f�ꏊ�v���b�g�i",ward_name[i],"�E2017�N�j",sep=""))+
	geom_point(data=get(paste("place_",i,sep="")),show.legend=FALSE,
	aes(x=get(paste("place_",i,sep=""))[,34],
	    y=get(paste("place_",i,sep=""))[,35],
	    size=get(paste("place_",i,sep=""))[,3]),
	colour="#3cb371")
	)
}


#save
#�݂���_2017
for(i in 1:24){
ggsave(
	file = sprintf("%02d_place_stomach_2017.png",i),
	plot = get(paste("gg_",i,sep=""))
	)
}

#�q�{����_2017
#coordinate��31��32
for(i in 1:24){
ggsave(
	file = sprintf("%02d_place_uterine_2017.png",i),
	plot = get(paste("gg_",i,sep=""))
	)
}

#������_2017
#coordinate��31��32
for(i in 1:24){
ggsave(
	file = sprintf("%02d_place_breast_2017.png",i),
	plot = get(paste("gg_",i,sep=""))
	)
}


#�����܂�
summary(place_20[,3])

assign(paste("place_",13,sep=""),
left_join(get(paste("place_",13,sep="")),get(paste("data_",13,sep="")),by=c("code"="code"))
)
place_7$code
data_8$code
head(place_8)
class(place_21)
place_2 <- data.frame(place_2)
names(place_13)
for(i in z){
ggplot()+
	geom_point(data=get(paste("place_",2,sep="")),
	aes(x=get(paste("place_",2,sep=""))[,34],
	    y=get(paste("place_",2,sep=""))[,35]),
	
	colour="#3cb371")


place_13[,35]
ncol(place_12)
	assign(paste("gg_",i,sep=""),
		ggplot()+
		geom_sf(data=shape,aes(fill=shape[,3+i]),show.legend=FALSE)+
		scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
		theme_void(base_family="Japan1GothicBBB")+
		coord_sf(datum = NA)+
		labs(title=paste("�������f�ꏊ�v���b�g�i",ward_name[i],"�E2017�N�j",sep=""))+
		geom_point(data=get(paste("intestine_",i,sep="")),
		aes(x=get(paste("intestine_",i,sep=""))[,31],
		    y=get(paste("intestine_",i,sep=""))[,32]),
		colour="#3cb371")
		)
str(place_11)

y <- 1:4
for(i in 1:24){
	assign(paste("gg_",i,sep=""),
	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=shape[,3+i]),show.legend=FALSE)
		")	)))
}
gg
gg_3
	assign(paste("gg_",y[3],sep=""),
	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=shape[,3+3]),show.legend=FALSE)
		")	)))

gg <-	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=tag_16),show.legend=FALSE)"
		)	))
head(shape[,4])
gg
gg <-	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=tag_8),show.legend=FALSE)"
		)	))

gg
gg_3<-	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=tag_3),show.legend=FALSE)"
		)	))

gg_3
for(i in 1:5){
	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=tag_i),show.legend=FALSE)+
		geom_point(data=intestine_i,
		aes(x=intestine_i[,31], y=intestine_i[,32]),
		colour="#3cb371"
		")
	)
	)
}

gg1 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_1),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[1],"�E2018�N�j",sep=""))+
	geom_point(data=intestine_1,
		aes(x=intestine_1[,31], y=intestine_1[,32]),
		colour="#3cb371")

gg2 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_2),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[2],"�E2018�N�j",sep=""))+
	geom_point(data=intestine_2,
		aes(x=intestine_2[,31], y=intestine_2[,32]),
		colour="#3cb371")

gg3 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_3),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[3],"�E2018�N�j",sep=""))+
	geom_point(data=intestine_3,
		aes(x=intestine_3[,31], y=intestine_3[,32]),
		colour="#3cb371")

gg4 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_4),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[4],"�E2018�N�j",sep=""))+
	geom_point(data=intestine_4,
		aes(x=intestine_4[,31], y=intestine_4[,32]),
		colour="#3cb371")


gg5 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_5),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[5],"�E2018�N�j",sep=""))+
	geom_point(data=intestine_5,
		aes(x=intestine_5[,31], y=intestine_5[,32]),
		colour="#3cb371")



for(i in 1:5){
	eval(
	parse(
	text=paste("ggsave(file = sprintf("%d_place_intestine.png",i,"), plot = paste("gg",",i,",sep="")")))")
}

text=paste("ggsave(file = sprintf("%d_place_intestine.png",,i,"), plot = paste("gg",i,sep=""))",sep="")
text=paste("ggsave(file = sprintf",5,sep="")
,",5,sep="")
text=paste("ted",45,sep="")
text

ggsave(file = sprintf("%d_place_intestine.png",3), plot = paste("gg",3,sep=""))
paste("gg",3,sep="")

)
for(i in 1:5){
gg_ <-
	eval(
	parse(
	text=paste("
		ggplot()+
		geom_sf(data=shape,aes(fill=tag_i),show.legend=FALSE)+
		scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
		theme_void(base_family="Japan1GothicBBB")+
		coord_sf(datum = NA)+
		labs(title=paste("�咰�����f�ꏊ�v���b�g�i",ward_name[10],"�E2018�N�j",sep=""))+
		geom_point(data=intestine_i,
		aes(x=intestine_i[,31], y=intestine_i[,32]),
		colour="#3cb371"
		")
	)
	)
}
ward_name

paste("�咰�����f�ꏊ�v���b�g�i",ward_name[10],"�E2018�N�j",sep="")


ggplot()+
	geom_sf(data=shape,show.legend=FALSE)+gg5

gg <-
ggplot()+
	geom_sf(data=shape,show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title="�咰�����f�ꏊ�v���b�g�i�Q����E2018�N�j")

gg5 <- geom_point(data=intestine_10,
		aes(x=intestine_10[,31], y=intestine_10[,32]),
		colour="#3cb371")

gg2 <- gg+ geom_sf(data=shape,aes(fill=tag_10),show.legend=FALSE)

gg2 + 
plot(gg10)




gg10 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag_10),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title="�咰�����f�ꏊ�v���b�g�i�Q����E2018�N�j")+
	geom_point(data=intestine_10,
		aes(x=intestine_10[,31], y=intestine_10[,32]),
		colour="#3cb371")
plot(gg10)




#�`��i����Ă�H�j
gg10 <-
ggplot()+
	geom_sf(data=shape,aes(fill=tag),show.legend=FALSE)+
	scale_fill_gradient(low="#f5f5f5",high="#B6B1F7")+
	theme_void(base_family="Japan1GothicBBB")+
	coord_sf(datum = NA)+
	labs(title="�咰�����f�ꏊ�v���b�g�i�Q����E2018�N�j")+
	geom_point(data=intestine_10,
		aes(x=intestine_10[,31], y=intestine_10[,32]),
		colour="#3cb371")
plot(gg10)

head(shape)
shape[10,3]

for(i in 1:24){
ggplot()+
geom_sf(data=shape)+
geom_point(
	data=paste("intestine_",numbers[i],sep=""),
	aes(x=paste("intestine_",numbers[i],sep="")[,31], y=paste("intestine_",numbers[i],sep="")[,32]),
	colour="skyblue")
}


for(i in numbers){
ggplot()+
geom_sf(data=shape)+
geom_point(
	data=intestine_[i],
	aes(x=intestine_[i][,31], y=intestine_[i][,32]),
	colour="skyblue")
}

x <- 0
for(i in 1:24){
x <- x + 1
gg[x]<-
ggplot()+
geom_sf(data=shape)+
geom_point(
	data=intestine_[x],
	aes(x=intestine_[x][,31], y=intestine_[x][,32]),
	colour="skyblue")
}


names(intestine)
nrow(intestine)
head(intestine$��)
head(intestine)


head(intestine,14)
#rename again
intestine <- intestine %>% rename(address="������")
intestine <- intestine %>% rename(venue="�Z��")

#�����ڂ܂ł𔲂��̓��
#���܂��ł��ĂȂ�
intestine$venue <- str_extract(intestine$�Z��,"(.*)(?<=�|)")

intestine %>% group_by(address) %>% summarise(n=n())
intestine2 <- intestine %>% group_by(address) %>% summarise(n=n())
intestine2$address <- str_extract(intestine2$address,"(?<=��)(.*)")

intestine4 <- data.frame(intestine2)


#left_join���邽��column��rename���Ă���
shape <- rename(shape,address=MOJI)

data_1809�@<-�@left_join(shape,intestine4,by="address")
gg2
gg1 <- ggplot(data_1809)
gg2 <- gg1 + geom_sf(aes(fill=n),colour="white") 
gg3 <- gg2 + theme_void(base_family="Japan1GothicBBB")
gg4 <- gg3 + labs(title="�����l���i�O�΁`�T�΁E2018�N9���j")
gg5 <- gg4 +�@scale_fill_gradient2()

########

clinics <- read.csv("clinics.csv")
clinic <- read.csv("cliniclist20170703.csv",stringsAsFactors=FALSE)
text(, clinic[,1], col="blue", adj = c(-0.3,0.5), cex=0.02)
#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
shape <- st_read("h27_did_27.shp") 
shape <- shape[1:24,7]

#left_join���邽��column��rename���Ă���
shape <- rename(shape,address=MOJI)
head(shape)

gg1 <- ggplot(shape)
gg2 <- gg1 + geom_sf()
gg2




) 





