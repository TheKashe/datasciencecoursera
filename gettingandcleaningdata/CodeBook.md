# Introduction


###Variables

- subject:			the subject producing the data
- activity:			activity performed when data was created

The names of the following variables names consist of:

- (Body|Gravity) - which parameter the value represents
- (Acc|Gyro) - was the data obtained from accelerometer or gyro
- (Mean|Std) - the value represents mean or standard deviation
- (X|Y|Z) - X,Y or Z axis


- BodyAccMeanX
- BodyAccMeanY
- BodyAccMeanZ
- BodyAccStdX
- BodyAccStdY
- BodyAccStdZ
- GravityAccMeanX
- GravityAccMeanY
- GravityAccMeanZ
- GravityAccStdX
- GravityAccStdY
- GravityAccStdZ
- BodyAccJerkMeanX
- BodyAccJerkMeanY
- BodyAccJerkMeanZ
- BodyAccJerkStdX
- BodyAccJerkStdY
- BodyAccJerkStdZ
- BodyGyroMeanX
- BodyGyroMeanY
- BodyGyroMeanZ
- BodyGyroStdX
- BodyGyroStdY
- BodyGyroStdZ
- BodyGyroJerkMeanX
- BodyGyroJerkMeanY
- BodyGyroJerkMeanZ
- BodyGyroJerkStdX
- BodyGyroJerkStdY
- BodyGyroJerkStdZ
- BodyAccMagMean
- BodyAccMagStd
- GravityAccMagMean
- GravityAccMagStd
- BodyAccJerkMagMean
- BodyAccJerkMagStd
- BodyGyroMagMean
- BodyGyroMagStd
- BodyGyroJerkMagMean
- BodyGyroJerkMagStd
- BodyAccMeanX
- BodyAccMeanY
- BodyAccMeanZ
- BodyAccStdX
- BodyAccStdY
- BodyAccStdZ
- BodyAccJerkMeanX
- BodyAccJerkMeanY
- BodyAccJerkMeanZ
- BodyAccJerkStdX
- BodyAccJerkStdY
- BodyAccJerkStdZ
- BodyGyroMeanX
- BodyGyroMeanY
- BodyGyroMeanZ
- BodyGyroStdX
- BodyGyroStdY
- BodyGyroStdZ
- BodyAccMagMean
- BodyAccMagStd
- BodyBodyAccJerkMagMean
- BodyBodyAccJerkMagStd
- BodyBodyGyroMagMean
- BodyBodyGyroMagStd
- BodyBodyGyroJerkMagMean
- BodyBodyGyroJerkMagStd


### How was data processed

1. For each original data set (x_train, y_train and subject_test) the test and train data is concatenated into one set

2. Only columns containing either mean or std deviation are left in the data set, other are filtered out

3. Activty values are replaced with labels using data.table join operation (which requires reordering due to internals of data.table)

4. variable names are changed so that:

- any parenthesis are removed
- dashes are removed
- "t" and "f" at the begining of variable name are removed
- "std" and "mean" are capitalised

