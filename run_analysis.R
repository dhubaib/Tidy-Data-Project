## Analysis script to tranform raw data set to tidy data ready for analysis
library(data.table)
library(plyr)
library(dplyr)

# Make sure working directory is where the data is saved
datadir <- dirname(sys.frame(1)$ofile)
if(getwd()!=datadir){
  setwd(datadir)
  print(sprintf("Working directory changed to %s", datadir))
}

# Label activity lables
activities <- read.table("UCI-HAR-Dataset/activity_labels.txt")
colnames(activities) <- c("number", "labels")

# Label feature lables
features <- read.table("UCI-HAR-Dataset/features.txt")
colnames(features) <- c("number", "label")

# Filter desired features (Only mean & std of each variable)
desiredFeatures = grepl("mean|std",features$label)
features <- features[desiredFeatures,]

# Build data dictionary
write.table(features$label, "codebook.txt", sep = "\n", row.names = FALSE, col.names = "List of data elements included in tidy data project analysis", quote = FALSE)

# Prepare column names for tidy dataset 
cnames <- c("subject_id","activity_number", "activity_label", as.character(features$label))

## Load in training set
# Read in subject ID, numbered activity & feature vector for that activity
id_train <- read.table("UCI-HAR-Dataset/train/subject_train.txt")
activity_numbers_train <- read.table("UCI-HAR-Dataset/train/y_train.txt")
activity_labels_train <- mapvalues(activity_numbers_train$V1,c(1,2,3,4,5,6), as.character(activities$label))
features_train <- read.table("UCI-HAR-Dataset/train/X_train.txt")
features_train <- features_train[, desiredFeatures] # Filter for desired feature

print("Training data all loaded...")

# Build the tidy training data set!
tidy_train = cbind(id_train, activity_numbers_train, activity_labels_train, features_train)
colnames(tidy_train) <- cnames

print("Tidy training data built!")

## Load in testing set
# Read in subject ID, numbered activity & feature vector for that activity
id_test <- read.table("UCI-HAR-Dataset/test/subject_test.txt")
activity_numbers_test <- read.table("UCI-HAR-Dataset/test/y_test.txt")
activity_labels_test <- mapvalues(activity_numbers_test$V1,c(1,2,3,4,5,6), as.character(activities$label))
features_test <- read.table("UCI-HAR-Dataset/test/X_test.txt")
features_test <- features_test[, desiredFeatures] # Filter for desired feature

print("Test data all loaded...")

# Build the tidy training data set!
tidy_test = cbind(id_test, activity_numbers_test, activity_labels_test, features_test)
colnames(tidy_test) <- cnames

print("Tidy testing data built!")

## Combine it all together & save to tidy data folder
print("Combining tidy data sets and exporting to CSV \"tidy_data.csv\"")
tidy_data <- rbind(tidy_train, tidy_test)
write.table(tidy_data,"tidy/tidy_data.txt", sep = ",", row.names = FALSE)
print("Export complete")


## Summarize data
summarized <- aggregate(tidy_data, by = list(tidy_data$subject_id, tidy_data$activity_label), FUN = mean, simplify = TRUE, na.action = na.omit)
rmCols = grepl("Group",colnames(summarized)) # Remove unnecessary columns
summarized <- (summarized[which(!rmCols)])

write.table(summarized, "summary.txt", sep = ",")