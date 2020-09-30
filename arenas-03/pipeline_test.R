## name_checker_usage.R
## Testing using name_checker.R


## setup ----

source("arenasImageSorter/R/name_checker.R")
source("arenasImageSorter/R/file_mover.R")
source("arenasImageSorter/R/file_anonymizer.R")

### Test run ###

dir.create("logs")

log = name_checker("files",print2screen=FALSE)
write.table(log,"logs/name_checking_log.txt",sep="\n",quote=F,row.names=F,col.names=F)

log = file_mover("files","moved")
warnings()
write.table(log,"logs/file_moving_log.txt",sep="\n",quote=F,row.names=F,col.names=F)

log = file_mover("files","anonymized",anonymize=TRUE)
warnings()
write.table(log,"logs/file_moving_anonymized_log.txt",sep="\n",quote=F,row.names=F,col.names=F)




