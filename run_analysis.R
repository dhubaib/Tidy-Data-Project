## Make sure working directory is where the data is saved
datadir <- dirname(sys.frame(1)$ofile)
if(getwd()!=datadir){
  setwd(datadir)
}


## Get activity lables
activity_labels <- scan("UCI-HAR-Dataset/activity_labels.txt", what = "character")
activity_labels <- activity_labels[seq(2,length(activity_labels), by = 2)] # Get labels only....

tbl<- scan("UCI-HAR-Dataset/train/subject_train.txt", what = "numeric", sep = "\n")

