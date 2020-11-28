README
=======

The code is in the script called run_analysis.R which does the following tasks:

- Downloads the dataset from [here](<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>)

- Selects the variables with mean and standard deviation of the measurements

- Produces a tidy dataset called tidy.dat containing the average value of each variable by subject and activity type

- Each row of tidy.dat contains the average values of each of the variables for a given subject and activity type.

- Each column in tidy.dat is a variable listed in codebook.dat