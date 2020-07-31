# Jerry Lakin - 7/30/20
# This script creates a tidy dataset out of raw smartphone movement data provided by 
# UC Irvine. The data come from an experiment in which 30 subjects performed activities
# of daily living while carrying a waist-mounted smartphone with embedded inertial 
# sensors 
# Link: https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones
# The final dataset will show averages of each measurement variable for each combination 
# of subject and activity

# Import dplyr library
library(dplyr)

# Import feature names as a vector
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)[, 2]

# Import activity reference table as a dataframe
activityList <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("y", "activity"))

# Import test data 
XTest <- read.fwf("./UCI HAR Dataset/test/X_test.txt", widths=rep(16, times=561), col.names=features)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names="y")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names="subject")

# Import train data 
XTrain <- read.fwf("./UCI HAR Dataset/train/X_train.txt", widths=rep(16, times=561), col.names=features)
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names="y")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names="subject")

# Combine test and train data
X <- rbind(XTest, XTrain)
y <- rbind(yTest, yTrain)
subject <- rbind(subjectTest, subjectTrain)

# Merge y vector with activity reference table to get activity labels
activity <- merge(y, activityList, sort=FALSE)

# Extract only the means and standard deviations for each measurement. I am searching
# for the string "mean(" rather than "mean" because I do not want to include the 
# meanFreq measurements
XReduced <- X[, grepl("mean\\(|std", features)]

# Get features from reduced X
featuresReduced <- colnames(XReduced)

# Combine subject, activity and X
df <- cbind(subject, activity, XReduced)

# Create summary table averaging each variable for each subject and activity
dfAvg <- df %>%
    group_by(subject, y, activity) %>%
    summarize_all(mean)

# Create new column names for the averaged variables
featuresAvg <- featuresReduced
for(i in 1:length(featuresReduced)) {
    featuresAvg[i] <- paste("avg.", featuresAvg[i], sep="")
}

# Give the tidy dataset descriptive column names
colnames(dfAvg) <- c("subject.id", "activity.id", "activity", featuresAvg)

# Write to a txt file
write.table(dfAvg, file = "smartphone_movement_data.txt", row.names=FALSE)