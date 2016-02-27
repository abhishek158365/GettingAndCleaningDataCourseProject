# GettingAndCleaningDataCourseProject
Scripts and codebooks for course project : Getting and Cleaning Data

This repo contains 3 files
1. run_analysis.R - contains a commented script for getting, cleaning and summarizing the UCI HAR dataset
2. CodeBook.md - contains a description of variables in the data
3. tidy.txt - the final output 

## Description of original dataset 
Original DataSet is organized into two parts - train and test with both having structrure of X Sets (feature set) , Y sets (target label) ans subject labels containing ID of the subject for each record in X and Y sets. 
Outside these folders there are two files of use activity_labels.txt and features.txt which contain the enumerated lists for activities and features respectively.
The feature_info.txt file acts as the codebook for this data set 
Inertial signal files are not used for this exercise

## Description of the steps taken in the exercise
1. Load the test and train datasets ( X,Y and subject components) join columnwise for each set then join the two sets together rowwise
2. Load the feature names and chech by regex for presence of "mean" and "std" substrings and create a logical vector for filtering data from step 1
3. Filter and name the dataset from step 1 with this logical vector
4. Convert the SubjectLable and activityLable to factors for easy melting
5. Cast the data over these two factors with aggregation as mean 
