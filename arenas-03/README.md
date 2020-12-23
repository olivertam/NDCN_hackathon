# NDCN_hackathon
Chan Zuckerberg Initiative's Neurodegeneration Challenge Network (CZI NDCN) CompBio Office Hours 

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

