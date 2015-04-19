# gettingAndCleaningData
Course project script and data files


##The data
The data for this project is contained in this repository. It is originally from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

The data reports on movements of 30 individuals, such as walking, walking upstairs, walking_downstairs, sitting, standing, and laying. The data is split into a test and a training set (X_test.txt and X_train.txt), along with activity labels for each data set (Y_test.txt and Y_train.txt). The activities are coded using a scale from 1-6. The definitions can be found in the activity_labels.txt file. For more information on the data, see the features_info.txt file. 

##The analysis
The run_analysis.R file is a script that can be used to perform the following steps:
- download and read in the data
- merge the training and test sets (including "subject" and "labels") into one data set
- replace activity numbers with descriptive activity names
- create a data set containing only the mean and standard deviation measurements
- provide human-readable descriptive column headings for the newly created data set
- create another data set which summarises the average over each activity for each subject
