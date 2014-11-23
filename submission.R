#####################
# Read testing data #
#####################
testing_submission <- read.csv("data/pml-testing.csv")


#################################
# Transform it to fit the model #
#################################

# Remove NAs
testing_submission_1 <- testing_submission[,-na_values$na_var_id]

# Remove NA factor variables
testing_submission_2 <- testing_submission_1[,-na_factor_values$na_factor_var_id]

# Remove unncessary other variables
testing_submission_final <- testing_submission_2[,-c(1:7)]

##############
# Prediction #
##############

# 52 variables model
answers <- predict(rf_cv_fit, testing_submission_final)
answers <- as.character(answers)

# 7 variables model
testing_submission_7 <- testing_submission_final[,c(var_7_imp)]
answers_7 <- predict(rf_7_cv_fit, testing_submission_7)
answers_7 <- as.character(answers_7)


##############
# Submission #
##############

# you can load this function by copying and pasting it into R:
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}

# then create a folder where you want the files to be written. Set that to be your working directory and run:
pml_write_files(answers)