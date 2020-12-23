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


## Hackathon Summary, December 18, 2020
*We’re using the word “hackathon” here to mean working together on something computational that perhaps isn’t any single person’s responsibility, but benefits everyone in the lab.*

This was our third [CZI NDCN](https://chanzuckerberg.com/science/programs-resources/neurodegeneration-challenge/) mini hackathon where we worked with the [Arenas Lab](http://ernestarenaslab.org/) to systematize how they collect and organize data so that it is more streamlined for their own work and for sharing with the broader community. The hackathon was led by Oliver Tam (@olivertam) and Julie Lowndes (@jules32). The goals were to:

1. Test a workflow where image file is moved from one location (e.g. central repository) to another location (e.g. lab server) using hierarchical folder structure developed by the lab
2. Discuss how the functions underlying the workflow operates, and observing how some of the code works.
3. Create a supportive space where we feel safe and empowered learning together

We [led the hackathon](https://www.openscapes.org/blog/2020/03/11/how-to-run-a-remote-workshop/) using a combination of Zoom (including screensharing and breakout rooms for troubleshooting), Google Docs for shared notes, and RStudio and RMarkdown for live-coding in R.

This hackathon came from our NDCN Computational Office Hours that we hold each week, and builds on ideas and momentum from the [first hackathon](https://github.com/olivertam/NDCN_hackathon/tree/master/arenas-01#ndcn_hackathon) we led in May. 
We designed these hackathons with Carmen Salto from the Arenas Lab and Oliver Tam from the Hammell Lab, building from our first initial discussions and then iterating with more folks from the Arenas Lab. Thank you to Oliver Tam for writing the code and leading this hackathon, and to Carmen Salto, Ernest Arenas, and Shanzheng Yang for all of your input for the weeks leading up to the hackathon. 

### Setup

**Background description of the problem**: The Arenas Lab leads research on Parkinson’s Disease, and their workflows includes microscopy and imaging that focuses on cell culture, differentiating cells, and immunostainings. Multiple people in the Arenas lab, including Carmen and Shanzheng, work at the microscope, taking lots of pictures. They would like to: 

- standardize their file naming conventions, 
- use R to check that files are named correctly, and also 
- organize named files into folders. 

This hackathon focused on the second step: using R code to check that files are named correctly. Beforehand, the Arenas lab has discussed how to standardize their file naming conventions amongst themselves and with Oliver. The hackathon provided a good insight for future steps where files would be organized and moved (or copied) into folders. 

In our first hackathon with the Arenas lab last month, we created a script to rename files without retaining any of the current name. These two scripts could ultimately be used together to rename and check, rename and check. 

**Accessing the code & getting oriented**: Everyone downloaded (or cloned) the hackathon GitHub repository: <https://github.com/olivertam/NDCN_compbio>. Then we opened it in RStudio by double-clicking the `.NDCN_hackathon.Rproj` file from Finder/Windows Explorer to open the repo as a RStudio project. Then we navigated to the "arenas-03" folder and opened [`file_mover_anonymizer.Rmd`](https://github.com/olivertam/NDCN_hackathon/blob/master/arenas-03/file_mover_anonymizer.Rmd), which contained our workflow for the day. 


### Summary writeup
At our last Office Hours session of 2020, we had our third Hackathon with the Arenas Lab and Oliver Tam. This was really a synthesis of concepts we’ve covered this year, including reproducibility, open science, collaboration, onboarding, – and peer-learning in a positive setting. This hackathon was led by Oliver Tam and the Arenas Lab, to practice a workflow that uses R code to move, rename, organize, and anonymize microscope image files. Here is the [agenda doc](https://docs.google.com/document/d/16mx29oXJtNvfevmqjWxuzUl9JfDPHevmUChQE4pz7NM/edit?usp=sharing) and the [github repo](https://github.com/olivertam/NDCN_hackathon).

**Background information**

Prior to this Hackathon 3 in December, we held 2 Hackathons and 1 Fireside Chat with the Arenas Lab in May, June, and October, co-led with Oliver Tam. We’re using “hackathon” to mean working together on something computational that perhaps isn’t any single person’s responsibility, but benefits the lab. The motivation for this was to systematize how the Arenas Lab works with image file naming and organization so that it is more streamlined for their analyses. We did this together through Office Hours so others could benefit from the incremental conversations, planning, and code. PI Ernest Arenas was keen to create a system where 1) standards are easy to identify and are reliable and 2) there are straight-forward ways to apply the standards so that people inside and outside of the lab can use them. He has emphasized interest in making their data available for other researchers to work with too. Since the first hackathon, the Arenas Lab has grown, and lab members have been attending the previous hackathons and practicing in between sessions with Oliver's code.

**During the Hackathon**

Oliver Tam led the Hackathon by screensharing while talking through and running the R code he had written for the Arenas Lab. He developed this R code in an RMarkdown document (called `file_mover_anonymizer.Rmd`) so that he could write instructions in plain text while having executable R code in the same place. This way, he was able to describe in detail how he wrote and organized the code building from the previous Hackathons and conversations with the Arenas Lab about their needs and use-cases.

He had written the code in small pieces that could be combined into a workflow – a way described as "modular". (Oliver has also organized these scripts [in a way](https://github.com/olivertam/NDCN_hackathon/tree/master/arenas-03/arenasImageOrganizer) so that in the future they can be turned into a package following Wickham & Bryan: https://r-pkgs.org. This means that different people from the Arenas Lab can develop workflows based on these modular pieces of code that provide consistency across everyone's workflow – but individual workflows can still be done in a way that is more personal and makes sense to the person developing the analysis with their data and running the code.

The general workflow starts at the microscope, where someone takes pictures and saves the image files with the Arenas Lab naming convention. Then, in RStudio, there are the following steps (outlined in [arenas-03/example_workflow.Rmd](https://github.com/olivertam/NDCN_hackathon/blob/master/arenas-03/example_workflow.Rmd)):

* Check names using name_checker.R
* Move files using file_mover.R
* Optionally anonymize files using file_anonymizer.

At one point Ernest commented that it is surprising that a lot of the code is safety and checking alongside the "doing". Oliver replied that yes: in his experience writing code to do something is usually 4-5 lines...but then making sure it will work in all the ways you might want to use it is another page of code! Chris Sifuentes highlighted the purposefulness of the way Oliver writes his code.

**Looking ahead** 

We ended with discussing next steps for folks in the Arenas Lab, and how they can all work from a single, up-to-date version of Oliver's code. They have already created a GitHub Organization for their lab (https://github.com/ArenasLab), where they've forked Oliver's repo. So next steps can involve continuing to use and test the code from this repo, and have any edits discussed with the group and updated so that everyone is working from the same system. Very exciting!

This was my (Julie's) last time leading Office Hours, and during introductions folks shared about what they've learned, which was really inspiring. Here are some of those comments (paraphrased):

* I've focused on writing code & workflows that are actually readable by others (for sharing)
* I've learned how computational biology is a daily tool, and I've increased my knowledge of how to do it. It's been an empowering and pleasant experience – a double benefit
* Before I used R just for stats but I've learned I can do a lot of other things like a shell language can (renaming files etc)
* I've learned a lot more than I expected, things I wouldn't have reached on my own
* I've learned many useful tools, and am enjoying the script we're using to declutter all my messy files. I'm trying to incorporate version control too and looking forward to what we're doing next

Thank you again for being part of Office Hours; it has been a pleasure to work with the NDCN community this year! Through Office Hours I’ve learned so much about the complexity of your work and hope that the topics we covered have helped you be a bit more efficient and empowered in your computational approaches. Thank you for being so welcoming and I hope our paths will cross again! Please stay in touch: CZIScience Slack, [juliaslowndes@gmail.com](mailto:juliaslowndes@gmail.com), Twitter [@juliesquid](https://twitter.com/juliesquid), [openscapes.org](https://openscapes.org)

**Office Hours will continue in 2021 with Chris Sifuentes**, and will continue to focus on computational skills and community building within the NDCN. I hope you can attend, and bring your lab!

