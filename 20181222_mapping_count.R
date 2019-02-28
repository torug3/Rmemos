#��f��Ë@�ւ̏ꏊ�����Ă݂遁�����̐��A����̐�


#�f�B���N�g���ύX
#���C�u����
library(ggplot2)
library(sf)
library(dplyr)#rename
library(viridis)#for plenty of colours
library(stringr)#for extract

#���f�[�^�̓��{��^�C�g��H**�N�x_�x�����lung_20**�ɕύX
#���̂܂�read.csv�ł��Ȃ��̂ł�������G�N�Z���ŊJ���āu���O��ύX���ĕۑ��v��CSV�`���ŏ㏑���ۑ�
#����ɓ��t�i���N�����E��f���E�O��j�ɂ��Ă͓��t�^�ɕύX�A���̑��͕W���ɕύX���ĕۑ�

#�f�[�^�ǂݍ���
lung17 <- read.csv("lung_2017.csv")

#�n����於�܂łɕҏW
lung17$ward <- str_extract(lung17$�n��,"\\w+��")

#�悲�ƂɃJ�E���g���ĐV����data.frame�쐬
count <- data.frame(table(lung17$ward))
colnames(count) <- c("ward_name","count")

#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
#eStat������{���擾
shape <- st_read("h27_did_27.shp") 

#�Ȃ�ƂȂ�column��rename���Ă���
shape <- rename(shape,ward_name=CITYNAME)

#�f�[�^�ƃV�F�[�v�t�@�C������������
data�@<-�@left_join(shape,count,by="ward_name")

#ggplot()�ɂǂ̃f�[�^��ǂނ̂��`����
#�`�ʂ���̂͑��s����count�̍s�݂̂Ȃ̂�data[1:24,7]�Ƃ���
gg1 <- ggplot(data[1:24,7])

#geom_sf�Œn�}�`�ʁA#���E����white�ɂ���
gg2 <- gg1+ geom_sf(aes(fill=count),colour="white")

#�w�i��void�ɂ���
#�^�C�g��������A�S�V�b�N�̃t�H���g��
gg3 <- gg2+theme_void(base_family="Japan1GothicBBB")+
  labs(title="��ʎ�f�Ґ��i�x����E����29�N�x�E�j���v�j")

#�h�����̐F��ύX�iviridis�Łj
gg4 <- gg3 +scale_fill_viridis()

#�於�Ɛ���\���̂��߂̏����i���W���擾�j
data_points <- sf::st_point_on_surface(data[1:24,7])
#���W�����Ƃ��Ă���i���Ƃ��̍��W�������ɂ���j
data_coords <- as.data.frame(sf::st_coordinates(data_points))
#data_coords��ward_name��count�̃J������\�������邽�߂ɒǉ�
data_coords <- mutate(data_coords,count=data$count[1:24])
data_coords <- mutate(data_coords,ward=data$ward_name[1:24])

#�於�\��
gg5 <- gg4+geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="white",cex=2.6,family="Japan1GothicBBB")
#���\��
gg6 <- gg5+geom_text(data=data_coords,aes(X, Y-0.005, label=count),colour="red",cex=2.6,family="Japan1GothicBBB")

#�`��
plot(gg6)

#�O���t�t�@�C���o��(PDF)
ggsave(file = "01_lung_2017_all.pdf", plot = gg6)



####�j�������o���@�[�W����
lung17 <- read.csv("lung_2017.csv")
lung17$ward <- str_extract(lung17$�n��,"\\w+��")
lung17 <- lung17 %>% filter(lung17$����=="�j")
count <- data.frame(table(lung17$ward))
colnames(count) <- c("ward_name","count")
data�@<-�@left_join(shape,count,by="ward_name")
gg1 <- ggplot(data[1:24,7])
gg2 <- gg1+ geom_sf(aes(fill=count),colour="white")
gg3 <- gg2+theme_void(base_family="Japan1GothicBBB")+labs(title="��ʎ�f�Ґ��i�x����E����29�N�x�E�j�j")
gg4 <- gg3 +scale_fill_viridis()
data_points <- sf::st_point_on_surface(data[1:24,7])
data_coords <- as.data.frame(sf::st_coordinates(data_points))
data_coords <- mutate(data_coords,count=data$count[1:24])
data_coords <- mutate(data_coords,ward=data$ward_name[1:24])
gg5 <- gg4+geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="white",cex=2.6,family="Japan1GothicBBB")
gg6 <- gg5+geom_text(data=data_coords,aes(X, Y-0.005, label=count),colour="red",cex=2.6,family="Japan1GothicBBB")
plot(gg6)

#�O���t�t�@�C���o��(PDF)
ggsave(file = "01_lung_2017_male.pdf", plot = gg6)

####���������o���@�[�W����
lung17 <- read.csv("lung_2017.csv")
lung17$ward <- str_extract(lung17$�n��,"\\w+��")
lung17 <- lung17 %>% filter(lung17$����=="��")
count <- data.frame(table(lung17$ward))
colnames(count) <- c("ward_name","count")
data�@<-�@left_join(shape,count,by="ward_name")
gg1 <- ggplot(data[1:24,7])
gg2 <- gg1+ geom_sf(aes(fill=count),colour="white")
gg3 <- gg2+theme_void(base_family="Japan1GothicBBB")+labs(title="��ʎ�f�Ґ��i�x����E����29�N�x�E���j")
gg4 <- gg3 +scale_fill_viridis()
data_points <- sf::st_point_on_surface(data[1:24,7])
data_coords <- as.data.frame(sf::st_coordinates(data_points))
data_coords <- mutate(data_coords,count=data$count[1:24])
data_coords <- mutate(data_coords,ward=data$ward_name[1:24])
gg5 <- gg4+geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="white",cex=2.6,family="Japan1GothicBBB")
gg6 <- gg5+geom_text(data=data_coords,aes(X, Y-0.005, label=count),colour="red",cex=2.6,family="Japan1GothicBBB")
plot(gg6)

#�O���t�t�@�C���o��(PDF)
ggsave(file = "01_lung_2017_female.pdf", plot = gg6)




#���ǃt�H���g�̖��͂킩��Ȃ��܂�
#�t�H���g�G���[���o��PDF�o�͎��ɕ������o�Ȃ�
#�uWindows�̃t�H���g�f�[�^�x�[�X�Ƀt�H���g�t�@�~����������܂���v�G���[

#�ȉ��ł͕�����������

#ggplot()�ɂǂ̃f�[�^��ǂނ̂��`����
#�`�ʂ���̂͑��s����count�̍s�݂̂Ȃ̂�data[1:24,7]�Ƃ���
gg1 <- ggplot(data[1:24,7])

#geom_sf�Œn�}�`�ʁA#���E����white�ɂ���
gg2 <- gg1+ geom_sf(aes(fill=count),colour="white")

#�w�i��void�ɂ���
#�^�C�g��������A�S�V�b�N�̃t�H���g��
windowsFonts("MEI"=windowsFont("Meiryo"))
gg3 <- gg2+theme_void(base_family="MEI")+   #����
  labs(title="��ʎ�f�Ґ��i�x����E����29�N�x�j")

#�h�����̐F��ύX�iviridis�Łj
gg4 <- gg3 +scale_fill_viridis()

#�於�Ɛ���\���̂��߂̏����i���W���擾�j
data_points <- sf::st_point_on_surface(data[1:24,7])
#���W�����Ƃ��Ă���i���Ƃ��̍��W�������ɂ���j
data_coords <- as.data.frame(sf::st_coordinates(data_points))
#data_coords��ward_name��count�̃J������\�������邽�߂ɒǉ�
data_coords <- mutate(data_coords,count=data$count[1:24])
data_coords <- mutate(data_coords,ward=data$ward_name[1:24])

#�於�\��
gg5 <- gg4+geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="white",cex=2.6,family="Japan1GothicBBB")#����
#���\��
gg6 <- gg5+geom_text(data=data_coords,aes(X, Y-0.005, label=count),colour="red",cex=2.6,family="Japan1GothicBBB")#����

#�`��
plot(gg6)

#�O���t�t�@�C���o��(PDF)
#���ꂾ�ƕ�����������ӏ�����
ggsave(file = "01_lung_2017_all.pdf", plot = gg6)



pdf("01_lung_2017_all.pdf")
par(family="MEI")�@�@�@�@�@�@�@�@�@�@#����
plot(gg6)
dev.off()

names(windowsFonts())
names(pdfFonts())


#�^�C�g���ǉ��͂��̂������H�t�H���g�̎w��́H
gg7 <- gg6 + ggtitle("��ʎ�f�Ґ��i�x����E����29�N�x�j") +
	 theme(plot.title=element_text(hjust = 0.5)) 