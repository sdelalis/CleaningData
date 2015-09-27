# Getting and Cleaning Data Course Project 
## Instructions
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

>Here are the data for the project:

>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 You should create one R script called run_analysis.R that does the following. 

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Solution:



## Part A: Get the zipped data for project;
 * Download the zipped data to a repository in your working directory.
 * Unzip the file and set your working directory in R to this location.
 * Get the list of files in all the directories under UCI HAR Dataset and assigne to the variable  dirfiles



> dirfiles

     [1] "activity_labels.txt"                         
     [2] "features.txt"                                
     [3] "features_info.txt"                           
     [4] "README.txt"                                  
     [5] "test/Inertial Signals/body_acc_x_test.txt"   
     [6] "test/Inertial Signals/body_acc_y_test.txt"   
     [7] "test/Inertial Signals/body_acc_z_test.txt"   
     [8] "test/Inertial Signals/body_gyro_x_test.txt"  
     [9] "test/Inertial Signals/body_gyro_y_test.txt"  
    [10] "test/Inertial Signals/body_gyro_z_test.txt"  
    [11] "test/Inertial Signals/total_acc_x_test.txt"  
    [12] "test/Inertial Signals/total_acc_y_test.txt"  
    [13] "test/Inertial Signals/total_acc_z_test.txt"  
    [14] "test/subject_test.txt"                       
    [15] "test/X_test.txt"                             
    [16] "test/y_test.txt"                             
    [17] "train/Inertial Signals/body_acc_x_train.txt" 
    [18] "train/Inertial Signals/body_acc_y_train.txt" 
    [19] "train/Inertial Signals/body_acc_z_train.txt" 
    [20] "train/Inertial Signals/body_gyro_x_train.txt"
    [21] "train/Inertial Signals/body_gyro_y_train.txt"
    [22] "train/Inertial Signals/body_gyro_z_train.txt"
    [23] "train/Inertial Signals/total_acc_x_train.txt"
    [24] "train/Inertial Signals/total_acc_y_train.txt"
    [25] "train/Inertial Signals/total_acc_z_train.txt"
    [26] "train/subject_train.txt"                     
    [27] "train/X_train.txt"                           
    [28] "train/y_train.txt"                           


#  See the README.txt file for the detailed information on the dataset. 
### For the purposes of this project the files that will be used to load data are listed as follows:

	    test/subject_test.txt
	    test/X_test.txt
	    test/y_test.txt
	    train/subject_train.txt
	    train/X_train.txt
	    train/y_train.txt

### Now we can determine the following:

    Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
    values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
    Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
    Names of Varibles Features come from “features.txt”
    levels of Varible Activity come from “activity_labels.txt”

* So we will use Activity, Subject and Features as part of descriptive variable names for data in data frame.

## Read data from the files into the variables

	Read the Activity files
	dataActivityTest  <- read.table(file.path(setpath, "test" , "Y_test.txt" ),header = FALSE)
	dataActivityTrain <- read.table(file.path(setpath, "train", "Y_train.txt"),header = FALSE)

## Read the Subject files

dataSubjectTrain <- read.table(file.path(setpath, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(setpath, "test" , "subject_test.txt"),header = FALSE)

## Read Fearures files

dataFeaturesTest  <- read.table(file.path(setpath, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(setpath, "train", "X_train.txt"),header = FALSE)

## Look at the properties of the above varibles

## str(dataActivityTest)

	## 'data.frame':    2947 obs. of  1 variable:
	##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

     str(dataActivityTrain)

	## 'data.frame':    7352 obs. of  1 variable:
	##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

	str(dataSubjectTrain)

	## 'data.frame':    7352 obs. of  1 variable:
	##  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

	str(dataSubjectTest)

	## 'data.frame':    2947 obs. of  1 variable:
	##  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

	str(dataFeaturesTest)

	## 'data.frame':    2947 obs. of  561 variables:
	##  $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
	##  $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
	##  $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
	##  $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
	##  $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
	##  $ V6  : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...

	##   [list output truncated]

	str(dataFeaturesTrain)

	## 'data.frame':    7352 obs. of  561 variables:
	##  $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
	##  $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
	##  $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
	##  $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
	##  $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
	##  $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
	##  $ V7  : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
	##  $ V8  : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
	##   [list output truncated]



# Merges the training and  test to create a dataset

1. Concatenate the data tables by rows

	dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
	dataActivity<- rbind(dataActivityTrain, dataActivityTest)
	dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

2.set names to variables

	names(dataSubject)<-c("subject")
	names(dataActivity)<- c("activity")
	dataFeaturesNames <- read.table(file.path(setpath, "features.txt"),head=FALSE)
	names(dataFeatures)<- dataFeaturesNames$V2

3.Merge columns to get the data frame Data for all data

		dataCombine <- cbind(dataSubject, dataActivity)
		Data <- cbind(dataFeatures, dataCombine)

	Extracts mean and standard deviation for each measurement

		subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
		selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
		Data<-subset(Data,select=selectedNames)

 	Double check structure to continue

	str(Data)


# Uses descriptive activity names to name the activities in the data set

	1.Read descriptive activity names from “activity_labels.txt”

		activityLabels <- read.table(file.path(setpath, "activity_labels.txt"),header = FALSE)
		
		Appropriately labels the data set with descriptive variable names

In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.In this part, Names of Feteatures will labelled using descriptive variable names.

    prefix t is replaced by time
    Acc is replaced by Accelerometer
    Gyro is replaced by Gyroscope
    prefix f is replaced by frequency
    Mag is replaced by Magnitude
    BodyBody is replaced by Body

		names(Data)<-gsub("^t", "time", names(Data))
		names(Data)<-gsub("^f", "frequency", names(Data))
		names(Data)<-gsub("Acc", "Accelerometer", names(Data))
		names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
		names(Data)<-gsub("Mag", "Magnitude", names(Data))
		names(Data)<-gsub("BodyBody", "Body", names(Data))

		check

		names(Data)

		##  [1] "timeBodyAccelerometer-mean()-X"                
		##  [2] "timeBodyAccelerometer-mean()-Y"                
		##  [3] "timeBodyAccelerometer-mean()-Z"                
		##  [4] "timeBodyAccelerometer-std()-X"                 
		##  [5] "timeBodyAccelerometer-std()-Y"           

# Creates a second,independent tidy data set and ouput it

In this part,a second, independent tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 4.

		library(plyr);
		Data2<-aggregate(. ~subject + activity, Data, mean)
		Data2<-Data2[order(Data2$subject,Data2$activity),]
		write.table(Data2, file = "tidydata.txt",row.name=FALSE)


# END OF COURSE WORK