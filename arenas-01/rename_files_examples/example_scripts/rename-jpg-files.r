# Source: https://www.r-bloggers.com/renaming-all-files-in-a-folder-in-r/
# SourceCode: https://gist.github.com/summerofgeorge/aa03aade182f7fe2b6ebdf7afe95cc05

# List the jpg files in the folder

old_files <- list.files("C:/ImageTest", pattern = "*.JPG", full.names = TRUE)
old_files

# Create vector of new files

new_files <- paste0("C:/NewFiles/file_",1:length(old_files),".JPG")
new_files

# Copy from old files to new files

file.copy(from = old_files, to = new_files)

# Clear out the old files
#file.remove(old_files)
