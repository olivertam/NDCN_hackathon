#!/bin/env R

## Batch Rename Files. 
## Original script by Oliver Tam tam@cshl.edu, June 2020

## This function will check that the files are named according
## to the convention outlined by the Arenas lab

check_file_names <- function(folder){
  
    ## Identify files to be checked ----
    files <- setdiff(list.files(folder, full.names = TRUE), list.dirs(recursive = FALSE))
    if(length(files) < 1){
        return()
    }
    files <- setdiff(files, "./name_checker.R")
    files <- setdiff(files, "./name_checking_log.txt")

    ## Setting up log file ----
    today <- Sys.time()
    log = c(paste0("Filenames checked on ", 
            format(today,format="%d %B, %Y"), " at ", 
            format(today, format="%I:%M %p"), "."),"")
    cat(log, "\n")

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
        extension <- tools::file_ext(files[i])
        output = paste("Current file:",name)
        output = c(output,"")
        file_info = unlist(strsplit(name, "_",fixed=TRUE))
        if(length(file_info) != 5){
            output = paste("The file name does not fit the expected nomenclature. Please check the output to see where the mistake could be")
        }
        output = c(output,paste("Condition & replicate:",file_info[1]))

        output = c(output,"Dye/antibody/transcript:")
        
        validateAntibody <- function(label){

            ## Capitalize the first letter, and make other letters lowercase
            firstCaps <- function(string){
                string = tolower(string) 
                newString = paste0(toupper(substring(string,1,1)),substring(string,2),collapse=" ")
                return(newString)
            }
            
            antibodies = unlist(strsplit(label,"-",fixed=TRUE))
            for(i in 1:length(antibodies)){
                species = substr(antibodies[i],1,2) # Assume first two letters are species-related
                species = tolower(species) # Keep all species lower case for consistency
                target = substr(antibodies[i],3,nchar(antibodies[i]))
                target = toupper(target)
              # target = firstCaps(target) # Both options available
                antibodies[i] = paste0(species,target)
            }
            checkedLabel = paste(antibodies, collapse = "-")
            return(checkedLabel)
        }
        
        labels = unlist(strsplit(file_info[2], "+", fixed=TRUE))
        for(i in 1:length(labels)){
            if(grepl("-",labels[i])){
                labels[i] = validateAntibody(labels[i])
            }
            output = c(output,paste0("    ",labels[i]))
        }
        file_info[2] = paste(labels,collapse="+")
        output = c(output,paste("Capture date:",file_info[3]))
        date.format = "%y%m%d"
        if(is.na(as.Date(file_info[3],date.format))){
            output = c(output,paste("    Date is not in the expected YYMMDD format"))
        }

        output = c(output,paste("Microscope type:",file_info[4]))

        lens = unlist(strsplit(file_info[5], "X",fixed=TRUE))
        if(length(lens) < 2){
            lens = unlist(strsplit(file_info[5], "x",fixed=TRUE))
        }
        # The lens information should be in the first element of the lens vector
        if(length(lens) < 2){
            output = c(output,paste("Cannot find lens information from", file_info[5]))
        }else{
            output = c(output,paste0("Lens: ",lens[1],"X"))
        }
        if(length(lens) < 2){
            zoom = unlist(strsplit(file_info[5],"-",fixed=TRUE))
        }else{
            zoom = unlist(strsplit(lens[2],"-",fixed=TRUE))
        }
        if(length(zoom) < 2){
            output = c(output,paste("Cannot find zoom and picture information from", file_info[5]))
        }else{
            zoom[1] = tolower(zoom[1])
            zoom[1] = sub("z", "",zoom[1])
            output = c(output,paste("Zoom level:",zoom[1]))
            output = c(output,paste("Picture #:",zoom[2]))
            file_info[5] = paste0(lens[1],"X","z",zoom[1],"-",zoom[2])
        }
        output = c(output,"")
        clean_name = paste(file_info,collapse="_")
        if(name != clean_name){
            output = c(output,paste("Current name:",name))
            output = c(output,paste("Updated name:",clean_name))
        }
        output = c(output,"")
        return(output)
    }
    
    ## Iterate through each file found and extract the information ----
    for(i in 1:length(files)){   # i = 1
        current_file = gsub("./", "", files[i]) # Might need to check with Windows
        current_file = sanitize(current_file)
        results = extract_information(current_file)
        screenOutput = paste(results,collapse="\n")
        cat(screenOutput, "\n")
        # confirmResults()  ### Not usable on RMarkdown, but might be a good thing for production code
        log = c(log,results,"")
    }

    ## User input required to confirm results ----
    # confirmResults <- function(){
    #    answer <- readline(prompt = "Is this correct? (y/n): ")
    #    if(answer != "y" & answer != "Y"){
    #        stop(paste("There might be an error in the file name"), call. = FALSE)
    #    }
    # }
    
    ## Return the log output with ----
    return(log)
}

### Test run ###

all_dirs = list.dirs()
for(i in 1:length(all_dirs)){
    cat(paste("Current folder is:",all_dirs[i]), "\n")
    check_file_names(all_dirs[i])
}

