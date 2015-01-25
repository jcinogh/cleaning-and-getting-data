# cleaning-and-getting-data
For the coursera R course

My scripts has two main functions called setup_DF and prep_data.
The main purpose of the function setup_DF is to read all the external files needed to create the dataset for training dataset and the test datasets and, returns a list with data frames for all the files it reads. 
Setup_DF takes three parameters called feature_path,infile_data and dataset_type.
feature_path: Takes the path of the feature.txt
infile_data: Takes the path of directory that stores the training or the test files
dataset_type: default value is "train" to pull training files. Otherwise use "test" to pull test files.

The main purpose of prep_data is to prepare each data frame in the list created from running the function setup_DF  and creates a dataframe .

The prep_data function only takes one arguement called list.data.
list.data: This is a list that contains the data frames need to be prepped for the summary data.

Setup_DF is called twice to create a list for test amd training sets
prep_data is called twice to prepare the two list objects created by Setup_DF. Two data frames a created as a result for both test and train data.

The two data frames are concatenated using the rbind function to create  a new dataframe called detail.data

A new list is then created by looping through the data frame and filtering on each activity and computing the mean for  each subject under a particular activity.

A summary data set is then created by contenating all six dataframe within the list object created from the loop above.

A lable column is created in the summary data frame to make align all the activities with thier lables.

A text file is then created from the summary data object.



























 
