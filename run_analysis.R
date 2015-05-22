library(data.table)
library(dplyr)

##Read in activity labels
Act <- read.table('activity_labels.txt', col.names=c('V1', 'activity'))
 
##Read in feature names
feat <- fread('features.txt')

#-------------------------------------------------------------------------
##Read in training dataset
system.time(tr <- read.table('./X_train.txt', col.names=feat$V2))

##Read in training labels
system.time(tr_lbl <- fread('./y_train.txt'))

## Read in training dataset subject ID
system.time(tr_subj <- read.table('./subject_train.txt', col.names='ID'))

## Combine ID, activities, and training data together
tr <- cbind(tr_subj, tr_lbl, tr)
head(tr[1:5], 10)

##Label activities
library(plyr)
tr <- join(tr, Act, by='V1', type='left')
table(tr$V1, tr$activity)

## Check data format
dim(tr)
head(tr[1:5], 10)
head(tr[561:564], 10) 

## Assign col names to activity ID
##:{ I got warnings with this command bc data.table: names(y)[1:3] <- c('ID', 'activity_ID', 'activity')
setnames(tr, 2, 'activity_ID')
names(tr)[c(1:5, 561:564)]

###if data.table use these commands:
### head(tr[, 1:5, with=FALSE], 10)
##:{ or this command: head(tr[, c('ID', "activity_ID", "activity", "tBodyAcc.mean...X", "tBodyAcc.mean...Y"), with=FALSE], 10)

#-------------------------------------------------------------------------

##Read in testing dataset
system.time(ts <- read.table('./X_test.txt', col.names=feat$V2))

##Read in testing labels
system.time(ts_lbl <- fread('./y_test.txt'))

## Read in testing dataset subject ID
system.time(ts_subj <- read.table('./subject_test.txt', col.names='ID'))

## Combine ID, activities, testing data together
ts <- cbind(ts_subj, ts_lbl, ts)
head(ts[1:5], 10)

##Label activities
ts <- join(ts, Act, by='V1', type='left')
table(ts$V1, ts$activity)

## Check data format
dim(ts)
head(ts[1:5], 10)
head(ts[561:564], 10)

## Assign col name to activity ID
setnames(ts, 2, 'activity_ID')
names(ts)[c(1:5, 561:564)]

#-------------------------------------------------------------

##Combine training and test sets
all <- rbind(tr,ts)

## Order dataset by ID and activity
all <- arrange(all, ID, activity_ID)

##Check data
dim(all)	#10299 * 564
head(all[1:5], 100)

#-------------------------------------------------------------

## Select vars that say mean() and std()
### mean() and std() become mean.., std..
### double backslashes to escape the double periods
meanstd <- all[, grepl('(mean|std)\\.{2}|ID|activity_ID|activity', names(all))]  

##Remove double/triple periods after 'mean', 'std' to make variable names more readable
names(meanstd) <- sub('\\.{2,3}','',names(meanstd))

## Get average of each column by subject and activity
Avg <- aggregate(meanstd[,3:68], by=list(ID = meanstd$ID, activity_ID = meanstd$activity_ID), 
                  FUN=mean, na.rm=TRUE)

dim(Avg) #180 * 68

## Tag activity name
Avg <- merge(Act, Avg, by.x='V1', by.y='activity_ID', all.y=TRUE)
setnames(Avg, 1,'activity_ID')
Avg[1:6, 1:6]

## Write dataset to .txt
write.table(Avg, './Avg.txt', row.name=FALSE)

## Or to write dataset to .csv
##write.csv(meanstd, file = "./write.csv", quote = FALSE) 

##read data back to R: 
##x <- read.table('./Avg.txt', header=TRUE)