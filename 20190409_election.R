#�f�B���N�g���ύX
#���C�u����
library(ggplot2)
library(sf)
library(dplyr)#rename
library(viridis)#for plenty of colours

#
rate <- read.csv("ward_rate.csv")



#�V�F�[�v�t�@�C���f�[�^�ǂݍ���
#eStat������{���擾
shape <- st_read("h27_did_27.shp") 

#�Ȃ�ƂȂ�column��rename���Ă���
shape <- rename(shape,ward_name=CITYNAME)


#�f�[�^�ƃV�F�[�v�t�@�C������������
data�@<-�@left_join(shape,rate,by="ward_name")


#���W���擾
data_points <- sf::st_point_on_surface(data[1:24,7])
data_coords <- as.data.frame(sf::st_coordinates(data_points))
data_coords <- mutate(data_coords,rate=data$rate_mayor[1:24])
data_coords <- mutate(data_coords,ward=data$ward_name[1:24])

#ggplot
gg1 <- ggplot(data[1:24,7]) +  #�`�ʂ���̂͑��s����count�̍s�݂̂Ȃ̂�data[1:24,7]�Ƃ���
	 geom_sf(aes(fill=rate_mayor),colour="black") +
	 theme_void(base_family="Japan1GothicBBB")+
	 labs(title="��ʓ��[���i���s���I�j")+
	 scale_fill_distiller(palette="Oranges",direction=1, limits=c(35,60))+
	�@geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="black",cex=2.6,family="Japan1GothicBBB")+
	 geom_text(data=data_coords,aes(X, Y-0.005, label=rate),colour="black",cex=2.6,family="Japan1GothicBBB")
plot(gg1)

data$rate_governor
gg_gov <- ggplot(data[1:24,7]) +  #�`�ʂ���̂͑��s����count�̍s�݂̂Ȃ̂�data[1:24,7]�Ƃ���
	 geom_sf(aes(fill=rate_governor),colour="black") +
	 theme_void(base_family="Japan1GothicBBB")+
	 labs(title="��ʓ��[���i���{�m���I�j")+
	 scale_fill_distiller(palette="Oranges",direction=1, limits=c(35,60))+
	�@geom_text(data=data_coords,aes(X, Y+0.0005, label=ward),colour="black",cex=2.6,family="Japan1GothicBBB")+
	 geom_text(data=data_coords,aes(X, Y-0.005, label=rate),colour="black",cex=2.6,family="Japan1GothicBBB")
plot(gg_gov)

data$rate_mayor-data$rate_governor

#�O���t�t�@�C���o��(PDF)
ggsave(file = "01_mayor.png", plot = gg1)

ward_name	rate_mayor	rate_mayor_prev	difference	rate_governor
�k��	50.97	49.14	1.83	51.01
�s����	56.08	52.84	3.24	56.14
������	50.97	50.01	0.96	51
���ԋ�	54.29	49.27	5.02	54.29
������	46.94	46.57	0.37	47.01
����	47.39	46.03	1.36	47.44
�`��	54.07	50.28	3.79	54.08
�吳��	55.85	52.21	3.64	55.87
�V������	55.22	54.12	1.1	55.25
�Q����	37.32	37.5	-0.18	37.35
�������	54.81	50.33	4.48	54.82
�����	49.53	46.76	2.77	49.58
�������	48.05	46.24	1.81	48.11
������	53.36	51.76	1.6	53.37
�����	52.04	49.93	2.11	52.07
����	56.49	53.81	2.68	56.52
�铌��	55.89	43.89	12	55.92
�ߌ���	53.28	50.84	2.44	53.3
���{���	59.13	58.31	0.82	59.15
�Z�V�]��	56.34	53.58	2.76	56.37
�Z�g��	54.21	52.88	1.33	54.24
���Z�g��	54.39	52.87	1.52	54.43
�����	54.56	50.46	4.1	54.61
������	50.01	49.3	0.71	50.02