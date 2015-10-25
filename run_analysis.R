## Analysis script to tranform raw data set to tidy data ready for analysis
library(data.table)
library(plyr)

# Make sure working directory is where the data is saved
datadir <- dirname(sys.frame(1)$ofile)
if(getwd()!=datadir){
  setwd(datadir)
}

# Parse activity lables
activity_labels <- scan("UCI-HAR-Dataset/activity_labels.txt", what = "character")
activity_labels <- activity_labels[seq(2,length(activity_labels), by = 2)] # Ignore the numbers in the file....

# Parse feature lables
feature_labels <- scan("UCI-HAR-Dataset/features.txt", what = "character")
feature_labels <- feature_labels[seq(2,length(feature_labels), by = 2)] # Ignore the numbers in the file....

# Prepare column names for tidy dataset 
cnames <- c("subject_id","activity_number", "activity_label", feature_labels)


## Load in training set first...
# Read in subject ID, numbered activity & feature vector for that activity
id_train <- scan("UCI-HAR-Dataset/train/subject_train.txt", what = "numeric", sep = " ")
activity_numbers_train <- scan("UCI-HAR-Dataset/train/y_train.txt", what = "character", sep = " ")
activity_labels_train <- mapvalues(activity_numbers_train,c(1,2,3,4,5,6), activity_labels)
features_train <- scan("UCI-HAR-Dataset/train/X_train.txt", what = "numeric", sep = "\n")



#tidy_train = data.table(cnames, key = cnames)

## Now deal with testing set

## Combine it all together & save to tidy data folder
