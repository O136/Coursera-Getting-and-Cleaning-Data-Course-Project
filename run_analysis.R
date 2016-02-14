library(plyr) # for ddply function

features <-  read.table("./features.txt")
activity_labels <-  read.table("./activity_labels.txt")

names(activity_labels) <- c("activity_id", "activity_description")

# read the train data
subject_train <-  read.table("./train/subject_train.txt")
x_train       <-  read.table("./train/x_train.txt") 
y_train       <-  read.table("./train/y_train.txt")

#read the test data
subject_test <-  read.table("./test/subject_test.txt")
x_test       <-  read.table("./test/x_test.txt")
y_test       <-  read.table("./test/y_test.txt")

#rename all the read in train and test data
names(subject_train) <- names(subject_test) <- "subject_id"
names(x_train) <- names(x_test) <- features[,2]
names(y_train) <- names(y_test) <- "activity_id"

#bind/put together the train data
train_data <- cbind(subject_train, y_train, x_train)

#bind/put together the test data
test_data <- cbind(subject_test, y_test, x_test)

#"glue" the train and test data together
data <- rbind(train_data, test_data)

#select only mean and std , of course keep the subj and activity id so that our data makes sense
data <- data[,c(1,2,grep("-(mean|std)",names(data)))]

#label our activities with a clear word
detailed_data <- merge(data, activity_labels, by = "activity_id")

#remove the activity_id column , it makes no sense since we have a word for it , not a number
detailed_data <- detailed_data[,-1]

col_names <- names(detailed_data)

#clean the column names
col_names <- gsub("BodyBody","Body",col_names, ignore.case = T)
col_names <- gsub("^(f)","freq",col_names, ignore.case = T)
col_names <- gsub("^(t)","time",col_names, ignore.case = T)
col_names <- gsub("Mag","Magnitude",col_names, ignore.case = T)
col_names <- gsub("\\(\\)","",col_names) # remove paranthesis

#update the dataset names
names(detailed_data) <- col_names

#get the mean for all cols for every subject with its corresponding activity
tidy_average <- ddply(detailed_data, .(subject_id, activity_description), function(x) colMeans(x[,-c(1,81)])) #don't mean the subject_id and activity_description

#save the average in a text file
write.table(tidy_average, "tidy_average.txt", row.name=F)
