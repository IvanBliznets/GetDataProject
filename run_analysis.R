library(dplyr)

#load test data(data from folder test) 
dataTest<-read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
labelTest<-read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

#load train data(from folder train) 
dataTrain<-read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
subjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
labelTrain<-read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

#merge train and test data (step 1)
data<-rbind(dataTest,dataTrain)               
subject<-rbind(subjectTest,subjectTrain)
labels<-rbind(labelTest,labelTrain)

#subset only mean and standard deviation (step 2)
varNames<-read.table("UCI HAR Dataset/features.txt", header=FALSE)
meanInd<-grep("mean",varNames[,2],ignore.case=TRUE)
stdInd<-grep("std",varNames[,2],ignore.case=TRUE)
ind<-c(meanInd,stdInd)
subsetData<-data[,ind]  

#assign appropriately changed names to columns  (step 3)
names(subsetData)<-make.names(varNames$V2[ind],unique=TRUE)

##write.table(cbind(data.frame(names(subsetData)),varNames$V2[ind]),file="CodeBook.md") save names to CodeBook.md

#add subject and activity columns appropriately named (step 4)
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")
lab<-merge(labels,activityLabels,by="V1")
names(lab)<-c("label","activity")
labeledData<-cbind(subsetData,activity=lab$activity,subject=subject$V1)

#created data with the average of each variable for each activity and subject (step 5)
finalData<-aggregate(labeledData[,1:86],list(activity=labeledData$activity,subject=labeledData$subject),mean)




#save data
write.table(finalData,file="tidyData.txt",row.names=TRUE)

#altetnatives to step 5
#Alternative 2
#library(plyr)
#finalData2<-ddply(labeledData,.(activity,subject),colwise(mean))

#Alternative 3
#library(dplyr)
#f<-group_by(labeledData,activity,subject)
#finalData3<-summarise_each(f,funs(mean))

