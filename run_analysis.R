#Set Directory where file the file is stored
setwd("~/CODE ACTIVITIES/UCI HAR Dataset")

#Reading Tables for Train Datasets
xtr <- read.table("train/X_train.txt")
#View(xtr)
ytr <- read.table("train/y_train.txt")
#View(ytr)
subj_tr <- read.table("train/subject_train.txt")
#View(subj_tr)

#Reading Tables for Test Datasets
xtst <- read.table("test/X_test.txt")
#View(xtst)
ytst <- read.table("test/y_test.txt")
#View(ytst)
subj_tst <- read.table("test/subject_test.txt")
#View(subj_tst)

#Reading Features and Activity labels
act_lbls <- read.table("activity_labels.txt",col.names = c("ActivityId","Activity"))
#View(act_lbls)
features <- read.table("features.txt")
#View(features)

#Merging Train and Test Tables
x_final <- rbind(xtr, xtst)
y_final <- rbind(ytr, ytst)
subj_final <- rbind(subj_tr, subj_tst)
#View(x_final)
#View(y_final)
#View(subj_final)

#Naming the columns of the tables
colnames(x_final) <- features[,2]
colnames(y_final) <- "ActivityId"
colnames(subj_final) <- "Subject"

#Merging for the final dataset (train & test)
train_test <- cbind(subj_final,y_final,x_final)
#View(train_test)

#Extracting only the measurements on the mean and standard deviation
col_names <- names(train_test)
new_col_names <- grepl("mean",col_names)|grepl("std",col_names)|grepl("ActivityId",col_names)|grepl("Subject",col_names)

train_test <- train_test[,which(new_col_names)]

#Renaming data: making parameter labels more descriptive
New <- names(train_test)
New <- gsub("^t","Time_",New)
New <- gsub("^f","Frequency_",New)
New <- gsub("Acc","Accelerometer",New)
New <- gsub("Gyro","Gyroscope",New)
New <- gsub("Mag","Magnitude",New)
New <- gsub("mean","_Mean_",New)
New <- gsub("std","_StandardDeviation_",New)
New <- gsub("-","_",New)
names(train_test) <- New

#Renaming data: assigning activity labels on the data
train_test <- merge(act_lbls,train_test,by.x="ActivityId",by.y="ActivityId",all=TRUE)
train_test$ActivityId=NULL


#Turning the activities & subjects into factors 
train_test$Activity  <- as.factor(train_test$Activity)
train_test$Subject <- as.factor(train_test$Subject)

#Creating a tidy dataset based on the final dataset 
#with the average of each variable for each activity and each subject. 
library(dplyr)
tidydata <- train_test %>% 
  group_by(Activity, Subject) %>% 
  summarize_all(list(name=mean))
View(tidydata)


#Saving the tidy data as a *.txt* file
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)