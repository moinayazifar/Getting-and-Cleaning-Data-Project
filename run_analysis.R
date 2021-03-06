#Project Description
# Create one R script called run_analysis.R that does the following. 
# 1- Merges the training and the test sets to create one data set.
# 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3- Uses descriptive activity names to name the activities in the data set
# 4- Appropriately labels the data set with descriptive variable names. 
# 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Install data.tables package if not installed already
if (!require("data.table")) {
  install.packages("data.table")
}

#Install reshape2 package if not installed already
if (!require("reshape2")) {
  install.packages("reshape2")
}

#Make sure required packages are installed properly
require("reshape2")
require("data.table")

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

## Download the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

## unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Read activity labels into memory
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# Read data column names into memory
features <- read.table("UCI HAR Dataset/features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

# Read x_test and y_test tables
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Read x_test and subject_test tables
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(X_test) = features

# Get the mean and standard deviation for each measurement.
X_test = X_test[,extract_features]

# Read activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"


# use cbind to bind subject test y_test and x_test data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Read x_train & y_train into memory
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Read subject_train into memory
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features

# Get the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Read activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# use cbind to bind subject train y_train and x_train data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# bind test and train data
data = rbind(test_data, train_data)
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data   = melt(data, id = id_labels, measure.vars = data_labels)

# process and calculate 
tidy_dataset   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

#write table to file tidy_dataset.txt to working directory
write.table(tidy_dataset, file = "./tidy_dataset.txt")
