#!/bin/env R

## Name checker. 
## Original script by Oliver Tam tam@cshl.edu, June 2020

## This function will check that the files are named according
## to the convention outlined by the Arenas lab

######## Expected Nomenclature ########
##
## Seven (7) sections separated by underscores ("_")
##
## Section 1: Experimental name and researcher initials
##       e.g. NES-SAI2d15-CS
## Section 2: Experiment date and experiment number
##       e.g. 200514-01
## Section 3: Condition and replicate number
##       e.g. Vehicle-1
## Section 4: Dye, antibodies or transcript
##       Different reagents are separated by pluses ("+")
##       Primary and secondary antibodies are linked by dashes ("-")
##           Two letter code for the animal species generating the antibody
##           E.g. rbAldh1-dk555
##                -> rabbit anti-Aldh1 (primary) with
##                   donkey Alexa Fluor 555 (secondary)
##       Full example: DAPI+goPitx3-dk488+rbAldh1-dk555+moTh-dk647
## Section 5: Microscope type
##       e.g. CF
## Section 6: Lens, zoom and image number
##       e.g. 10Xz1-1
##
## Example file name:
##       NES-SAI2d15-CS_200514-01_Vehicle-1_DAPI+goPitx3-dk488+rbAldh1-dk555+moTh-dk647_CF_10Xz1-1.tiff
##
########################################


## Subroutine to remove characters that cannot be in file names ##
## Adapted from `path_sanitize()` from `fs` package https://fs.r-lib.org
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

## Subroutine to capitalize the first letter, and make other letters lowercase ##
firstCaps <- function(string){
    string = tolower(string) 
    newString = paste0(toupper(substring(string,1,1)),substring(string,2),collapse=" ")
    return(newString)
}

## Main subroutine for checking that file names match the expected nomenclature
check_file_names <- function(folder){ 

    ## Subroutine to check antibody nomenclature
    validateAntibody <- function(label){
        antibodies = unlist(strsplit(label,"-",fixed=TRUE))
        ### Improvement: Might need to check for cases where there are dashes where there shouldn't be
        for(i in 1:length(antibodies)){
            ## Assumption: the first two letters are species-related, and make them lowercase for consistency
            ### Caveat: This is a very bad assumption as there's no way for this code to confirm if it is incorrect.
            ### The only way to know is when they read through the log files and notice something weird.
            ### Improvement: Check against a known list of species
            species = substr(antibodies[i],1,2)
            species = tolower(species)
            
            target = substr(antibodies[i],3,nchar(antibodies[i]))
            target = toupper(target)
          # target = firstCaps(target) # Both options available
            antibodies[i] = paste0(species,target)
        }
        checkedLabel = paste(antibodies, collapse = "-")
        return(checkedLabel)
    }

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

    ## Subroutine to extract the information from file name, and return it ----
    extract_information <- function(name){
        name = tools::file_path_sans_ext(name)
        extension <- tools::file_ext(files[i])
        output = "####"
        output = c(output,paste("Current file:",name))
        output = c(output,"")

        ## Based on the nomenclature, there should be 7 fields separated by underscore
        ## If it doesn't find the 7 fields, then it will return with an error message
        file_info = unlist(strsplit(name, "_",fixed=TRUE))
        if(length(file_info) != 7){
            output = c(output,"The file name does not fit the expected nomenclature.")
            output = c(output,"Expected sections:","  Experiment name & initial","  Experiment date and number","  Condition & replicate","  Dye/antibodies/transcript","  Image capture date","  Microscope type","  Lens, zoom & image number","")
            if(length(file_info) < 7){
                output = c(output,paste("It may be missing sections, as it only found",length(file_info)))
            }else{
                output = c(output,paste("It may have too many sections, as it found",length(file_info)))
            }
            output = c(output,paste0("  ",file_info))
            output = c(output,"Please double-check.")
            output = c(output,"")
            return(output)
        }

        ## Getting information about the folder where the file should go to
        ## This is a "relative" file path
        ### Improvement: generate an "absolute" file path based on the central storage site/server
        output = c(output,paste("Destination folder:",file.path(file_info[1],file_info[2])))

        ## Getting the condition and replicate information.
        ## Assumption: the replicate number is after the last dash
        field = unlist(strsplit(file_info[3], "-",fixed=TRUE))
        output = c(output,paste("Condition:",paste(head(field,n=-1),sep="-")))
        output = c(output,paste("Replicate:",tail(field,n=1)))
        
        ## Getting the dye, antibody or transcript information.        
        output = c(output,"Dye/antibody/transcript:")      
        field = unlist(strsplit(file_info[4], "+", fixed=TRUE))

        ## Assumption: each antibody label is a pair of antibodies separated by a dash. If a dash is not present, assume that it's a dye or transcript
        ### Caveat: if the dye or transcript has a dash, it would break this! May have to find way to account for this.
        ### Use another delimiter (like an equal sign or a hashtag)?
        for(i in 1:length(field)){
            if(grepl("-",field[i])){
                field[i] = validateAntibody(field[i])
            }
            output = c(output,paste0("    ",field[i]))
        }
        file_info[4] = paste(field,collapse="+")

        ## Getting the date of image capture
        output = c(output,paste("Capture date:",file_info[5]))
        date.format = "%y%m%d"
        ## This just checks that the values are compatible with it being a date, but does not ensure cases where months, days (and even last two year digits) are interchangeable.
        if(is.na(as.Date(file_info[5],date.format))){
            output = c(output,paste("    Date is not in the expected YYMMDD format"))
        }

        ## Getting the microscope type
        ### Improvement: have a list of acceptable terms to check against
        output = c(output,paste("Microscope type:",file_info[6]))

        ## Getting the lens, zoom and image number
        ## Assumption: it is in the format of 10Xz1-1 or 10X-z1-1
        ## Make final format as 10X-z1-1 (could be changed)
        field = unlist(strsplit(tolower(file_info[7]),"-",fixed=TRUE))
        if(length(field) < 3){
            lens = unlist(strsplit(field[1], "x",fixed=TRUE))
            if(length(lens) < 2){
                output = c(output,paste("Cannot find process lens or zoom information from", file_info[7]))
            }else{
                output = c(output,paste0("Lens: ",lens[1],"X"))
                lens[2] = sub("z","",lens[2])
                output = c(output,paste("Zoom level:",lens[2]))
                output = c(output,paste("Picture #:", field[-1]))
                file_info[7] = paste0(lens[1],"X-z",lens[2],"-",field[-1])
            }
        }else{
            output = c(output,paste0("Lens: ",toupper(field[1])))
            field[2] = sub("z","",field[2])
            output = c(output,paste0("Zoom level: ",tolower(field[2])))
            output = c(output,paste("Picture #:", field[-1]))
            file_info[7] = paste0(toupper(field[1]),"-","z",field[2],"-",field[3])
        }        
        output = c(output,"")

        ## Generate a "cleaned" name after read it through, and check against actual name. If different, print a message indicating as such
        ### Idea: rename the file to the "cleaned" name
        clean_name = paste(file_info,collapse="_")
        if(name != clean_name){
            output = c(output,paste("The current name does not fit the nomenclature exactly.\nPlease consider changing it."))
            output = c(output,paste("Current name:",name))
            output = c(output,paste("Updated name:",clean_name))
        }else{
            output = c(output,"Name is perfectly consistent with nomenclature")
        }
        output = c(output,"")
        return(output)
    }
    
    ## Iterate through each file found and extract the information ----
    for(i in 1:length(files)){   # i = 1
        ## Following line might not be fully compatible with Windows
        current_file = gsub("./", "", files[i]) 
        current_file = sanitize(current_file)
        results = extract_information(current_file)

        ## Print results to screen
        screenOutput = paste(results,collapse="\n")
        cat(screenOutput, "\n")
#        confirmResults()

        ## Store the results in the log file
        log = c(log,results,"")
    }

    ## User input required to confirm results ----
    ## Not usable on RMarkdown, but might be a good thing for production code
    # confirmResults <- function(){
    #    answer <- readline(prompt = "Is this correct? (y/n): ")
    #    if(answer != "y" & answer != "Y"){
    #        stop(paste("There might be an error in the file name"), call. = FALSE)
    #    }
    # }
    
    ## Return the log output after processing multiple files ----
   return(log)
}
