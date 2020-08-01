# smartphone-data-processing

Jerry Lakin
7/30/20

The R script in this repository creates a tidy dataset from the UC Irvine Human Activity Recognition Using Smartphones Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The repository also includes the txt file published by the script. The script can be run on any computer as long as the UCI HAR dataset is in the working directory. 

The script first pulls in the movement variables, subject ids and activity ids for both the training and test data as well as the feature names and activity reference table from separate files in the repository. The training and test data are combined. The features are used to name the movement columns and the activity reference table is used to generate activity names. All movement columns are dropped except for mean and standard deviation measurements. Subject and activity data are appended to the movement data. The resulting dataset is then aggregated and average variable values are recorded for each subject and activity combination. After giving the columns descriptive names, the script finally exports the summary table. 
