library(dplyr)

assignment <- function() {
        d <- runAnalysis()
        t <- tinyset( d )
        
        list(first_set=d,second_set=t)
}

runAnalysis <- function() {
        wd <- "~/Documents/coursera/getting-and-cleaning-data/week4/"
        setwd(wd)
        
        file <- "UCI_HAR_Dataset.zip"
        if( !file.exists(file) ) {
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file( url, destfile = file)
                unzip( file )
        }
        
        # Go in sub-directory
        setwd(paste(wd,"/UCI HAR Dataset/",collapse="",sep=""))
        
        # Read activities/features files and name columns
        activities <- read.table("activity_labels.txt") %>%
                        rename( activity_id=V1, activity_name=V2 )
                        
        features <- read.table("features.txt") %>%
                        rename( feature_id=V1, feature_name=V2 )
        
        # Read test files
        subject_test <- read.table("test/subject_test.txt")
        y_test <- read.table("test/Y_test.txt")
        x_test <- read.table("test/X_test.txt")
        names(x_test) <- make.names( features$feature_name, unique=TRUE )
        x_test <- x_test %>%
                  mutate( subject = subject_test$V1,
                  activity_id = y_test$V1 ) %>%
                  left_join( activities ) %>%
                  select( subject, activity_name, contains("mean"), contains("std") )
        
        # Train files
        subject_train <- read.table("train/subject_train.txt")
        y_train <- read.table('train/Y_train.txt')
        x_train <- read.table("train/X_train.txt")
        names(x_train) <- make.names( features$feature_name, unique=TRUE )
        x_train <- x_train %>%
                   mutate( subject = subject_train$V1,
                           activity_id = y_train$V1 ) %>%
                   left_join( activities ) %>%
                   select( subject, activity_name, contains("mean"), contains("std") )

        # Merge both set together
        data <- rbind( x_test, x_train ) %>%
                mutate( subject=factor(subject),
                        activity_name=factor(activity_name) ) %>%
                arrange( subject, activity_name )
        
        # Return it
        data
}

tidyset <- function( set ) {
        tidyset <- set %>%
                        group_by( subject, activity_name ) %>%
                        summarize_each( funs(mean) )
        
        tidyset
}