#Import feature names first because they will be used to assign column names
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)

#Import test data and combine it into a single dataframe
XTest <- read.fwf("./UCI HAR Dataset/test/X_test.txt",widths=rep(16,times=561), col.names = features[,2])
yTest <- read.csv("./UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names="y")
subjectTest <- read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names="subject")
test <- cbind(subjectTest,XTest,yTest)

#Import training data and combine it into a single dataframe
XTrain <- read.fwf("./UCI HAR Dataset/train/X_train.txt",widths=rep(16,times=561), col.names = features[,2])
yTrain <- read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names="y")
subjectTrain <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names="subject")
train <- cbind(subjectTrain,XTrain,yTrain)

#Combine test and train data
testTrain <- rbind(test,train)

#Extract only the means and standard deviations for each measurement
meanStd <- testTrain[grepl("mean|std",features[,2]),]

