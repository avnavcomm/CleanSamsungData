# CodeBook
CodeBook for cleaned data derived from "Human Activity Recognition Using Smartphones Dataset Version 1.0" as produced by run_analysis() in run_analysis.R. 

The output table has 68 columns and 180 rows. For each variable, there is one
measurement for each of the 30 subjects for each of the six activities (giving
180 rows).  For example

*WALKING           1     V1   V2 ...
*WALKING           2     V1   V2 ...
*  ...
*WALKING          30     V1   V2 ...
*WALKING_UPSTAIRS  1     V1   V2 ...
*WALKING_UPSTAIRS  2     V1   V2 ...
*  ...
*WALKING_UPSTAIRS 30     V1   V2 ...`

## Column Names

The below is the list of column names for the table, with a brief description where necessary.  All 
names that end with ".mean" represent average values, while ".std" represent the standard deviation for 
that average (as described in the README.md, these are actually the average of the averages and the
average of the std for each subject). 

Nomenclature:
* Names that begin with "t", such as tBodyAcc.X.mean, are measurements in the time domain, and "f" in the frequency domain.
* The measurements represent either linear acceleration (denoted with an "Acc"), angular velocity ("Gyro"), or the time derivative of those quantities (represented with the term "Jerk", e.g., AccJerk or GyroJerk).  
* The measurements are divided into body and gravity components, given by "Body" or "Gravity", respectively. 
* All acclelerations ("Acc") are given in standard gravity units *g*, and they gryo measurements are in radian/sec. 
* As such, jerks are given in units of g/sec or radian/sec/sec.
* The accelerometer and gyroscope gave triaxial information, so measurements
* are either labeled, X, Y, Z, or Mag for the X direction, Y direction, Z direction, or the magnitude (respectively) of the vector quantity. 


1. activity
  * Gives one of the six activity names.  All activities are grouped together, so this value will repeat 30 times (once for each subject).
    Activity names are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
2. subject
  * Number corresponding to the volunteer (subject) from which the data are taken. There are 30 subjects, repeating for each activity.
3. tBodyAcc.X.mean
4. tBodyAcc.Y.mean
5. tBodyAcc.Z.mean
6. tBodyAcc.X.std
7. tBodyAcc.Y.std
8. tBodyAcc.Z.std
9. tGravityAcc.X.mean
10. tGravityAcc.Y.mean
11. tGravityAcc.Z.mean
12. tGravityAcc.X.std
13. tGravityAcc.Y.std
14. tGravityAcc.Z.std
15. tBodyAccJerk.X.mean
16. tBodyAccJerk.Y.mean
17. tBodyAccJerk.Z.mean
18. tBodyAccJerk.X.std
19. tBodyAccJerk.Y.std
20. tBodyAccJerk.Z.std
21. tBodyGyro.X.mean
22. tBodyGyro.Y.mean
23. tBodyGyro.Z.mean
24. tBodyGyro.X.std
25. tBodyGyro.Y.std
26. tBodyGyro.Z.std
27. tBodyGyroJerk.X.mean
28. tBodyGyroJerk.Y.mean
29. tBodyGyroJerk.Z.mean
30. tBodyGyroJerk.X.std
31. tBodyGyroJerk.Y.std
32. tBodyGyroJerk.Z.std
33. tBodyAccMag.mean
34. tBodyAccMag.std
35. tGravityAccMag.mean
36. tGravityAccMag.std
37. tBodyAccJerkMag.mean
38. tBodyAccJerkMag.std
39. tBodyGyroMag.mean
40. tBodyGyroMag.std
41. tBodyGyroJerkMag.mean
42. tBodyGyroJerkMag.std
43. fBodyAcc.X.mean
44. fBodyAcc.Y.mean
45. fBodyAcc.Z.mean
46. fBodyAcc.X.std
47. fBodyAcc.Y.std
48. fBodyAcc.Z.std
49. fBodyAccJerk.X.mean
50. fBodyAccJerk.Y.mean
51. fBodyAccJerk.Z.mean
52. fBodyAccJerk.X.std
53. fBodyAccJerk.Y.std
54. fBodyAccJerk.Z.std
55. fBodyGyro.X.mean
56. fBodyGyro.Y.mean
57. fBodyGyro.Z.mean
58. fBodyGyro.X.std
59. fBodyGyro.Y.std
60. fBodyGyro.Z.std
61. fBodyAccMag.mean
62. fBodyAccMag.std
63. fBodyBodyAccJerkMag.mean
64. fBodyBodyAccJerkMag.std
65. fBodyBodyGyroMag.mean
66. fBodyBodyGyroMag.std
67. fBodyBodyGyroJerkMag.mean
68. fBodyBodyGyroJerkMag.std

