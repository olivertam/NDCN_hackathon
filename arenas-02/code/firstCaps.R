## Subroutine to capitalize the first letter, and make other letters lowercase ##
firstCaps <- function(string){
    string = tolower(string) 
    newString = paste0(toupper(substring(string,1,1)),substring(string,2),collapse=" ")
    return(newString)
}
