

#data <- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",
#                  ,sep=" ",header=FALSE,fill=FALSE,col.names=paste("V", 1:561, sep="_"))


train <- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
                  ,col.names=paste("V", 1:561, sep=""))
test <- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
                   ,col.names=paste("V", 1:561, sep=""))
feature<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

newdata<-rbind(train,test)
rm(train)
rm(test)

ss<-feature[grepl("mean",feature$V2) | grepl("std",feature$V2),]
newdata<-newdata[,ss[,1]]
trainsub<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
testsub<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
sub<-rbind(trainsub,testsub)
trainact<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
testact<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
act<-rbind(trainact,testact)
actlabel<- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
                    ,col.names=c("Code","Name"))




  act[act==1]<-"WALKING"
  act[act==2]<-"WALKING_UPSTAIRS"
act[act==3]<-"WALKING_DOWNSTAIRS"
act[act==4]<-"SITTING"
act[act==5]<-"STANDING"
act[act==6]<-"LAYING"

newdata<-cbind(newdata,sub)
newdata<-cbind(newdata,act)
colnames(newdata)<-c(ss[,2],"SubjectID","Activity")

