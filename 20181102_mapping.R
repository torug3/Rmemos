library(dplyr)
library(sf)

setwd("C:/***")

#�V�F�[�v�t�@�C���ǂݍ��݂ƕ\���i�k��j
shape <- st_read("h27ka27127.shp")
#�k��̒n�}�\��
plot(st_geometry(shape))

#�����ږ��\���i�V�F�[�v�t�@�C���f�[�^�j
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]+0.0005, labels=shape$MOJI, cex=0.5)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$JINKO, cex=0.5)

#�N���j�b�N�ꗗ�ǂݍ���
data1 <- read.csv("cliniclist20170703.csv")

#�݂��񌟐f�A�k��̂ݒ��o
data3 <- data1 %>% filter(�݂��񌟐f==1)
data4 <- data3 %>% filter(��R�[�h==1)

#�N���j�b�N�̏��݂��|�C���g
#�i�ʒu���͂��炩���ߕt�^�j
cliniclongtitude <- data4[,43]
cliniclatitude <- data4[,42]
points(cliniclongtitude, cliniclatitude, col="red", pch=17)

#�}�b�v�i�r�̈ʒu����ǂݍ������Ƃ��邪���܂������Ȃ��A�^�u��؂�H�ł������̂ł��_��
#�ǂ����킴�킴��x�^�u��؂�̃e�L�X�g�ŕۑ����Ȃ����K�v������݂���
#�ق�Ƃ̓_�E�����[�h�����܂܂ł�肽������
school <- read.table("gakkou3.txt", sep="\t",header=T, encoding='SHIFT-Jis')

#���w�Z�݂̂𒊏o�i�ق�Ƃ��͎��w�͏Ȃ��������j
elementary <- school %>% filter(�{�ݖ�=="���w�Z$")
#����ɖk��݂̂𒊏o
elementary <- filter(elementary,  grepl("�k��",���ݒn))

#�Ȃ�Ń_���H��
elementary <- filter(school, str_detect(�{�ݖ�, "^���s��"&"���w�Z$"))

#���w�Z�̏��݂��|�C���g
schoollongtitude <- elementary[,1]
schoollatitude <- elementary[,2]
points(schoollongtitude, schoollatitude, col="blue", pch=16)


#�l���f�[�^�ǂݍ��݁A�s���ǂ̏Z��f�[�^����
#������킴�킴��x�^�u��؂�̃e�L�X�g�ŕۑ����Ȃ����Ă���
#�{���̓_�E�����[�h�����܂܂ł�肽������
population <- read.table("juki.txt", sep="\t",header=T, encoding='SHIFT-Jis')
#���̃f�[�^�͍��v�s�����ɍi��K�v����
population <- population %>% filter(population$�j����=="�v")
#�V�F�[�v�t�@�C���Ƃ������āA�W�I���g�����t��
data11 <- inner_join(shape, population, by=c("MOJI"="�����ږ�"))
#�h�����̐F��`
number <- data11$����
class <- classIntervals(number, n=9, style="fixed", fixedBreaks= c(min(number),500,1000,1500,2000,2500,3000,3500,4000,max(number)))
palette <- brewer.pal(9, "YlOrRd")
mycolor <- findColours(class, palette)
#�h�������s
plot(st_geometry(shape), col=mycolor)

#legend�ǉ��H
legendtext=c("500����","500-1000","1000-1500","1500-2000","2000-2500","2500-3000","3000-3500","3500-4000","4000�ȏ�")

#�Z��f�[�^�̐������e�L�X�g�\��
text(st_coordinates(data11 %>% st_centroid)[,1], st_coordinates(data11 %>% st_centroid)[,2]+0.0005, labels=data11$S_NAME, cex=0.5,  bg="white")
text(st_coordinates(data11 %>% st_centroid)[,1], st_coordinates(data11 %>% st_centroid)[,2], labels=data11$����, cex=0.5,  bg="white")

#�t�@�C���o��
dev.print(png, file="myplot.png", width = 1024, height = 768)
png(file = "myplot.png", bg = "transparent")
plot(st_geometry(shape), col=mycolor)
points(schoollongtitude, schoollatitude, col="blue", pch=16)
text(st_coordinates(data11 %>% st_centroid)[,1], st_coordinates(data11 %>% st_centroid)[,2]+0.0005, labels=data11$S_NAME, cex=0.5,  bg="white")
text(st_coordinates(data11 %>% st_centroid)[,1], st_coordinates(data11 %>% st_centroid)[,2], labels=data11$����, cex=0.5,  bg="white")
dev.off()

#�v���b�g�����Ƃ�
plot.new()