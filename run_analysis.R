#Coursera- Getting and Cleaning Data
#Final assignment
#RW
#Nov.24, 2019
#R version 3.5.3 (2019-03-11)

#load package for reshaping data
library(reshape2)

filename <- "getdata_dataset.zip"

# Download and unzip the dataset using the assignment url
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}


# Import the data that corresponds to the features of this dataset
# note later these will be converted to column names
features <- read.table("UCI HAR Dataset/features.txt")
# selecting all data in the second column (all rows)
features[,2] <- as.character(features[,2])


# Import the activity labels that correspond to this dataset
act.Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# selecting all data in the second column (all rows)
act.Labels[,2] <- as.character(act.Labels[,2])


# Extract only the data on mean and standard deviation
features.final <- grep(".*mean.*|.*std.*", features[,2])
features.final.names <- features[features.final,2]
# recode -mean to Mean
features.final.names = gsub('-mean', 'Mean ', features.final.names)
#recode -std to Std
features.final.names = gsub('-std', 'Std ', features.final.names)

features.final.names <- gsub('[-()]', ' ', features.final.names)

# Load the training datasets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[features.final]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- cbind(trainSubjects, x_train, trainActivities)

# Load the test datasets
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[features.final]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- cbind(testSubjects, testActivities, x_test)

# merge datasets and add labels
allData <- rbind(x_train, x_test)
colnames(allData) <- c("subject", "activity", features.final.names)

# convert to factor
allData$activity <- factor(allData$activity, levels = act.Labels[,1], labels = act.Labels[,2])
# convert to factor
allData$subject <- as.factor(allData$subject)

Data.final <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(Data.final, subject + activity ~ variable, mean)

#export data as a table
#note table will be saved in your working directory
write.table(allData.mean, "tidy_assignment.txt", row.names = FALSE, quote = FALSE)