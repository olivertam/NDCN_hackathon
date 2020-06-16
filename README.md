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

Julie screenshared running the code in RStudio using the [RMarkdown file](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd) as the "recipe" or workflow for the hackathon, which would call the [`batch_rename_files`](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/batch_rename_files.R) R function. Carmen then took over the screensharing and tried to replicate the steps shown by Julie, while troubleshooting any issues that arose.

**Reflections**: Although we were unable to go through all the content within the 1.5 hours, the session covered several important aspects in writing/adapting code:
- Setting up a computer/system to be able to run the code can be more complicated than expected (e.g. installing the `here` R package ran into unexpected issues).
- Different/newer versions of program/code can raise unanticipated problems (e.g. RMarkdown cannot run code that requires user input or change directories).






