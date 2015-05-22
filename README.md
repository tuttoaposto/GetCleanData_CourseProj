#README for run_analysis.R

This program summarizes human activity measurements collected by Samsung Galaxy S smartphone	
obtained [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The following steps describe what this script does:	

1. Read in training and test data txt files into R

2. Read in activity labels and measurement variable names into R

3. Attach subject ID to training and test datasets

4. Label measurement variables (561 in total) per each dataset

5. Label each activity:		
   1. WALKING	
   2. WALKING_UPSTAIRS		
   3. WALKING_DOWNSTAIRS			
   4. SITTING	
   
5. STANDING		
   6. LAYING		

	
6. Combine training and test datasets into one (30 subjects in total)

7. Extract just the measurement variables that are the mean and standard deviation of the measurements

8. Remove double/triple periods after 'mean', 'std' in variable names to make them more readable

9. Summarize the extracted dataset in step 6 with mean by subject and activity 
   (180 rows and 69 columns in total including activity labels)

10. Output the summarized dataset in step 7 to Avg.txt 
	
### For description of each variable in Avg.txt, refer to CodeBook.md


Citation Request:		

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.