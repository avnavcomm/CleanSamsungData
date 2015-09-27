#######################################################################
#
#  run_analysis.R by avnavcom September 25, 2015
#
#  Script used to analyze human activity as monitored by Samsung
#  Galaxy S smartphone.
#
#  Data obtained via
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#  See README.md and CodeBook.md for more information regarding 
#  variables.
#
#  Script assumes it is being run in the "UCI HAR Dataset"
#  directory, created after unzipping the dataset.
#
#######################################################################

run_analysis<-function(){
    ########
    #  
    # Define file names.  Placed upfront so user can see input/output
    # files
    #
    ########
    
    #input
    fn_actTest   <- "test/y_test.txt"
    fn_subTest   <- "test/subject_test.txt"
    fn_datTest   <- "test/X_test.txt"
    fn_actTrain  <- "train/y_train.txt"
    fn_subTrain  <- "train/subject_train.txt"
    fn_datTrain  <- "train/X_train.txt"
    fn_features  <- "features.txt"
    fn_actLabels <- "activity_labels.txt"
    
    #output
    fn_cleanedData <- "UCI_HAR_Dataset_Cleaned.txt"
    
    #######
    #
    # Read in the test and training datasets. Also read in the 
    # "features" files, which contains the variable names for the  
    # measurement types and the numerical value for the columns in the 
    # test and training datasets. Update the column names for the test 
    # and training sets.
    #
    #######

    datTest  <- read.table(fn_datTest)
    datTrain <- read.table(fn_datTrain)
    features <- read.table(fn_features)
    
    names(features) <- c("key","label")
    names(datTest)  <- features$label
    names(datTrain) <- features$label
    
    #######
    #
    # Select the means and the stds for each data set, and then merge
    # the training and test datasets. Ensure the means and stds of 
    # same measuremement are close, i.e., 
    # 
    #  X.mean Y.mean Z.mean X.std Y.std. Z.std S.mean T.mean U.mean ...
    #
    # Free unneeded objects. 
    #
    #######
    
    flags <- as.logical ( grepl("mean()",names(datTest), fixed=TRUE) + grepl("std",names(datTest),fixed=TRUE) )
    datTestSmall  <- datTest[,flags]
    datTrainSmall <- datTrain[,flags]
    
    rm(datTest,datTrain)
    
    datAllSmall <- rbind(datTestSmall,datTrainSmall)
    
    rm(datTestSmall,datTrainSmall)
    
    #######
    #
    # Clean up the column names getting rid of "()" and putting the
    # "mean" or "std" after the main observation type. So, 
    #  foo.X.mean instead of foo.mean().X
    #
    #######
    
    names(datAllSmall)<-gsub("-",".",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("mean().X","X.mean",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("mean().Y","Y.mean",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("mean().Z","Z.mean",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("std().X","X.std",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("std().Y","Y.std",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("std().Z","Z.std",names(datAllSmall),fixed=TRUE)
    names(datAllSmall)<-gsub("()","",names(datAllSmall),fixed=TRUE)

    #######
    #
    # Now read in activity and subject lists for the test and training
    # sets.  First merge the subject and activity lists by columns for
    # training and test sets, and then merge the resulting training
    # and test sets to create a data frame that has the subject and
    # activity information for each observation in datAllSmall. 
    #
    ########

    # read in activity and subject lists
    
    actTest   <- read.table(fn_actTest,  col.names="activity",stringsAsFactors=FALSE)
    actTrain  <- read.table(fn_actTrain, col.names="activity",stringsAsFactors=FALSE)
    subTest   <- read.table(fn_subTest,  col.names="subject",stringsAsFactors=FALSE)
    subTrain  <- read.table(fn_subTrain, col.names="subject",stringsAsFactors=FALSE)
    
    # index maps
    
    idxMapTest   <- cbind(subTest,actTest)
    idxMapTrain  <- cbind(subTrain,actTrain)
    idxMapAll   <- rbind(idxMapTest,idxMapTrain)
    
    rm(idxMapTest,idxMapTrain)
    
    # read in map between activity name and its numerical value given in idxMapAll
    
    actLabels <- read.table(fn_actLabels,col.names=c("key","label"),stringsAsFactors=FALSE)
    
    # short loop to replace each activity key (integer) with its appropriate label
    
    for(x in min(actLabels$key):max(actLabels$key)){
        idxMapAll$activity<-replace(idxMapAll$activity,idxMapAll$activity==x,actLabels$label[x])
    }
    
    # helper function for adding a column to the data frame and renaming it
    
    addCol <- function(frame,col,name){
        frame<-cbind(col,frame,stringsAsFactors=FALSE)
        lnames<-names(frame)
        lnames[1]<-name
        names(frame)<-lnames
        frame
    }
    
    # add the activity and subject columns to the datAllSmall data frame

    datAllSmall<-addCol(datAllSmall,idxMapAll$activity,name="activity")
    datAllSmall<-addCol(datAllSmall,idxMapAll$subject,name="subject")

    #######
    #
    # melt the data frame using the subject and activities as the ids 
    # and all other columns as the measurement variables. For each
    # activity, then cast a data frame from the melt, using the
    # mean values for each corresponding subject for all measurement
    # types. The activity then needs to be added back to the the data
    # frame for making a tall, clean dataset.
    #
    #######
    
    library(reshape2)
    
    names<-names(datAllSmall)
    datMelt<-melt(datAllSmall,id=names[1:2],measure.vars=names[ 3:length(names)])
    
    # helper function for lapply. 
    
    castByFlag<-function(activity,molten=datMelt){
        flags<-molten$activity==activity
        casted<-dcast(molten[flags,],subject~variable,mean)
        casted<-cbind(activity,casted,stringsAsFactors=FALSE)
        casted
    }
    
    # get list of data frames, where each list member is an activity
    
    castList<-lapply(actLabels$label,castByFlag)
    
    ######
    #
    # combine the list into one tall, clean data frame.
    # could be done with the following code:
    #    datTall<-castList[[1]]
    #    for(d in 2:length(castList)){datTall<-rbind(datTall,castList[[d]])}
    #
    # but maybe the plyr::join_all is clearer?
    #
    # If the plyr package is availabel (and for some reason you wish 
    # not to download it), comment out lines 191 and 192 and uncomment 
    # lines 180 and 181. 
    #
    #######
    
    library(plyr)
    datTall <- join_all(castList,type="full")
    
    # write a tall, clean dataset.
    
    write.table(datTall,file=fn_cleanedData,row.names=FALSE)

}