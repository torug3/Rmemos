library(tidyverse)

path <- "C:/Users/torug/Desktop/ForR/sig/rent_cycle"
setwd(path)

test <- read.delim("test.tsv")
train <- read.delim("train.tsv")
sample <- read.csv("sample_submit1.csv",header = FALSE)


#Correlation efficient
train1 <- train[,c(-1,-2)]
cor(train1)


#===================
#Liner regression
#Create Model
mod <- lm(cnt ~ temp+hr+season, data=train)

#colnames(train)
summary(mod)
#Check which factor is significant

summary(gmod)
#Predict
pred <- predict(mod, newdata = test) %>% data.frame

#Create sample file
sample <- sample %>% mutate(predi=pred$.) %>% select(V1,predi)

#Write
write.csv(sample, file="sample_submit.csv", row.names=F)
#Before submitting Open Excel and delete the name of column

#===================
#Use "glm"(Fitting Generalized Linear Models)
#Create Model
gmod <- glm(cnt ~ atemp+hum, data=train)

#Predict
g_pred <- predict(gmod, newdata = test) %>% data.frame

#Create Model
sample <- test %>% mutate(predi=g_pred$.) %>% select(id,predi)

#Write
write.csv(sample, file="sample_submit.csv", row.names=F)
#Before submitting Open Excel and delete the name of column

