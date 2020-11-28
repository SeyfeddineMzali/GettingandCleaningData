library(reshape2)


## Download Data


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")

## Merge training and test data sets

## Modify this to point to the location of  the dataset
setwd("./UCI HAR Dataset")

## Training dataset

train <- read.table("./train/X_train.txt")
subtrain <- read.table("./train/subject_train.txt")
actrain <- read.table("./train/y_train.txt")

train <- cbind(actrain,subtrain,train)

## Test dataset

test <- read.table("./test/X_test.txt")
subtest <- read.table("./test/subject_test.txt")
actest <- read.table("./test/y_test.txt")

test <- cbind(actest,subtest,test)

AllData <- rbind(train,test)

## Read Activity Labels 
aclabels <- read.table("activity_labels.txt")

## Read column labels and add column label
collabels <- read.table("features.txt")
collabels[,2] <- as.character(collabels[,2])
names(AllData) <- c("Activity","Subject",collabels[,2])

## Change Activity Code to Activity Label

AllData$Activity <- factor(AllData$Activity, levels = aclabels[,1], labels = aclabels[,2])
AllData$Subject <- as.factor(AllData$Subject)

## Select only those columns with mean and standard deviation
reqcols <- grep(".*mean.*|.*std.*", collabels[,2])
ReqData <- AllData[reqcols]

## Reduce to mean of each 
melts <- melt(ReqData, id = c("Subject", "Activity"))
ReqDataRed <- dcast(melts, Subject + Activity ~ variable, mean)

names(ReqDataRed) <- gsub("\\()|-","",names(ReqDataRed))

write.table(ReqDataRed, "tidy.dat", row.names = FALSE, col.names= FALSE, quote = FALSE)

codebooknames <- as.data.frame(names(ReqDataRed))
write.table(codebooknames, "codebook.dat", row.names = FALSE, col.names = FALSE, quote = FALSE)

