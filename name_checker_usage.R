## name_checker_usage.R
## Testing using name_checker.R


## setup ----

## checks if the `here` package is installed, if not, installs 
if(! require(here)){
  install.packages("here")
}

## load libraries
library(here) # load `here` package

## source the script so you can use it
source(here("hackathon-arenas-02", "code", "name_checker.R"))


## check and rename files ----

check_file_names(here('hackathon-arenas-02/files'))

#NOTE: I commented out `return(log)` to prevent a duplicate & less reader-friendly printout


### Test run ###

all_dirs = list.dirs()
log = vector()
for(i in 1:length(all_dirs)){
  cat(paste("Current folder is:",all_dirs[i]), "\n\n")
  log = c(paste("Current folder is:",all_dirs[i]),"")
  log = c(log,check_file_names(all_dirs[i]))
}
write.table(log,"name_checking_log.txt",sep="\n",quote=F,row.names=F,col.names=F)



