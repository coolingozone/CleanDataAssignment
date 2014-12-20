library(reshape2)

#read in train data from data directory. Please change the directory if the needed.
train <- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
                  ,colClasses="numeric",col.names=paste("V", 1:561, sep=""))

#read in test data from data directory. Please change the directory if the needed.
test <- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
                   ,colClasses="numeric",col.names=paste("V", 1:561, sep=""))

#read in feature label from data directory. Please change the directory if the needed.
feature<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#merge train and test dataset
newdata<-rbind(train,test)
rm(train)
rm(test)

#search for features with name containing "mean" and "std"
ss<-feature[grepl("mean",feature$V2) | grepl("std",feature$V2),]

#only keep those columns with mean or std of measurement
newdata<-newdata[,ss[,1]]

#read train subject data
trainsub<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

#read in test subject data
testsub<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

#merge train and test subject data
sub<-rbind(trainsub,testsub)

#read in train activity data
trainact<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

#read in test activity data
testact<-read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

#merge train and test activity data
act<-rbind(trainact,testact)

#read in activity label with corresponding ID
actlabel<- read.table("C:/Project/analysis/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
                    ,col.names=c("Code","Name"))

#replace all activity ID by activity name

  act[act==1]<-"WALKING"
  act[act==2]<-"WALKING_UPSTAIRS"
act[act==3]<-"WALKING_DOWNSTAIRS"
act[act==4]<-"SITTING"
act[act==5]<-"STANDING"
act[act==6]<-"LAYING"

#merge subjectID+actvity name+measurement data
newdata<-cbind(sub,newdata)
newdata<-cbind(act,newdata)

#replace column title with descriptive title
colnames(newdata)<-c("SubjectID","Activity",as.character(ss[,2]))

#melt the data with subjectID and activity as ID, then dcast to obtain the mean 
mm<-melt(newdata,id=(c("SubjectID","Activity")))
cy<-dcast(mm,SubjectID+Activity~variable,mean)

#replace column title with descriptive title and write to file
colnames(cy)<-c("SubjectID","Activity",paste("mean of",as.character(ss[,2])))
write.table(cy,"tidydata.txt",row.name=FALSE)