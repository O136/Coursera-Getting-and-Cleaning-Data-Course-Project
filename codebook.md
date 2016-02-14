# Working with raw data

The script `run_analysis.R` implements the 5 steps described in the course project's requirements.

* We read separate the test and train data (more info about train/test data in the README.md)
* The activity data is addressed with its id(1:6) and we find the activity names and ids from `activity_labels.txt` , further in our script, we use the `activity_description` to make it clear, what we are doing.We are using their `ids` later to merge data.
* The separated test and train data are merged into 1 dataframe
* The merged data's columns are renamed according to the `features.txt` which describes the data collected from the observers
* Next, we extract only columns with mean and standard deviation measures from our merged dataset.
* The final data whose column names are unclear, are renamed using regular expressions.
* According to the 5th step from the course requirements we make a new dataset with all the average for each subject and his activity type (a total combination of 180 rows, 30 subjects * 6 activities), all this was done with ddply function. The output file is called `tidy_average.txt`, but was not uploaded to this repository due to the course requirements.

# Description of script variables

* `x_train`, `y_train`, `subject_train` store the train data.
* `x_test`, `y_test` and `subject_test` store the test data.
* `train_data` holds the merged `x_train`, `y_train`, `subject_train`
* `test_data` holds the merged `x_test`, `y_test` and `subject_test`
* `features` store all the column names for our further data set
* `activity_labels` have activity id with a clear word what this id means
* `data` holds the selected mean and std columns from the merged `test_data` and `train_data`
* `detailed_data` store the same contents as `data` variable but instead of `activity_id` column it has `activity_description` column so that it brings sense to the data which we are working with
* `tidy_average` stores the means for every subject grouped by his activity(total possible combinations 180 rows). The call to ddply did not average the `subject_id` and `activity_description` column because it is doesn't bring us any rational result.
