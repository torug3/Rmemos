library(dplyr)

setwd("*:/U****/***/****/forR")

#�f�[�^�ǂݍ���
data1 <- read.csv("�݂��񌟐f�i�S���j181018���_.csv", stringsAsFactors=FALSE)

#�n�悾�������o����tibble�ɂ��Đ����J�E���g
district <- data1 %>% dplyr::group_by(�n��) %>% summarise(n=n())

#tibble��dataframe��
district2 <- as.data.frame(district)

#arrange�ő������̏��i�~���j��
district3 <- district2 %>% arrange(desc(n))

#�����v�̂ň�Ë@�֏���
#��Ë@�ւ��������o����tibble�ɂ��Đ����J�E���g
hospital <- data1 %>% dplyr::group_by(���f�@��) %>% summarise(n=n())

#tibble��dataframe��
hospital2 <- as.data.frame(hospital)

#arrange�ő������̏��i�~���j��
hospital3 <- hospital2 %>% arrange(desc(n))

hospital3