# Downloading and making the files ready to be analysed

## Load the dplyr library for data manipulation
library(dplyr)

## Assign the name of the file to the variable 'filename'
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

## Check if archive already exists. If not, download it
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

## Check if folder exists. If not, unzip the archive
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Import the necessary datasets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Step 1: Merges the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_Data <- cbind(subject, y, x)

# Step 2: Select only the mean and standard deviation columns from the merged dataset
tidyData <- merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Step 3: Use descriptive activity names from the 'activity_labels' dataset
tidyData$code <- activities_labels[tidyData$code, 2]

# Step 4: Appropriately labels the data set with descriptive variable names
names(tidyData)<-gsub("[.\\(\\)-]", "", names(tidyData))
names(tidyData)[1] = "Subject"
names(tidyData)[2] = "Activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "TimeDomain", names(tidyData))
names(tidyData)<-gsub("^f", "FrequencyDomain", names(tidyData))
names(tidyData)<-gsub("tBody", "Timebody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("mean", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "StandardDeviation", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("std", "StandardDeviation", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("freq", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
finalAnalysis <- tidyData %>%
  group_by(Subject, Activity) %>%
  summarise_all((mean))

# Write results to file
write.table(finalAnalysis, "tidy_data.txt", row.name=FALSE)