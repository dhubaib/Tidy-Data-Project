# Tidy Data Project

## Author: Cal Al-Dhubaib

###? Included files: run_analysis.R, summary.csv, codebook.md, Readme.md
### Included folders: tidy, UCI-HAR-Dataset

The original data files and acompanied readme & descriptions are in the folder UCI-HAR-Dataset.

The script run-analysis.R transforms data from the subfolders "train" & "test" in the original dataset to the folder "tidy". If you check out my repo, and run this script, it will automatically set the working directory to load the data correctly for convenience.

The file summary.csv describes the average of the mean, mean frequency, and standard deviation, of features from the primary data set for each of the 30 subjects and 6 activities in the study. There are a total of 180 observations in this data set for 79 captured variables listed in coodebook.md

The original dataset was sourced from:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012