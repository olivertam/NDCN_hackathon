#!/bin/env R

## Batch Rename Files. 
## Original script by Oliver Tam tam@cshl.edu, June 2020

## This function will check that the files are named according
## to the convention outlined by the Arenas lab

check_file_names <- function(){
  
    ## Identify files to be checked ----
    files <- setdiff(list.files(".", full.names = TRUE), list.dirs(recursive = FALSE, full.names = TRUE))
    files <- setdiff(files, "./name_checker.R")
    files <- setdiff(files, "./name_checking_log.txt")

    ## Setting up log file ----
    today <- Sys.time()
    log = c(paste0("Filenames checked on ", 
            format(today,format="%d %B, %Y"), " at ", 
            format(today, format="%I:%M %p"), "."),"")

    ## Iterate through each file found and extract the information ----
    for(i in 1:length(files)){   # i = 1
        current_file = gsub("./", "", files[i])
        current_file = sanitize(current_file)
        results = extract_information(current_file)
        print(results)
        # confirmResults()  ### Not usable on RMarkdown, but might be a good thing for production code
        log = c(log,results,"")
    }
        
    ## Clean up illegal characters ----
    ## adapted from `path_sanitize()` from `fs` package https://fs.r-lib.org
    sanitize <- function(file_name, replacement = ""){
        illegal <- "[/\\?<>\\:*|\":]"
        control <- "[[:cntrl:]]"
        reserved <- "^[.]+$"
        whitespace <- "[[:space:]]"
        windows_reserved <- "^(con|prn|aux|nul|com[0-9]|lpt[0-9])([.].*)?$"
        windows_trailing <- "[. ]+$"
        file_name <- gsub(illegal, replacement, file_name)
        file_name <- gsub(control, replacement, file_name)
        file_name <- gsub(reserved, replacement, file_name)
        file_name <- gsub(whitespace, replacement, file_name)
        return(file_name)
    }

    ## Extract the information from the file name, and return it ----
    extract_information <- function(name){
        name = tools::file_path_sans_ext(name)
        file_info = unlist(strsplit(name, "_"))
        output = paste("Current File: ",name)
### Based on position in the file_info vector, add info to output
### Potentially add folder information
        return(output)
    }

    ## Capitalize the first letter, and make other letters lowercase ----
    firstCaps <- function(string){
        string = tolower(string) 
        newString = paste0(toupper(substring(string,1,1)),substring(string,2),collapse=" ")
        return(newString)
    }

    ## User input required to confirm results ----
    # confirmResults <- function(){
    #    answer <- readline(prompt = "Is this correct? (y/n): ")
    #    if(answer != "y" & answer != "Y"){
    #        stop(paste("There might be an error in the file name"), call. = FALSE)
    #    }
    # }
    
    ## Write information in the log file ----
    write(log, file="name_checking_log.txt", sep="\n")
}


