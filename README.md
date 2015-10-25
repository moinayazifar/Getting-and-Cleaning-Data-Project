# Getting and Cleaning Data Course Project

### Overview
The goal of this project is to merge, label and extract multiple data sets in order to prepare tidy data set that can be used for further analysis. 

We have used Human Activity Recognition Using Smart phones Data Set provided by UCI Center for Machine Learning and Intelligent Systems. The dataset and its description can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
## Prject Contents 
The project includes the following files:
1- 'README.md' : Explains how all of the scripts work and how they are connected

2- 'CodeBook.md' : Describes the variables, the data, and any transformations or work that is performed to clean up the data.

3- 'run_analysis.R' : Main Script

4- 'tiny_dataset.txt' : Results


## Project Description

In this project we have created an R script called run_analysis.R that does the following steps.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Library Dependencies
In order to run this program you will need an internet connection, so the script can install eshape2 and data.table packages. You also have the option of pre-installing these packages.

## How To Run The Program

This program is designed to require minimum configuration. Simply run source("run_analysis.R"), the program will automatically install the required packages and download and unzip the dataset. It will write the result file tiny_dataset.txt in your working directory.
