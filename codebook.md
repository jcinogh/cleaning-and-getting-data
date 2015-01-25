

setup_DF : This is a function that takes three parameters (feature_path,infile_data,dataset_type="train")
default of dataset_type is the value "train", to read all the training data files. The first argument is the path to 
the feature file and the second argument is the path to the directory that stores the test files or the training files

list.train is a list containing dataframes of all the files that  will be used to create the training data set.
list.test is a list containing dataframes of all the files that  will be used to create the test data set.

prep_data : This a function that prepares the list created from the setup_DF function and returns a data frame.

alltrain is a dataframe containing all the observations in the training set


alltest is a dataframe containing all the observations in the test set


detail.Data is a dataframe of the combined training set and test set

temp.data is a list containg 6 data frames. Which is essentially all the summary for each of the 6 activities for 
each subject.

Summary.data is a dataframe containing a concatenation of all 6 data frames in the list temp.data
