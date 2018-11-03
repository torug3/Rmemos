#5-73

library(tidyverse)

test <- tibble(umare=c(1990,1992,1997,1991),
		   height=c(180,176.2,165.5,172.3),
		   weight=c(70.2,80.3,65.3,61.1))

mutate(.data=test,


test %>% mutate(name=c("suzuki","honda","toyota","nihon"))


test <- test %>% mutate(bmi=weight/(height/100)^2)


#5-74
#��̖��O��ς��� rename

test <- test %>% rename(birth_year = umare)

#select�ŁA��̈ꕔ�����𒊏o
test %>% select(birth_year,weight)
#�������邱�Ƃ��\
test %>% select(-height,-weight)

test2 <- tibble(v1=c(10:20),v2_99=c(20:30),v100=c(30:40),
		    x1=c(40:50),x2_30=c(50:60),x31=c(31))

#���o
test2 %>% select(starts_with("v"))
test2 %>% select(ends_with("1"))
test2 %>% select(contains("2"))
#���ёւ�
test2 %>% select(x31,everything())

#practice
test %>% select(contains("b"))
test2 %>% select(starts_with("x"),everything())
test2 %>% select(starts_with("x"),starts_with("v"))

test2 %>% select(x31,x2_30,x1,v100,v2_99,v1)
#simplify->
col2 <- colnames(test2)
rev(col2)
test2 %>% select(rev(col2))
test2 %>% {select %>% colnames() %>% rev() }
test2 %>% select({test2 %>% colnames() %>% rev()})

#5-76
#test�̐g�������Ԃɕ��ёւ���

test %>% arrange(height)#����
test %>% arrange(desc(height))#����(descending-ascending)

test3 <- tibble(grp1=c(rep(c(1:10),2),rep(c(10:1),2)),
		    grp2=c(rep(c(5:1),4),rep(c(1:5),4)),
		    grp3=c(rep(c("a","b","c","d"),10))   )

View(test3)

test3 %>% arrange(grp1)
test3 %>% arrange(desc(grp2))
test3 %>% arrange(grp1,grp3)
test3 %>% arrange(grp3,grp2)
test3 %>% arrange(desc(grp1),grp2,desc(grp3))

#5-77,78

450==450
#<�i���Ȃ�j
#>�i��Ȃ�j

450!=45
# !=�͓����łȂ��A��\��


#5-79

vec <- c(1:20)

vec==1
vec<10

#include?
c(1,2,3,4,5) %in% c(3,4)

#����x�N�g���������̃x�N�g���𔲂��o������
vec <- c(1:5)

vec[c(TRUE,TRUE,TRUE,TRUE,TRUE)]
vec[c(TRUE,TRUE,TRUE,TRUE,FALSE)]
vec[c(TRUE,TRUE,FALSE,TRUE,FALSE)]

vec <3
vec[vec<3]

#�܂�Alogical�̃x�N�g���́A�x�N�g���������̗v�f�𔲂��o���Ƃ��Ɏg��

#5-80 and �� or

# &��and

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

5==5 & 7>3

5==5 & 7<3
5==5 | 7<3


#5-80

# 

vec <- c(NA,1,2,3,NA,4,5,6)

vec[is.na(vec)]

vec[!is.na(vec)]


#5-81

# ������ɂ��邵�����遁���K�\��

vec <- c("HbA1c:9.2%","ALT:12OUI","WBC:9.3*10^3")

#���̐������������o���i����H�H�j

library(stringr)
str_extract(vec, "(?>=:)(\\d+\\.\\d)|(?<=:)\\d+")

#5-82
#���K�\���Ƃ́A��������p�^�[���łЂ���������@

vec <- c("1","120","34.3","ab123","5b","6 5","7","b","ac4235432","45.3mg/dl","abc500ml 3unit 3:40AM","^ is start","this sign($)represents end.","....")

str_detect(vec,"1")
#str_detect��logical��Ԃ��Ă����̂ŁA�ȉ��̂悤�ɂ���Ύ��o����B
vec[str_detect(vec,"1")]

#�����̕�������Ђ����������ꍇ�i1��2��3��4�j
check <- str_detect(vec,"[1234]")
vec[check]

#str_view���g���ƌ��₷��
#�����΂�ŏ��ɗ��鐔�����������Ă�
str_view(vec,"[1234]")

#�ȉ���2�͓���
str_detect(vec,"[1234567890]")
str_detect(vec,"[0-9]")
str_detect(vec,"\\d")

#2�����Ђ����������ꍇ��
str_view(vec,"[0-2][0-2]")
#��������
str_detect(vec,"[0-2]{2}")

#1����3�܂�
str_detect(vec,"[0-5]{1,3}")
str_view(vec,"[0-5]{1,3}")
str_view(vec,"[0-9]{,3}")#�ő�3��
str_view(vec,"[0-9]{1,}")#1��ȏ�
str_view(vec,"[0-9]+")#���1��ȏ�A��+�ŏ��������邱�Ƃ��\
str_detect(vec,"\\d+")

#�Ȃ�ł������A�Ƃ���
str_detect(vec,".")
str_detect(vec,".+")#���ׂĂ̕�����̒���

#5-83
#b��������̐擪�ɂ��邩�ǂ���
str_detect(vec,"^b")
str_detect(vec,"^H")

#b��������̍Ō�ɂ��邩�ǂ���
str_detect(vec,"b$")

str_detect(vec,"^b$")#b���������Ă�
str_detect(vec,"^\\d+$")#�������������Ă�
str_view(vec,"^\\d+$")#���������i�̕�����j�����Ă�


#�L���Ƃ��Ă�^��.�����Ă�Ƃ��́H
str_view(vec,"\\$")
str_view(vec,"\\.+")


#5-85

#���̂�����璷�ȓ��e�������A�A�A���e���킩��Ȃ��̂ŐU��Ԃ�K�v

str_detect(vec,"(?>=room)\\d+")

#���ׂĂ̕���
str_view(vec,"\\w+")
#���ׂĂ̔񕶎�
str_view(vec,"\\W+")
#���ׂĂ̐���
str_view(vec,"\\d")
#���ׂĂ̔񐔎�
str_view(vec,"\\D+")
#���ׂẴX�y�[�X
str_view(vec,"\\s+")
#���ׂĂ̔�X�y�[�X
str_view(vec,"\\S+")


#5-87
test$umare > 1995

#����Boolean���Afilter��tibble�̗�ɓK�p����TRUE�ł�����̂𔲂��o��

#filter�̒��ɂ�logical������
#�ǂ��logical�����邩�A���s���낵�Ă݂邱��

test %>% filter(test$umare>1995)
test %>% filter(test$height>=175)

#diamonds��filter��K�p���Ă݂�
diamonds %>% filter(color=="E")

diamonds %>% filter(clarity=="SI1" | clarity=="SI2")
#�ł���������
diamonds %>% filter(str_detect(clarity,"^SI\\d+$"))

diamonds %>% filter(str_detect(clarity,"\\d"))
#�ł��������A
diamonds %>% filter(clarity != "IF")
#�ł������B�ǂ��logical����邩�B

#5-88 20180918 ���K���
dft <- tibble(
	target1 = c(
	"abc500ml 3unit",
	"def200ml 4unit",
	"ghi100ml 5unit"
	),
	target2 = c(
	"AST 50IU",
	"HbA1c 5.0%",
	"BMI 23.1g/m^2"
	),
	target3 = c(
	"opeA:4.5hr 80ml",
	"opeB:3hr 10ml",
	"opeC:12.5hr 100ml"
	)
)
dft

#���K�P
#�킩���B���ꂾ�Ƃ�����̂�
dft$target1 %>% str_extract("\\d+(?=unit)")

#����̓_���Ȃ͉̂��ŁH
dft %>% str_extract(target1,"\\d+(?=unit)")

dft$target1 %>% str_extract("\\d")
str_detect(dft$target1,"\\d")
#������_��
dft$target1 %>% filter(str_detect(dft$target1,"//d"))

#���K�Q��1�Ɠ����Bunit��ml�ɂ���邾��
#���K�R

#���ꂪ�ꉞ�����݂���
dft$target1 %>% str_extract("[a-z]+(?=\\d)")
#����ł�OK�i�Ⴂ�͉����낤�H�j
dft$target1 %>% str_extract("^[a-z]+(?=\\d)")
#���ꂾ�Ƃ��߂Ȃ͉̂��ł��낤
dft$target1 %>% str_extract("^\\w+(?=\\d)")
dft$target1 %>% str_extract("\\w+")
#���K4
dft$target2 %>% str_extract("\\d+")
dft
str_detect(dft$target2 %>% 
#���K5
#".+"�ł��ׂĂ̕����̌J��Ԃ�
#str_replace�A�}�b�`�������ʂ�ʂ̕�����ɒu�������邱�Ƃ��ł���
#�u�������̑Ώۂ��w�肵�Ȃ���΁i�󔒂ɂ���΁j

#���K�U�C�V�A
#���K�\���ɂ��Ă͕��K�̕K�v�傢�ɂ���

#5-91 ���K�\���̕⑫
#���{��̖��ƑS�p�����̖��
#"Nippon"�Ƃ������C�u�������g���ΑS�p���甼�p�֕ϊ����ł���

#5-92 if_else��case_when
q()