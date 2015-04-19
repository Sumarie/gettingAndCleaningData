#Script for "Getting and cleaning data" course project

#Step 1: Create data folder if it doesn't exist
if(!file.exists("./data")){
        dir.create("./data")
}

#Step 2: Download and unzip the data
dataUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl,destfile="./data/Dataset.zip")
unzip("./data/Dataset.zip")

##Step 3: Assign all files to variables
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
##Test files
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
##Activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
##Features
features <- read.table("./UCI HAR Dataset/features.txt")

#Step 4: Merge the training (X_train and y_train) and test (X_test and y_test) 
#sets into one data set 
test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
data <- rbind(test, train)

#Add "activityLabels" to features and set column headings in a vector
columnHeadings <- as.character(features$V2)
col_names <- c("subject", "activityLabels", columnHeadings)
colnames(data) <- col_names

#Step 5: Replace activity numbers with descriptive labels
activityLabels$V2 <- as.character(activityLabels$V2)
data$activityLabels <- as.character(data$activityLabels)
for(i in 1:nrow(data)){
        if(data[i,2] == "1"){
                data[i,2] <- activityLabels[1,2]
        } else if(data[i,2] == "2"){
                data[i,2] <- activityLabels[2,2]
        } else if(data[i,2] == "3"){
                data[i,2] <- activityLabels[3,2]
        } else if(data[i,2] == "4"){
                data[i,2] <- activityLabels[4,2]
        } else if(data[i,2] == "5"){
                data[i,2] <- activityLabels[5,2]
        } else {
                data[i,2] <- activityLabels[6,2]
        } 
}

#Step 6: extract mean and standard deviations of each measurement
meanColumns <- grep("mean()", col_names) 
#This will include columns named "meanFreq" therefore have to remove those separately
freqColumns <- grep("Freq", col_names)
onlyMeans <- meanColumns[!(meanColumns %in% freqColumns)]
meanData <- data[,c(1,2,onlyMeans)]

standardDeviationColumns <- grep("std", col_names)
standardDeviationData <- data[,standardDeviationColumns]
meanStandardDeviationData <- cbind(meanData, standardDeviationData)

#Step 7: Provide descriptive column names
descriptiveVariables <- c("subject", "activity", "bodyAccelerationMeanX", "bodyAccelerationMeanY",
                          "bodyAccelerationMeanZ", "gravityAccelerationMeanX",
                          "gravityAccelerationMeanY", "gravityAccelerationMeanZ",
                          "bodyAccelerationJerkMeanX", "bodyAccelerationJerkMeanY",
                          "bodyAccelerationJerkMeanZ", "bodyAngularVelocityMeanX", 
                          "bodyAngularVelocityMeanY", "bodyAngularVelocityMeanZ", 
                          "bodyAngularVelocityJerkMeanX", "bodyAngularVelocityJerkMeanY",
                          "bodyAngularVelocityJerkMeanZ", "bodyAccelerationMagnitudeMean", 
                          "gravityAccelerationMagnitudeMean", "bodyAccelerationJerkMagnitudeMean",
                          "bodyAngularVelocityMagnitudeMean", "bodyAngularVelocityJerkMagnitudeMean",
                          "frequencyBodyAccelerationMeanX", "frequencyBodyAccelerationMeanY",
                          "frequencyBodyAccelerationMeanZ", "frequencyBodyAccelerationJerkMeanX",
                          "frequencyBodyAccelerationJerkMeanY", "frequencyBodyAccelerationJerkMeanZ",
                          "frequencyBodyAngularVelocityMeanX", "frequencyBodyAngularVelocityMeanY",
                          "frequencyBodyAngularVelocityMeanZ", "frequencyBodyAccelerationMagnitudeMean", 
                          "frequencyBodyBodyAccelerationJerkMagnitudeMean",
                          "frequencyBodyBodyAngularVelocityMagnitudeMean", 
                          "frequencyBodyBodyAngularVelocityJerkMagnitudeMean",
                          "bodyAccelerationStandardDeviationX", 
                          "bodyAccelerationStandardDeviationY", 
                          "bodyAccelerationStandardDeviationZ", 
                          "gravityAccelerationStandardDeviationX", 
                          "gravityAccelerationStandardDeviationY", 
                          "gravityAccelerationStandardDeviationZ", 
                          "bodyAccelerationJerkStandardDeviationX",
                          "bodyAccelerationJerkStandardDeviationY",
                          "bodyAccelerationJerkStandardDeviationZ",
                          "bodyAngularVelocityStandardDeviationX", 
                          "bodyAngularVelocityStandardDeviationY", 
                          "bodyAngularVelocityStandardDeviationZ", 
                          "bodyAngularVelocityJerkStandardDeviationX", 
                          "bodyAngularVelocityJerkStandardDeviationY",
                          "bodyAngularVelocityJerkStandardDeviationZ", 
                          "bodyAccelerationMagnitudeStandardDeviation", 
                          "gravityAccelerationMagnitudeStandardDeviation", 
                          "bodyAccelerationJerkMagnitudeStandardDeviation",
                          "bodyAngularVelocityMagnitudeStandardDeviation", 
                          "bodyAngularVelocityJerkMagnitudeStandardDeviation",
                          "frequencyBodyAccelerationStandardDeviationX", 
                          "frequencyBodyAccelerationStandardDeviationY",
                          "frequencyBodyAccelerationStandardDeviationZ", 
                          "frequencyBodyAccelerationJerkStandardDeviationX",
                          "frequencyBodyAccelerationJerkStandardDeviationY", 
                          "frequencyBodyAccelerationJerkStandardDeviationZ",
                          "frequencyBodyAngularVelocityStandardDeviationX", 
                          "frequencyBodyAngularVelocityStandardDeviationY",
                          "frequencyBodyAngularVelocityStandardDeviationZ", 
                          "frequencyBodyAccelerationMagnitudeStandardDeviation", 
                          "frequencyBodyBodyAccelerationJerkMagnitudeStandardDeviation",
                          "frequencyBodyBodyAngularVelocityMagnitudeStandardDeviation", 
                          "frequencyBodyBodyAngularVelocityJerkMagnitudeStandardDeviation")
colnames(meanStandardDeviationData) <- descriptiveVariables

#Step 8: Create clean data set with the average for each activity and each subject
averageData <- aggregate(meanStandardDeviationData[,3:68], meanStandardDeviationData[,1:2], 
                         data=meanStandardDeviationData, mean)

#Write clean data to .txt file
write.table(averageData, "cleanData.txt",row.name=FALSE)
