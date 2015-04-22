library("data.table")

#1. Merges the training and the test sets to create one data set.
mergedSets <- data.table(rbind(read.table("./data/train/X_train.txt"),
			   			  	   read.table("./data/test/X_test.txt")))

mergedLabels <- data.table(rbind(read.table("./data/train/y_train.txt"),
								 read.table("./data/test/y_test.txt")))

mergedSubjects <- rbind(read.table("./data/train/subject_train.txt"),
								   read.table("./data/test/subject_test.txt"))

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
setnames(mergedSets,as.character(read.table("./data/features.txt")[,2]))
mergedSets <- mergedSets[,grep("std\\(\\)|mean\\(\\)",names(mergedSets)),with=FALSE]

#3. Uses descriptive activity names to name the activities in the data set
mergedLabels[, rowNo:=.I]
setkey(mergedLabels,V1)
activityLabels <- data.table(read.table("./data/activity_labels.txt"))
setkey(activityLabels,V1)
mergedLabels <- mergedLabels[activityLabels]
mergedLabels <- mergedLabels[order(rowNo)]
mergedSets[,subject:=mergedSubjects$V1]
mergedSets[,activity:=mergedLabels$V2]

#4. Appropriately labels the data set with descriptive variable names. 
names <- str_replace_all(names(mergedSets),"\\(\\)","")
names <- str_replace_all(names,"-","")
names <- str_replace(names,"^(t|f)","")
names <- str_replace(names,"std","Std")
names <- str_replace(names,"mean","Mean")
setnames(mergedSets,names)
write.csv(mergedSets,"./data/tidy_data.csv")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averagedData <- mergedSets[,lapply(.SD, mean),by=.(subject,activity)]
write.table(averagedData, "./data/averaged_data.txt",row.name=FALSE)