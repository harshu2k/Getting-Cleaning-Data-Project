###################################################
# Download data from the website for repeatability
if (!file.exists("UCI HAR Dataset")) {
   dir.create("UCI HAR Dataset")
}


if (!file.exists("./UCI HAR Dataset/UCI Dataset.zip")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "./UCI HAR Dataset/UCI Dataset.zip")
    unzip("./UCI HAR Dataset/UCI Dataset.zip",exdir = ".")
}

##################################################
# 1. Merge Training & Test sets
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_merged <- rbind(Xtrain,Xtest)
features_labels <- read.table("./UCI HAR Dataset/features.txt")[,2]
names(X_merged) = features_labels

Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
Ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
Y_merged <- rbind(Ytrain,Ytest)
names(Y_merged) <- "Activity"

SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Subjects <- rbind(SubjectTest,SubjectTrain)
names(Subjects) <- "Subject"

XY_merged <- cbind(Y_merged,X_merged)
All_data <- cbind(Subjects,XY_merged)

############################################################
# 2. Extract only measurements on Mean & Standard Deviation
extract <- grepl("mean|std", features_labels)
All_data <- All_data[,extract]

###########################################################################
# 3. Use descriptive activity names to name the activities in the data set
All_data$Activity[All_data$Activity=='1'] <- 'Walking'
All_data$Activity[All_data$Activity=='2'] <- 'Walking Upstairs'
All_data$Activity[All_data$Activity=='3'] <- 'Walking Downstairs'
All_data$Activity[All_data$Activity=='4'] <- 'Sitting'
All_data$Activity[All_data$Activity=='5'] <- 'Standing'
All_data$Activity[All_data$Activity=='6'] <- 'Laying'

####################################################
# 4. Label the dataset with descriptive lable names
names(All_data) <- gsub('^t', 'Time', names(All_data))
names(All_data) <- gsub('-', '', names(All_data))
names(All_data) <- gsub('Acc','Acceleration', names(All_data))
names(All_data) <- gsub('Mag','Magnitude', names(All_data))
names(All_data) <- gsub('^f','Frequency', names(All_data))
names(All_data) <- gsub('-mean','Mean', names(All_data))
names(All_data) <- gsub('-std','StandardDeviation', names(All_data))
names(All_data) <- gsub('\\(|\\)','', names(All_data), perl=TRUE)

##########################################################################
# 5. creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject
library(plyr)
Tidy_data <- ddply(All_data, c("Subject","Activity"), numcolwise(mean))
write.table(Tidy_data, file = "Tidy_data.txt", row.names = FALSE)
