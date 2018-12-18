#���C�u����
library(ggplot2)
library(sf)
library(viridis)
library(dplyr)

#�K�v�ȃf�[�^�̃t�@�C���ǂݍ���
#���ʂɏZ��t�@�C����HP����_�E�����[�h���ēǂނƁu�񖼂����񐔂̂ق��������ł��v�G���[
#�Z���̌�����]�v�ȃf�[�^�������Ă��邩��H�铽�敪�����ł͂��܂��Ă��邩��H
#���ǂ��������Ƀf�[�^��ҏW���ēǂݍ��񂾂̂Ō��ǂǂ�����΂��������킩��Ȃ�

#���̃t�@�C��population_kita�̃t�@�C���͕ҏW��������

#�f�[�^�t�@�C���ǂݍ���
frame1 <- read.csv("population_kita_201809.csv")

#�j���v�̂����v�̍s�݂̂����o��
frame1 <- frame1 %>% filter(frame1$�j����=="�v")

#�Ȃ�ƂȂ�column��rename���Ă���
frame1 <- rename(frame1,region=�����ږ�)
frame1 <- rename(frame1,population=����)

#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
frame2 <- st_read("h27ka27127.shp")

#�Ȃ�ƂȂ�column��rename���Ă���
frame2 <- rename(frame2,region=S_NAME)

#�f�[�^�ƃV�F�[�v�t�@�C������������
frame3�@<-�@left_join(frame2,frame1,by="region")

#�܂�ggplot()�ɂǂ̃f�[�^��ǂނ̂��`����
gg1 <- ggplot(frame3)

#geom_sf�Œn�}�`�ʂł���
#���E����white�ɂ���
gg2 <- gg1+ geom_sf(aes(fill=population),colour="white")

# �w�i�F�𔒂ɂ���
gg3 <- gg2+theme_void()

#�h�����̐F��ύX�i�H�v�̗]�n����j
gg4 <- gg3 +scale_fill_viridis()


#���̃X�e�b�v�͒����̕\���̂��߂̂���
#choose a point on the surface of each geometry
#���ꂼ��̃W�I���g���̕\�ʂɃ|�C���g��I�ԁH
frame_points <- sf::st_point_on_surface(frame3)

# retrieve the coordinates
#���W�����Ƃ��Ă���i���Ƃ��̍��W�������ɂ���j
frame_coords <- as.data.frame(sf::st_coordinates(frame_points))

#shape_coords��region�̃J������ǉ�
frame_coords <- mutate(frame_coords,region=frame3$region)
frame_coords <- mutate(frame_coords,population=frame3$population)

#���̔�
gg5 <- gg4+geom_text(data=frame_coords,aes(X, Y+0.0005, label=region),colour="white",cex=2)
gg6 <- gg5+geom_text(data=frame_coords,aes(X, Y-0.0005, label=population),colour="red",cex=2)

#�`��
plot(gg6)

#�ۑ�
ggsave(file = "population_region.png", plot = gg6)

#PDF��������������
ggsave(file = "population_region.pdf", plot = gg6)

#�f�[�^���������ĕ`�ʂ���ƃV�F�[�v�t�@�C�������ŕ\����������Ԃꂽ�悤�Ȋ����ɂȂ�









#�V�F�[�v�t�@�C�������Łi�V�F�[�v�t�@�C���̃f�[�^�ŕ`�ʂ���ꍇ


#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
shape <- st_read("h27ka27127.shp")

g1 <- ggplot(shape)
#geom_sf�Œn�}�`�ʂł���
#���E����white�ɂ���
g2 <- g1+ geom_sf(aes(fill=JINKO),colour="white")
# �w�i�F�𔒂ɂ���
g3 <- g2+theme_void()
#�h�����̐F��ύX�i�H�v�̗]�n����j
g4 <- g3 +scale_fill_viridis()

#���̃X�e�b�v�͒����̕\���̂��߂̂���
#choose a point on the surface of each geometry
shape_points <- sf::st_point_on_surface(shape)
shape_coords <- as.data.frame(sf::st_coordinates(shape_points))
#���������i�O�����ājrename���Ă�����
shape <- rename(shape,region=S_NAME)
shape <- rename(shape,population=JINKO)

#shape_coords��region�̃J������ǉ�
shape_coords$region <- shape$region
shape_coords$population <- shape$population

g5 <- g4+geom_text(data=shape_coords,aes(X, Y, label=region),colour="white",cex=2)
g6 <- g5+geom_text(data=shape_coords,aes(X, Y, label=population),colour="white",cex=2)


#�`��
plot(g6)

#�ۑ�
ggsave(file = "population_shape.png", plot = g6)