#�v�f�B���N�g���ύX
#���C�u����
library(ggplot2)
library(dplyr)

#�ǂݍ���
opendata <- read.csv("opendata.csv")

#�񖼕ύX
opendata <- rename(opendata,files=�񎟗��p�ɓK�����t�@�C���`��.CSV.Word.Excel�t�@�C����.)
opendata <- rename(opendata,PDF=PDF�t�@�C��)
opendata <- rename(opendata,total=���v)
opendata <- rename(opendata,rate=�񎟗��p�ɓK�����t�@�C���`���̊���)

#��������rate�̗���폜
opendata <- select(opendata,-rate)

#���߂Čv�Z���Ēǉ�
opendata <- mutate(opendata,rate= round(files/total*100,1))


#ggplot2
#xy���ݒ�i�\�������������Ɂj
graph <- ggplot(opendata)+  aes(x=reorder(bureau,rate),y=rate,fill=bureau)
#�_�O���t�ŕ\���{xy�̓���ւ�
graph <- graph+geom_bar(stat="identity")+ coord_flip()
#�}�������
graph <- graph + theme(legend.position = "none")
#�����̐�����\��
graph <- graph + geom_text(aes(label=rate),size=2.7,hjust=2)
#�\�̃^�C�g����xy���̖��O��ݒ�
graph <- graph + labs(title="�����ʌ��J�����i2018�N9�����_�j",x="������",y="�����i���j")
#�`��
plot(graph)

#�O���t�t�@�C���o��
ggsave(file = "rate.png", plot = graph)

#�񖼂����ɖ߂���dataframe��csv�t�@�C���o�́AShift-JIS��
opendata <- rename(opendata,�񎟗��p�ɓK�����t�@�C���`��.CSV.Word.Excel�t�@�C����.=files)
opendata <- rename(opendata,PDF�t�@�C��=PDF)
opendata <- rename(opendata,���v=total)
opendata <- rename(opendata,�񎟗��p�ɓK�����t�@�C���`���̊���=rate)
write.csv(opendata, file="opendatarate.csv", fileEncoding="CP932",row.names=F)