


## Set working directory  and allocate it to a variable


setwd("H:/school/coursera/data science/repositories/cleandata/UCI HAR Dataset")
setpath <-getwd()

# get the files in the directory 
files<-list.files(setpath, recursive=TRUE)

#view the files 

files
# Read the Activity files
dataActivityTest  <- read.table(file.path(setpath, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(setpath, "train", "Y_train.txt"),header = FALSE)

#Read the Subject files
dataSubjectTrain <- read.table(file.path(setpath, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(setpath, "test" , "subject_test.txt"),header = FALSE)

#Read Fearures files

dataFeaturesTest  <- read.table(file.path(setpath, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(setpath, "train", "X_train.txt"),header = FALSE)

#check the properties of the above varibles
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain) 
str(dataSubjectTest) 
str(dataFeaturesTest)

#Concatenate the data tables by rows


dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(setpath, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2




#Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

#Subset Name of Features by measurements on the mean and standard deviation and check data
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
str(Data)

#Read descriptive activity names from 
activityLabels <- read.table(file.path(setpath, "activity_labels.txt"),header = FALSE)
head(Data$activity,30)




#Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)


#Creates a second,independent tidy data set and ouput it
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidy.txt",row.name=FALSE)