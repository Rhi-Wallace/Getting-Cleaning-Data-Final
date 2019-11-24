# Getting-Cleaning-Data-Final
## Final Assignment: Getting and Cleaning Data

Welcome!

Here you will find my final assignment for "Getting and Cleaning Data". With the R script (run_analysis.R) you will be able to do the following:

- Download and unzip folder with the url provide for the assignment
- Import the features.txt. Second column will be converted to the column names.
- Import the labels that correspond with the 6 different activities.
- filter entries that only include the mean or std as part of the string
- Recode some of the column labels
- Load into R the actual train and test datasets
- Assign the recoded features as the column names
- Merge together the measurement, subject and acitvity data
- Combine the reshaped train and test data
- Calculate the mean of each variable
- Produces a .txt of the final results

Note: 
1.) You will need to install and load the Reshape2 package in order to run this script.
2.) The txt table will be saved in your working directory.
