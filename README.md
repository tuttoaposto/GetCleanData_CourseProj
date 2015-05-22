#README for run_analysis.R

This program summarizes human activity measurements collected by Samsung Galaxy S smartphone	
obtained ([here]) (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)	

The following steps describe what this script does:	

1. Read in training and test data txt files into R

2. Read in activity labels and measurement variable names into R

3. Attach subject ID to training and test datasets

4. Label measurement variables (561 in total) per each dataset

5. Label each activity:
   i. WALKING, ii. WALKING_UPSTAIRS, iii. WALKING_DOWNSTAIRS, 
iv. SITTING, 
v. STANDING, vi. LAYING		

	
6. Combine training and test datasets into one (30 subjects in total)

7. Extract just the measurement variables that are the mean and standard deviation of the measurements

8. Summarize the extracted dataset in step 6 with mean by subject and activity 
   (180 rows and 69 columns in total including activity labels)

9. Output the summarized dataset in step 7 to Avg.txt 
	
### For description of each variable in Avg.txt, refer to CodeBook.md