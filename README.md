# NDCN_hackathon
Chan Zuckerberg Initiative's Neurodegeneration Challenge Network (CZI NDCN) CompBio Office Hours

*We’re using the word “hackathon” here to mean working together on something computational that perhaps isn’t any single person’s responsibility, but benefits everyone in the lab.*

The idea for this hackathon series came from our NDCN Computational Office Hours that we hold each week. What is cool is that Carmen Salto from the Arenas Lab didn't come to Office Hours with a specific problem, but it was through prompted discussion about data analysis and workflows that we isolated an issue that we could try to tackle together in a hackathon. A special thank you to Oliver Tam (@olivertam) from Cold Spring Harbor, who had the initial idea of the hackathon and has been co-leading the preparation, design, and scripting.

The goals of these hackathons are to:

1. Work hands-on with a lab on a problem that might be solvable using R, RStudio, & RMarkdown.
2. Discuss and test ideas for how to build from this experience towards streamlining their lab workflow
3. Create a supportive space where we feel safe and empowered learning together

## Hackathon Summary, May 29, 2020

The specific goal of this hackathon (in addition to the goals listed above) is to work hands-on with the Arenas Lab to rename image files using R, RStudio, & RMarkdown 

**Background description of the problem**: Carmen Salto works at the microscope, taking lots of pictures. She’s mostly focused on cell culture, differentiating cells, immunostainings, microscopy analyses, but also RNA extraction qPCR. Once image files from the microscope are on Carmen’s computer, she has to rename them and organize them by hand. It is complex to keep track of all files, takes a lot of time, and has potential for error / using the wrong picture. In Office Hours on May 1, Carmen, Oliver Tam and I talked about isolating a part of this workflow to streamline. Would it be organizing & renaming files? Writing notes/protocols? We discussed how tweaking an existing file to do what you want is a good way to learn.

**Running R code with the Arenas Lab**: We [led the hackathon](https://www.openscapes.org/blog/2020/03/11/how-to-run-a-remote-workshop/) using a combination of Zoom (including screensharing and a breakout room for troubleshooting), Google Docs, and also RStudio for live-coding in R. We had 11 participants join us, most of whom were not in the Arenas lab but came to learn about how to code in R, how to create a workflow like this, and how to adapt the scripts for their own needs. 

Julie screenshared running the code in RStudio using the [RMarkdown file](https://github.com/olivertam/NDCN_compbio/blob/master/arenas-01/batch_rename_files_usage.Rmd) as the "recipe" or workflow for the hackathon, which would call the [`batch_rename_files`](https://github.com/olivertam/NDCN_compbio/blob/master/arenas-01/code/batch_rename_files.R) R function. Carmen then took over the screensharing and tried to replicate the steps shown by Julie, while troubleshooting any issues that arose.

**Reflections**: Although we were unable to go through all the content within the 1.5 hours, the session covered several important aspects in writing/adapting code:
- Setting up a computer/system to be able to run the code can be more complicated than expected (e.g. installing the `here` R package ran into unexpected issues).
- Different/newer versions of program/code can raise unanticipated problems (e.g. RMarkdown cannot run code that requires user input or change directories).


## Hackathon Summary, June 26, 2020

The specific goal of this hackathon (in addition to the goals listed above) is to work hands-on with the Arenas Lab to check image file naming using R, RStudio, & RMarkdown.

**Background and description of the problem**: After the last hackathon, a feature request was raised about the ability to rename files using information already present in the existing file name. This led to a discussion among members of the Arenas lab on how best to streamline their workflow after capturing microscope images from their immunostaining experiments. A proposed solution arose from the discussion that revolved around the following steps:

1. Developing a standardized naming convention for image files generated at the microscope 
2. Use an algorithm (e.g. an R function) to check that files are named according to the standardized convenion 
3. Re-organizing/Sorting files to their appropriate folder/subfolder using the information extracted from the file name.

After the Arenas lab developed a draft naming convention (you can find more details [here](https://github.com/olivertam/NDCN_hackathon/blob/master/arenas-02/README.md#Setup)), an R function was developed to determine if the file names match the proposed nomenclature.

**Understanding the R function with the Arenas lab**: We [led the hackathon](https://www.openscapes.org/blog/2020/03/11/how-to-run-a-remote-workshop/) using a combination of Zoom (including screensharing and breakout rooms for troubleshooting), Google Docs for shared notes, and RStudio and RMarkdown for live-coding in R. We had 7 participants join us who came to learn about how to code in R and how to automate the image process and create pipelines. Many people had experience running other people’s code and were interested in discussions and demos of how to tweak existing code for their own needs. 

Oliver screenshared running the code in RStudio using the [RMarkdown file](https://github.com/olivertam/NDCN_compbio/blob/master/arenas-02/name_checker_usage.Rmd) as the "recipe" or workflow for the hackathon, which would call the [`name_checker`](https://github.com/olivertam/NDCN_compbio/blob/master/arenas-02/code/name_checker.R) R function. Carmen then took over the screensharing and ran the code on a set of files that were named by the Arenas lab, Oliver and Julie. The Arenas lab and Oliver then discussed the output of the R function, and in cases where the file names were "incorrect", try to interpret the "error" messages to identify the issue.

Oliver then explained some of the features that are in the R function (e.g. filtering for specific file types, breaking the filename into chunks), not only to describe what the code does, but also how another user could tweak/change the code to suit their purposes (e.g. adding more file types to filter, changing the delimiter from underscore to comma). There was also a sneak peek into the possibility of using the R function to not only check that files are named correctly, but potentially extract pieces of information from the file name for other uses.

**Reflections**: Ernest Arenas, the PI of the Arenas Lab, commented that the hackathon had empowered the lab to work with code to systematize and automate their workflows, and that it was very helpful to understand how the `name_checker` function works and how it draws on other functions and logic that they can follow.

Although the specific tasks performed by the `name_checker` R function might appear limited in focus, it is now possible to envision how this particular process might fit into a larger workflow. For example, the `name_checker` function could take the information provided in the researcher's filename, confirm that it's correct, and then send the file (and any relevant information) to a script that would move/rename the file to a destination folder using a modified version of the `batch_renaming_files` script from [hackathon 1](https://github.com/olivertam/NDCN_compbio/blob/master/arenas-01/code/batch_rename_files.R).

