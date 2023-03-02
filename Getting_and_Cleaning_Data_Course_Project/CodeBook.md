## How to get to the tinyData.txt

1. Execute the R script.

## About the Data

Data for the project: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## About R script

File with R code "run_analysis.R" performs the 5 following steps (in accordance assigned task of course work):

0. Downloading and making the files ready to be analysed.
1. Merges the training and the test sets to create one data set.
2. Select only the mean and standard deviation columns from the merged dataset.
3. Use descriptive activity names from the 'activity_labels' dataset.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## About variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in.
