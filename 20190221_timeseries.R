#time series data
#���n��f�[�^�́u���̊Ԋu�Łv���肵�����́B���炩���ߊԊu��ݒ肵�Ă����K�v������B
#RFinanceYJ�Ƃ����p�b�P�[�W
#quoteStockTsData�Ƃ����֐����g���ƁA���t�[�W���p�����񋟂��Ă��銔�����ɃA�N�Z�X����HTML����Ƃ��Ă���
fjstock <- quoteStockTsData("6702.t", "2012-01-01")

#���n��f�[�^�͂ǂ��Ő��܂�Ă��邩�H
#�T�[�o�̃A�N�Z�X���O�A�Z���T�[�f�[�^�A�R�[���Z���^�[�̖₢���킹

#���n��f�[�^�̐���
#�h�C�c�����w���iR�ɕW���œ����Ă���f�[�^�j
EuStockMarkets
head(EuStockMarkets)
nrow(EuStockMarkets)
class(EuStockMarkets)
plot(EuStockMarkets[,"DAX"],type="l")#1(����)����Ȃ���L

#�f�[�^�̐����𕪉�
decomp <- decompose(EuStockMarkets[,"DAX"])
head(decomp)
#�g�����h�������I�ȕω��̌X��
#�G�ߐ������K���J��Ԃ��������I�ȕϓ��i���T���j���ɁE�E�Ƃ��j
#�m�C�Y�irandom�j���g�����h�ƋG�ߐ����Ő����ł��Ȃ��c��̕������ז��Ȃ��̂ł͂Ȃ��A�m�C�Y�̌������l���邱�ƂŎЉ�̕ω����ǂݎ���
plot(decomp)

#3-6
#���n��f�[�^�̕��͂ɉ�A���͓͂K���Ȃ��B�Ȃ��Ȃ�E�E
#��A���͂̓g�����h��G�ߐ������Ȃ����`���f��������

#3-7���̗͂���
#1�D���n��f�[�^�̓ǂݍ��݁Ats�^�ɕϊ�����
#2.�f�[�^���v���b�g���Ă݂Ă݂�its.plot��������plot.ts�j
#3.�P�ʍ��i���񂢂���j������s���Ē��ߒ�������ߒ����𔻕�
#��{�I�ɂ͒��ߒ��ɂȂ��Ă��邱�Ƃ��]�܂���
#4.����f�[�^�ł���΍����܂��͑ΐ��ɕϊ�
#5.���f���̓K�p�E�\��

#utility bills�̓ǂݍ���
bills <- read.csv("utility_bills.csv")
str(bills)
#���n��f�[�^�֕ϊ�
gas <- ts(bills$gas, freq=12, start=c(2014,8))
electric <- ts(bills$electric, freq=12, start=c(2014,8))

#�������2���������Ȃ̂�na.omit�K�v
water <- na.omit(bills$water)

gas <- na.omit(bills$gas)
#���̂̂�freq=6��ts��
water <- ts(water, freq=6, start=c(2014,8))
str(gas)
str(electric)
str(water)

plot(bills$gas,bills$electric)
#�P��f�[�^�̕`��
plot.ts(gas, xlab="�N", ylab="�K�X��")
plot.ts(electric, xlab="�N", ylab="�d�C��")
plot.ts(water, xlab="�N", ylab="������")

#�����̃f�[�^���d�˂ĕ`�ʂ���ɂ�
ts.plot(gas, electric, col=c("blue","red"), lty=c(3,1))
#freq���قȂ�ƕ`���Ȃ�
ts.plot(gas, water, col=c(4,2), lty=c(3,1))

#3-9
#���ȑ��֊֐��A�ߋ��̎����Ƃ̑���
#�ߋ��̂ǂ̎��_�ƌ��݂̎��_�Ƃ̊֌W���������A���킩��
#���ւ̍����f�[�^���g�����Ƃŗ\���̐��x�����܂�i���߂̂��̂��j
acf(water,lag.max=48)#auto correlation function
#���[�̂P�͎������g
#���̑��ւ����鎞�_�i�Ⴆ��3�����O�j���݂āA3�����O�̃K�X�オ�����ƁA�����͈����ƂȂ�
#������1�N�O�̑��ւ��������ꍇ�͕Ύ��ȑ��֊֐�������i���ȑ��֊֐��͗ݐς���悤�ȃC���[�W�j
##�������ɉE��������
pacf(water,lag.max=48)#auto correlation function
#��{�ڂ���挎�̃f�[�^�i���ȑ��֊֐��Ƃ͈قȂ�j
#���_���͐M����ԁ��˂������Ȃ������͂قڌ덷

#3-10
#�P�ʍ�����
#adf.test���g���Ē��ߒ��Ȃ̂�����ߒ��Ȃ̂��𔻕�
#���ߒ��̕����\���̐��x���オ��
#����ߒ����ω����s�K�����Ȃ�Ƃ����������i��p����K�v������
#�A���������u����ߒ��ł���v�Ƃ�������
library(tseries)
adf.test(gas)
adf.test(water)

#3-11
#����f�[�^�̕ϊ�
#����ߒ��ł���΁u�����v���Ƃ�����u�ΐ����v���邱�ƂŒ��ߒ��ɕϊ�����i���Ƃ������Ă݂�j
#�������Ƃ�֐�
difference <- diff(EuStockMarkets[,"DAX"])
#���Ƃ��Ƃ͔���ߒ��̃f�[�^���������A�������Ƃ�ƒ��ߒ��ɂȂ�
adf.test(difference)
plot(EuStockMarkets[,"DAX"])
plot(difference)
#�ΐ���e�̉��悩
eulog <- log(EuStockMarkets[,"DAX"])
adf.test(eulog)
#����ł��܂�����ߒ�
#�����Ƃ��_���Ȃ獷�����Ƃ��āA����ɑΐ��ɕϊ�����A�Ƃ������@������
diflog <- log(diff(EuStockMarkets[,"DAX"]))
#�������̂ق������܂�����
logdif <- diff(log(EuStockMarkets[,"DAX"]))
head(logdif)

#3-13
#�ߋ��̃f�[�^����\�����𗧂Ă�AR���f���iauto regression�j
#�f�[�^�̓ǂݍ���
bills <- read.csv("utility_bills.csv")
gas <- ts(bills$gas, freq=12, start=c(2014,8))
gas <- na.omit(gas)
#�\���Ɏg���f�[�^�����o��
gasmodel <- gas[2:37]
#ar�֐��Ń��f�����쐬
armodel <- ar(gasmodel, method="ols") #ordinary least square
#predict(�\���Ɏg�����f���A�\���Ɏg���f�[�^�An.ahead�Ŋ���)
armodel2 <- predict(armodel, gasmodel, n.ahead=24)
#�\���������ʂ�time series�ɁB�\���̃X�^�[�g���_���w��
armodel3 <- ts(armodel2$pred, start=c(2019,1), freq=12)
#���f�[�^��`��
plot(gas, xlim=c(2015,2020))
#lines�ŗ\���l���d�˂�
lines(armodel3, col="red")
#�\���l�͂����ɓ����Ă���
armodel3

#3-14MA
#moving average���ړ����σ��f���A�ł��ړ����ςł͂Ȃ����ȑ��ւɊ�Â����f��
#ARIMA�֐��ŋ^���I��MA���f���������iorder�Ŏw��j
mamodel <- arima(gasmodel)
mamodel <- arima(gasmodel, order=c(0,0,1)) #�ꎟ��MA���f����K�p
#�\���l��`�悷�邽�߂�forecast�p�b�P�[�W���g�p
library(forecast)
mamodel2 <- ts(forecast(mamodel, h=24)$mean, start=c(2015,1), freq=12)
#�`��
plot(gas)
lines(mamodel2,col="red")

#3-15 ARIMA���ȉ�A�a���ړ����σ��f���AAR��MA���f����g�ݍ��킹������
#I��integretion=�a�������U�f�[�^�ɑ΂���ϕ�
#time series is discrete
#���U�f�[�^��a�����邱�Ƃɂ���ĕω������炩�ɂȂ遁����ߒ��̂��̂���ߒ��ɋ߂Â�����
#ARIMA���f�����g�ɔ���ߒ�������ߒ��ւ̕ϊ����܂܂��
result <- arima(gasmodel, order=c(0,1,1),
		    seasonal=list(order=c(0,1,1), period=12))
plot(forecast(result, h=24))

#3-16
#forecast�p�b�P�[�W��auto.arima�֐��ōœK�ȃ��f���𐄒�ł���
#Inf(AIC)���������قǗǂ����f��
result.arima <- auto.arima(gas, trace=T, stepwise=T)
result.arima
plot(forecast(result.arima, h=24))

#3-17,�l�X�Ȏ��n��f�[�^���͎�@
#�x�C�W�A���l�b�g���[�N�A�K�w�x�C�Y���f��
#����؃��f��
#����ߒ��̃f�[�^����萸�x�悭�\������ɂ͂ǂ�����΂������A�Ƃ����ۑ�

#4-1�A���ӃV�X�e���Ƃ̘A�g
#RDBMS
#R����SQL���𓊂��āA�w�肳�ꂽ�f�[�^�������o���āA����𕪐͂���
#R�ƃv���O��������Ƃ̘A�g���������v���O�����̈ꕔ��R�̋@�\���Ăяo���������܂߂�

#4-2 R��RDBMS�Ƃ̘A�g
#�p�b�P�[�WRODBC��R����ODBC�h���C�o���Ăяo����DB�ɐڑ�����
#ODBC��MS���J�������ėp�̃f�[�^�x�[�X�K�i

#�ȉ���32�r�b�g�łł����ł��Ȃ��I�H
#Access�ɐڑ����āA���̒���DB����SQL���𔭍s���ăf�[�^�����o��
library(RODBC)
#Access�`���̃f�[�^��ǂݍ���
PriceDB <- odbcConnectAccess2007("��v�i�ڏ������i.accdb")
#DB�̃e�[�u���̈ꗗ
sqlTables(PriceDB)
#�e�[�u�����̑S���ڂ��擾���ăf�[�^�t���[���Ɋi�[
Price_Table <- sqlQuery(PriceDB,"select * from ��v�i�ڏ������i")
#1960�N�̊e�i�ڂ̉��i���擾���ăf�[�^�t���[���Ɋi�[
Price_1960 <- sqlQuery(PriceDB,"select * from ��v�i�ڏ������i where �N�� = 1960")
#1960�N��̊e�i�ڂ̉��i���擾���ăf�[�^�t���[���Ɋi�[
Price_196X <- sqlQuery(PriceDB,"select * from ��v�i�ڏ������i where �N�� between 1960 and 1969")

odbcClose(PriceDB)


#4-3
#R�͒ʏ��CPU��1�R�A�����g��Ȃ����}���`�R�A�Ōv�Z����ꍇ�ɂ�
#
install.packages(c("snow","snowfall"))
library(snowfall)
sfInit(paralle=T, cpus=3)#���[�J��PC��3�R�A���g�p�i�}���`�R�A���̏������j
#Init��initiallization
#paralle=���U���񏈗������܂���

#�����ł͊jCPU�Ɋ��蓖�Ă��Ƃ��֐��̒��Œ�`
f <- function(x){
	data <- EuStockMarkets[,"DAX"]
	arima(data, order=c(x,x,x))
}
#system.time�Ŋ֐��̎��s�ɂ����������Ԃ�}��
#sLapply�Ŋe�R�A���ƂɈقȂ閽�߂��n�����
system.time(sLapply(1:3, f))
#���񏈗����I��
sfStop()

#4-4 R��Hadoop�Ƃ̘A�g
#��������̃T�[�o��g�ݍ��킹�đ����������s�����߂̕��U���񏈗��̎d�g��
#1��1��̃T�[�o�ɏ������ɂ����d��������U��
#���ʂ�JAVA�ŏ���
#Hadoop Streaming���g���āA�W�����o�͂��g���Ăق��̃v���O�����Ƀf�[�^��n���ď���������
#�����Ă��̃v���O�������Ԃ��Ă������ʂ��܂��󂯎���ďW�v����iHadoop�ɂ�鏈���̓r���łق��̃v���O�����ɏ����𓊂���j
#Hadoop���番�̓f�[�^�𓊂����Ƃ���R���w�肷��
#���̌��ʂ��܂�Hadoop�ɓ����ďW�v���Ă���
#Hadoop�ŏ����������ʂ͍ŏI�I�Ɂu���U�t�@�C���V�X�e���v�Ɋi�[�����

### Map�����F mapper.R�A�@Reduce�����Freducer.R
#!/usr/bin/Rscript

#�W�����͂���f�[�^�ǂݎ��
input <- file(description="stdin", open="r")
#1�s���ǂݍ���
while(length(line <- readLines(input, n=1, warn=FALSE) >0){
#�E�E�E
close(input)


###Hadoop streaming�ŏ���
$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-1.1.2-
streaming.jap -files mapper.r, reducer.r -input ���̓t�@�C���� -output �o�̓f�B���N�g����
-mapper mapper.R -reducer reducer.r


###�������ʂ̊m�F
$HADOOP_HOME/bin/hadoop fs -cat �o�̓f�B���N�g����/part-00000

#4-5
#rmr2�p�b�P�[�W��R����Hadoop�̋@�\�𗘗p
#Hadoop streaming��Hadoop����R�𑀍삷�邪�A����͋t
#R�̕��@�Ńv���O������������iHadoop�̂��߂�JAVA�͂����ւ�j

#4-6�@R��g�ݍ��񂾃v���O�����J��
#R�͂��Ƃ���C����
#C����Ƃ̊Ԃł���肷��API��R���g�������Ă���
#C����̃C���^�[�t�F�[�X�����JAVA�Ƃ̊ԂŃf�[�^�̂���肪�ł���p�b�P�[�W������
#��JAVA�p�b�P�[�W

#4-7�@R�Ɠ��v�\�t�g�E�F�A�Ƃ̘A�g
#SAS��SPSS�AJMP�A�ł��I�v�V�����@�\�Ȃ̂ŗ�����������
#Excel�ƂȂ�xlsx�p�b�P�[�W�ŉ\�iXLConnect�p�b�P�[�W������j
#Apache POI�炢�Ԃ������悤���Ă��邽�߁AWindows,office�����Ȃ��Ă������\
library(xlsx)
data <- read.xlsx("data.xls", 1) #�V�[�g1�̃f�[�^��ǂݍ���
library(XLConnect)
data <- readWorkSheetFromFile("data.xls", 1) #�V�[�g1�̃f�[�^��ǂݍ���












gas
mrmodel
forecast(mrmodel, h=24)

str(gas)
class(gas)
head(eulog)
gas
armodel2
plot(armodel3)
plot(EuStockMarkets[,"DAX"])

gas <- ts(bills$gas, freq=12, start=c(2014,8))
electric <- ts(bills$electric, freq=12, start=c(2014,8))
water <- na.omit(bills$water)
gas <- na.omit(bills$gas)
water <- ts(water, freq=6, start=c(2014,8))
str(gas)