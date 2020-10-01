## pipeline_test.R
## Establishing a pipeline for file checking and moving for the Arenas Lab


## setup ----
library(here) # install.packages("here")
code_path <- "arenas-03/arenasImageSorter/R" 
log_path <- "arenas-03/logs"

source(here(code_path, "name_checker.R"))
source(here(code_path, "file_mover.R"))
source(here(code_path, "file_anonymizer.R"))

### Test run ###

## Create a "logs" folder if it doesn't already exist
if (!dir.exists(here(log_path))) dir.create(here(log_path))

## run name_checker() and save log file
log = name_checker("files",print2screen=FALSE)
write.table(log, here(log_path, "name_checking_log.txt"), 
            sep="\n",quote=F,row.names=F,col.names=F)

## run file_mover() and save log file
log = file_mover("files","moved")
warnings()
write.table(log, here(log_path, "file_moving_log.txt"), 
            sep="\n",quote=F,row.names=F,col.names=F)

## run filemover(), anonymize files, and save log file
log = file_mover("files","anonymized",anonymize=TRUE)
warnings()
write.table(log,here(log_path, "file_moving_anonymized_log.txt"),
            sep="\n",quote=F,row.names=F,col.names=F)

