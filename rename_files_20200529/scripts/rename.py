# Python3 code to rename multiple  
# files in a directory or folder 
# Source: https://www.geeksforgeeks.org/rename-multiple-files-using-python/
  
# importing os module 
import os 
  
# Function to rename multiple files 
def main(): 
  
    for count, filename in enumerate(os.listdir("xyz")): 
        dst ="Hostel" + str(count) + ".jpg"
        src ='xyz'+ filename 
        dst ='xyz'+ dst 
          
        # rename() function will 
        # rename all the files 
        os.rename(src, dst) 
  
# Driver Code 
if __name__ == '__main__': 
      
    # Calling main() function 
    main() 
