process_data <- function(show_messages = FALSE) {
# CREATING FILE NAME VARIABLES
f_activity_lables <- ".//UCI HAR Dataset//activity_labels.txt"
f_features <- ".//UCI HAR Dataset//features.txt"
f_X_train <- ".//UCI HAR Dataset//train//X_train.txt"
f_y_train <- ".//UCI HAR Dataset//train//y_train.txt"
f_subj_train <- ".//UCI HAR Dataset//train//subject_train.txt"
f_X_test <- ".//UCI HAR Dataset//test//X_test.txt"
f_y_test <- ".//UCI HAR Dataset//test//y_test.txt"
f_subj_test <- ".//UCI HAR Dataset//test//subject_test.txt"

f_X_merged <- ".//UCI HAR Dataset//merged//X_merged.txt"
f_y_merged <- ".//UCI HAR Dataset//merged//y_merged.txt"
f_subj_merged <- ".//UCI HAR Dataset//merged//subject_merged.txt"

f_inertial_train <- c(".//UCI HAR Dataset//train//Inertial Signals//body_acc_x_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//body_acc_y_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//body_acc_z_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//body_gyro_x_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//body_gyro_y_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//body_gyro_z_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//total_acc_x_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//total_acc_y_train.txt",
                      ".//UCI HAR Dataset//train//Inertial Signals//total_acc_z_train.txt"
                      )

f_inertial_test <- c(".//UCI HAR Dataset//test//Inertial Signals//body_acc_x_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//body_acc_y_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//body_acc_z_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//body_gyro_x_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//body_gyro_y_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//body_gyro_z_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//total_acc_x_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//total_acc_y_test.txt",
                     ".//UCI HAR Dataset//test//Inertial Signals//total_acc_z_test.txt"
                     )
f_inertial_merged <- c(".//UCI HAR Dataset//merged//Inertial Signals//body_acc_x_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//body_acc_y_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//body_acc_z_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//body_gyro_x_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//body_gyro_y_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//body_gyro_z_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//total_acc_x_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//total_acc_y_merged.txt",
                       ".//UCI HAR Dataset//merged//Inertial Signals//total_acc_z_merged.txt"
                      )

#CHECKING IF THE DATA ARE AVILABLE
data_found <- TRUE

data_found <- file.exists(f_activity_lables)  && 
              file.exists(f_features)         &&
              file.exists(f_X_train)          &&
              file.exists(f_y_train)          &&  
              file.exists(f_subj_train)       &&
              file.exists(f_X_test)           &&
              file.exists(f_y_test)           &&
              file.exists(f_subj_test)        &&
              as.logical(prod(file.exists(f_inertial_train))) &&
              as.logical(prod(file.exists(f_inertial_test)))

if (!data_found)
{
  stop("Data files were not found. Please, inzip 'getdata-projectfiles-UCI HAR Dataset.zip'
        into your working directory without changing the archive structure.")
} else {
  print("Data found. Processing ...")
}
remove(data_found)

#CREATING DIRECTORIES FOR THE MERGED DATA SETS
if (!file.exists(".//UCI HAR Dataset//merged")) {
  dir.create(".//UCI HAR Dataset//merged")
}
if (!file.exists(".//UCI HAR Dataset//merged//Inertial Signals")) {
  dir.create(".//UCI HAR Dataset//merged//Inertial Signals")
}

#LOADING DATA AND PROCESSING
if (show_messages) {print("Loading activities lables ...")}
activity_labels <- read.table(file = f_activity_lables, sep = " ")
activity_labels <- as.vector(activity_labels[[2]])
remove(f_activity_lables)

if (show_messages) {print("Loading features lables ...")}
features <- read.table(file = f_features, sep = " ")
features <- as.vector(features[[2]])
remove(f_features)

if (show_messages) {print("Loading trainig data set persons IDs ...")}
training_set_person <- read.table(f_subj_train, sep = "")
training_set_person <- training_set_person[[1]]

if (show_messages) {print("Loading test data set persons IDs ...")}
test_set_person <- read.table(f_subj_test, sep = "")
test_set_person <- test_set_person[[1]]

if (show_messages) {print("Merging persons IDs ...")}
merged_person <- c(training_set_person, test_set_person)

if (show_messages) {print("Loading trainig data set activities IDs ...")}
training_set_activity <- read.table(f_y_train, sep = "")
training_set_activity <- training_set_activity[[1]]

if (show_messages) {print("Loading test data set activities IDs ...")}
test_set_activity <- read.table(f_y_test, sep = "")
test_set_activity <- test_set_activity[[1]]

if (show_messages) {print("Merging activities IDs ...")}
merged_activity <- c(training_set_activity, test_set_activity)

if (show_messages) {print("Sorting persons and activities IDs ...")}
sorted_row_indexes <- order(merged_activity,merged_person)
merged_person <- merged_person[sorted_row_indexes]
merged_activity <- merged_activity[sorted_row_indexes]

if (show_messages) {print("Saving persons and activities IDs ...")}
write.table(merged_person, file = f_subj_merged, col.names = FALSE, row.names = FALSE)
write.table(merged_activity, file = f_y_merged, col.names = FALSE, row.names = FALSE)

#clearing RAM
remove(training_set_person)
remove(test_set_person)
remove(f_subj_test)
remove(f_subj_train)
remove(f_subj_merged)
remove(training_set_activity)
remove(test_set_activity)
remove(f_y_train)
remove(f_y_test)
remove(f_y_merged)

if (show_messages) {print("Merging and saving inertial signals. Please, wait ...")}
for (i in 1: length(f_inertial_merged)) {
  temporary_train_table <- read.table(f_inertial_train[i], sep = "")
  temporary_test_table <- read.table(f_inertial_test[i], sep = "")
  temporary_merged_table <- rbind(temporary_train_table, temporary_test_table)
  temporary_merged_table <- temporary_merged_table[sorted_row_indexes,]
  write.table(temporary_merged_table, file = f_inertial_merged[i], col.names = FALSE, row.names = FALSE)
}

#clearing RAM
remove(i)
remove(temporary_train_table)
remove(temporary_test_table)
remove(temporary_merged_table)
remove(f_inertial_train)
remove(f_inertial_test)
remove(f_inertial_merged)

if (show_messages) {print("Loading training data set. Please, wait ...")}
training_set <- read.table(file = f_X_train, sep = "")

if (show_messages) {print("Loading test data set. Please, wait ...")}
test_set <- read.table(file = f_X_test, sep = "")

if (show_messages) {print("Merging and saving features data sets signals. Please, wait ...")}
merged_set <- rbind(training_set, test_set)
merged_set <- merged_set[sorted_row_indexes, ]
write.table(merged_set, file = f_X_merged, col.names = FALSE, row.names = FALSE)

#clearing RAM
remove(training_set)
remove(test_set)
remove(f_X_train)
remove(f_X_test)
remove(f_X_merged)
remove(sorted_row_indexes)

if (show_messages) {print("Extracting only the measurements on the mean and standard deviation for each measurement.
                           Naming new data set and saving it to .//merged_mean_std_data.txt")}
#finding all column indexes with pattern "mean" in the label
means_indexes <- grep(features, pattern = "mean", value = FALSE)
#finding all column indexes with pattern "std" in the label
stds_indexes <- grep(features, pattern = "std", value = FALSE)
#union columns and sort them to get the original order
needed_columns <- union(means_indexes, stds_indexes)
needed_columns <- sort(needed_columns)
#clearing RAM
remove(means_indexes)
remove(stds_indexes)
#naming the merged data set columns
names(merged_set) <- features
#replacing activity IDs with their discriptive names
merged_activity <- activity_labels[merged_activity]
#creating and naming new data frame which consists of activity and person_id
new_merged_data_set <- data.frame(merged_activity)
new_merged_data_set <- cbind(new_merged_data_set, merged_person)
#naming the new data frame columns ...
names(new_merged_data_set) <- c("activity", "person_id")
#... and binding new columns from merged_set. The result is stored in merged_set
merged_set <- cbind(new_merged_data_set, merged_set)
#saving new data set, extracting only needed columns
write.table(merged_set[c(1,2,needed_columns + 2)], "merged_mean_std_data.txt", row.names = FALSE)
#clearing RAM
remove(activity_labels)
remove(features)
remove(merged_activity)
remove(merged_person)
remove(needed_columns)
remove(new_merged_data_set)

#Now we're going to create a separate data set with averages of each variable
#for each activity and person 
if (show_messages) {print("Going to create a separate data set with averages of each variable for each activity and person.
                           Naming new data set and saving it to .//independent_mean_data.txt")}
#aggregating data by person_id and activity and applying "mean()" function for each column
aggdata <- aggregate(merged_set[,3:dim(merged_set)[2]], by = list(merged_set$person_id, merged_set$activity), FUN = mean, na.rm = TRUE)
#swapping activities and person IDs
aggdata[c(1,2)] <- aggdata[c(2,1)]
#properly naming columns
names(aggdata)[1:2] <- c("activity", "person_id")
names(aggdata)[3:dim(aggdata)[2]] <- paste("mean(", names(aggdata)[3:dim(aggdata)[2]], ")")
#saving data
write.table(aggdata, "independent_mean_data.txt", row.names = FALSE)
#clearing RAM
remove(merged_set)
remove(aggdata)
remove(show_messages)
print("Data processing is finished.")
print("Merged data set in the 'UCI HAR Dataset/merged' directory.")
print("The data subset extrated from merged data set in the 'merged_mean_std_data.txt'")
print("The second indpendent data subset is in 'independent_mean_data.txt'")
}