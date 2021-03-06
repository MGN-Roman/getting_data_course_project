Getting and Clearing Data course project
===========================

This file contains information on how "run_analysis.R" and "run_analysis_main_code.R" files work.

To make it work you should have UCI HAR Dataset in your working directory. The structure of the 'UCI HAR Dataset' folder has to be unchanged.

The "run_analysis_main_code.R" script makes all work for data processing. It consists of one function: "process_data". The function has one input parameter - "show_messages". It is logical. If show_messages = TRUE, then some diagnostic messages will be printed. Else (by default) only few messages will appear. The "run_analysis_main_code.R" file should be in the working directory.

The "run_analysis.R" script loads "process_data()" function into environment and runs it.
```{r}
source("run_analysis_main_code.R")
process_data(show_messages = FALSE)
```

The "process_data()" function makes the following:

1. Checks if the UCI HAR Dataset is available and prints the corresponding message.
2. Creates /UCI HAR Dataset/merged and /UCI HAR Dataset/merged/Inertial Signals directories.
3. Loads and merges the trainig and test datasets and saves the merged data in the same format and file structure as separate dataset are. For example, this function creates the "X_merged.txt" file, which is the united "X_train.txt" and "X_test.txt". All rows in merged files are sorted by action type and person ID. The merging works file by file. After saving the merged file all temporary variables are removed from the environment. After this part of code in the enviroment stay merged data from X_???.txt files, features labels (which are the descriptional names for the X_???.txt files columns) from "features.txt", activities descriptive labels from the "activity_labels.txt", merged persons IDs from "subject_???.txt" files and merged activities codes for each observation.
4. Next the function analyses features labels and find all with the "mean" and "std" patterns.
5. Adds names to the merged data columns.
6. Replaces activity codes with the corresponding strins, creates a dataframe with "person ID" and "activity label" columns in it.
7. Makes a subset of "mean" and "std" columns only and joins activity labels, persons IDs and selected data into a single dataframe.
8. Saves the single dataframe to the "merged_mean_std_data.txt" file.
9. Aggregates the single dataframe by person and activity, calculates mean on each data column. This operation creates a new dataframe called "agg_data". It performes the fifth task for the project.
10. Saves "agg_data" to the "independent_mean_data.txt" file and prints a message, saying the work is finished.

There are comments in "run_analysis_main_code.R" which may be usefull.
