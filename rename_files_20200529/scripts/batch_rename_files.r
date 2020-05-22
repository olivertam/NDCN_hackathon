#!/bin/env R

## Note: Only works on Mac or Unix/Linux systems. System calls need to be changed for Windows/DOS systems.
## It currently handles up to 999 files.

rename_files <- function(microscope,antibody,picture_date,lens_magnification){
    
    confirmParameter <- function(param_name, parameter){
        cat("\nValue provided for ",param_name, ": ",parameter,"\n",sep="")
        answer <- readline(prompt="Is this correct? (y/n): ")
        if(answer != "y" & answer != "Y"){
            stop(paste("Wrong",param_name,"provided"),call.=FALSE)
        }
    }

    # Adapted from path_sanitize() from fs R package
    sanitize <- function(file_name,replacement=""){
        illegal <- "[/\\?<>\\:*|\":]"
        control <- "[[:cntrl:]]"
        reserved <- "^[.]+$"
        whitespace <- "[[:space:]]"
#        windows_reserved <- "^(con|prn|aux|nul|com[0-9]|lpt[0-9])([.].*)?$"
#        windows_trailing <- "[. ]+$"
        file_name <- gsub(illegal,replacement,file_name)
        file_name <- gsub(control,replacement,file_name)
        file_name <- gsub(reserved,replacement,file_name)
        file_name <- gsub(whitespace,replacement,file_name)
        return(file_name)
    }

    suppressMessages(library("tools"))
    
    if(missing(microscope)){
        message("Usage: rename_files(microscope,antibody,picture_date,lens_magnification)")
        stop(paste("Microscope not provided"),call.=FALSE)
    }
    if(missing(antibody)){
        message("Usage: rename_files(microscope,antibody,picture_date,lens_magnification)")
        stop(paste("Antibody not provided"),call.=FALSE)
    }
    if(missing(picture_date)){
        message("Usage: rename_files(microscope,antibody,picture_date,lens_magnification)")
        stop(paste("Picture date not provided"),call.=FALSE)
    }
    if(missing(lens_magnification)){
        message("Usage: rename_files(microscope,antibody,picture_date,lens_magnification)")
        stop(paste("Lens magnification not provided"),call.=FALSE)
    }

    confirmParameter("microscope",microscope)
    confirmParameter("antibody",antibody)
    confirmParameter("picture date",picture_date)
    confirmParameter("lens magnification",lens_magnification)
    log <- c("Parameters provided:",paste("- Microscope:",microscope),paste("- Antibody:",antibody),paste("- Picture date:",picture_date),paste("- Lens magnification:",lens_magnification),"Please note that any illegal characters or white spaces will be removed from file names","")
    
    prefix <- paste(microscope,antibody,picture_date,lens_magnification,sep="_")
    prefix <- sanitize(prefix)

    today <- Sys.time()
    log <- c(log,paste0("Files renamed on ",format(today,format="%d %B, %Y")," at ",format(today,format="%I:%M %p"),":"))

    
    files <- setdiff(list.files(".",full.names=TRUE),list.dirs(recursive=FALSE,full.names=TRUE))
    files <- setdiff(files,"./batch_rename_files.r")
    counter <- sprintf("%03d",1:length(files))
    dir.create("Converted",showWarnings=FALSE)
    for(i in 1:length(files)){
        oldfile <- gsub("./","",files[i])
        extension <- file_ext(files[i])
        newfile = paste0(prefix,"-",counter[i],".",extension)
        output <- paste0("Converted/",newfile)
        cmd <- paste("cp",files[i],output)
        system(cmd)
        log = c(log,paste(oldfile,"renamed to",newfile))
    }
    write(log,file="Converted/renaming_log.txt",sep="\n")
}

