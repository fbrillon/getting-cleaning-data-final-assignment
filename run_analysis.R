library(dplyr)

set_working_directory <- function() {
        wd <- "~/Documents/coursera/getting-and-cleaning-data/week4/"
        setwd(wd)
}

assignment <- function() {
        d <- runAnalysis()
        t <- tidyset( d )
        
        l <- list(first_set=d,second_set=t)
        
        l
}

runAnalysis <- function() {
        file <- "UCI_HAR_Dataset.zip"
        if( !file.exists(file) ) {
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file( url, destfile = file)
                unzip( file )
        }
        
        # Go in sub-directory
        oldwd <- getwd()
        setwd(paste(getwd(),"/UCI HAR Dataset/",collapse="",sep=""))
        
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
        
        # Set back wd
        setwd(oldwd)
        
        # Return it
        data
}

tidyset <- function( set ) {
        tidyset <- set %>%
                        group_by( subject, activity_name ) %>%
                        summarize_each( funs(mean) )
        
        tidyset
}