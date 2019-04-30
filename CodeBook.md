# Tidy Data Code Book
### This contains information on the **data**, **variables**, and **summaries** calculated.
# Source File
### The data used in this course assignment is from the data from the accelerometers of the Samsung Galaxy S smartphone.

#### Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#### Data full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## **Dataset Files**

   * README.txt
   * features_info.txt: Shows information about the variables used on the feature vector.
   * features.txt: List of all features.
   * activity_labels.txt: Links the class labels with their activity name.
   * train/X_train.txt: Training set.
   * train/y_train.txt: Training labels.
   * test/X_test.txt: Test set.
   * test/y_test.txt: Test labels.

## **Features**

   * tBodyAcc-XYZ
   * tGravityAcc-XYZ
   * tBodyAccJerk-XYZ
   * tBodyGyro-XYZ
   * tBodyGyroJerk-XYZ
   * tBodyAccMag
   * tGravityAccMag
   * tBodyAccJerkMag
   * tBodyGyroMag
   * tBodyGyroJerkMag
   * fBodyAcc-XYZ
   * fBodyAccJerk-XYZ
   * fBodyGyro-XYZ
   * fBodyAccMag
   * fBodyAccJerkMag
   * fBodyGyroMag
   * fBodyGyroJerkMag
   * gravityMean
   * tBodyAccMean
   * tBodyAccJerkMean
   * tBodyGyroMean
   * tBodyGyroJerkMean

## **Activities**

   * WALKING
   * WALKING_UPSTAIRS
   * WALKING_DOWNSTAIRS
   * SITTING
   * STANDING
   * LAYING

## **The run_analysis.R script does the following**

   1. It merged the training and test set into a 1 whole dataset.
      * Used ***rbind()*** to merge each (x,y, and subj tables) table in train and test.
      * Used ***cbind()*** to merge tbe x_final,y_final, and subj_final to create the train_test dataset.
   2. Extracted mean and standard deviation measurements from the resulting merged data set.
      * Used ***grepl*** on column names of train test to extract *"std"* and *"mean"*.
      * Overwrote the train_test dataset.
   3. Renamed the activities and the features using more descriptive names.
      * Renamed the columns using ***gsub()***. 
   4. Created the final dataset, *tidydata.txt*, containing the average of each variable for each activity.
      * Used ***group_by()*** to group Activity and Subject
      * Getting the mean using ***summarize_all()***
      * Created a new *txt* file using ***write.table()***
