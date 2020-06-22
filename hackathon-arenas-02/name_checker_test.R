## name_checker_usage.R
## Testing using name_checker.R


## setup ----

source("code/name_checker.R")

### Test run ###

all_dirs = list.dirs()
log = vector()
for(i in 1:length(all_dirs)){
    cat(paste("Now checking folder:",all_dirs[i]), "\n\n")
    results = check_file_names(all_dirs[i])
    if(length(results) > 0){
        log = c(log,paste("Current folder is:",all_dirs[i]),"")
        log = c(log,results)
    }
}
write.table(log,"name_checking_log.txt",sep="\n",quote=F,row.names=F,col.names=F)



