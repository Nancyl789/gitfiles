url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download. 
X_test<-download.file(url, destfile="./UCI HAR Dataset/test/X_test", method="curl")
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
dim(xtest)
 X_train<-download.file(url, destfile="./UCI HAR Dataset/train/X_train", method="curl")
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
dim(xtrain)
var<-download.file(url, destfile="./UCI HAR Dataset/features.txt", method="curl")
varnames<-read.table("./UCI HAR Dataset/features.txt")
dim(varnames)
m<-rbind(xtest,xtrain)
dim(m)
names(m)
install.packages("reshape2")
library(tidyr)
library(dplyr)
colnames(m) <- varnames$V2
head(m,1)

 m1<-m[,grepl("mean|std", colnames(m))]

y_test<-download.file(url, destfile="./UCI HAR Dataset/test/y_test", method="curl")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
str(ytest)
y_train<-download.file(url, destfile="./UCI HAR Dataset/train/y_train", method="curl")
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
str(ytrain)
act<-rbind(ytest,ytrain)
m2<-cbind(act,m1)
m2<-rename(m2, ACT=V1)
head(m2,1)

subject_test<-download.file(url, destfile="./UCI HAR Dataset/test/subject_test", method="curl")
stest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-download.file(url, destfile="./UCI HAR Dataset/train/subject_train", method="curl")
strain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject<-rbind(stest,strain)
str(subject)
m3<-cbind(subject,m2)
m3<-rename(m3, SUBJECT=V1)
dim(m3)

by_SUBJECT<-group_by(m3,SUBJECT,ACT)
m4<-summarise_each(by_SUBJECT,funs(mean))
write.table(m4, file = "activityfinal.txt",row.names=FALSE)



