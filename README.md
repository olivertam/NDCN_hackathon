# NDCN_compbio
Chan Zuckerberg Initiative's Neurodegeneration Challenge Network (CZI NDCN) CompBio Office Hours 

## Hackathon Summary, May 29, 2020
*We’re using the word “hackathon” here to mean working together on something computational that perhaps isn’t any single person’s responsibility, but benefits everyone in the lab.*

Today we had a [CZI NDCN](https://chanzuckerberg.com/science/programs-resources/neurodegeneration-challenge/) mini hackathon. It was led by Julie Lowndes (@jules32) and Oliver Tam (@olivertam). The goals of the hackathon were to:

1. Work hands-on with the Arenas Lab to rename image files using R, RStudio, & RMarkdown 
2. Discuss and test ideas for how to build from this experience towards streamlining their lab workflow
3. Create a supportive space where we feel safe and empowered learning together

We [led the hackathon](https://www.openscapes.org/blog/2020/03/11/how-to-run-a-remote-workshop/) using a combination of Zoom (including screensharing and a breakout room for troubleshooting), Google Docs, and also RStudio for live-coding in R. We had 11 participants join us, most of whom were not in the Arenas lab but came to learn about how to code in R, how to create a workflow like this, and how to adapt the scripts for their own needs. 

The idea for this hackathon came from our NDCN Computational Office Hours that we hold each week. What is cool is that Carmen Salto from the Arenas Lab didn't come to Office Hours with a specific problem, but it was through prompted discussion about data analysis and workflows that we isolated an issue that we could try to tackle together in a hackathon. A special thank you to Oliver Tam (@olivertam) from Cold Spring Harbor, who had the initial idea of the hackathon and has been co-leading the preparation, design, and scripting.


### Setup

**Background description of the problem**: Carmen Salto works at the microscope, taking lots of pictures. She’s mostly focused on cell culture, differentiating cells, immunostainings, microscopy analyses, but also RNA extraction qPCR. Once image files from the microscope are on Carmen’s computer, she has to rename them and organize them by hand. It is complex to keep track of all files, takes a lot of time, and has potential for error / using the wrong picture. In Office Hours on May 1, Carmen, Oliver Tam and I talked about isolating a part of this workflow to streamline. Would it be organizing & renaming files? Writing notes/protocols? We discussed how tweaking an existing file to do what you want is a good way to learn.

**Today’s plan**: We have written a function in an R script, and the beginnings of a workflow in an RMarkdown document. We tested these with Carmen’s lab today, tweak, and make improvements. The R script renames files within a folder, so that they are named with a preferred system from the Arenas lab. For example, the files will be named `CF-Thrb488dkDAPI_20200522_20X2.0-01.jpg`, where this is created through R as `microscope–antibody_YYYYMMDD_magnification–#.jpg` with the following inputs: 
 
- microscope, e.g. "BF"
- antibody, e.g. "Thrb488dkDAPI"
- YYYYMMDD picture date, e.g. "20200522"
- magnification

**Accessing the code & getting oriented**: Everyone downloaded (or cloned) this GitHub repository ("repo"): <https://github.com/olivertam/NDCN_compbio>. Then we opened it in RStudio by double-clicking the .rProj File from Finder/Windows Explorer to open the repo as a RStudio project. We discussed the relevant folders and files insides:

- [hackathon-arenas/](https://github.com/olivertam/NDCN_compbio/tree/master/hackathon-arenas) folder has 2 files:
  - [arenas_lab_usage.Rmd](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd) (“the RMarkdown”)
  - [batch_rename_files.R](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/batch_rename_files.R) (“the script”)
- [rename_files_examples](https://github.com/olivertam/NDCN_compbio/tree/master/rename_files_examples)/ folder has example scripts and images

### Running R code with the Arenas Lab

**Julie screenshared** while in RStudio, we opened both [arenas_lab_usage.Rmd](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd) and [batch_rename_files.R](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/batch_rename_files.R), which were side-by-side in the top-left pane of RStudio. 

We used the [RMarkdown file](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd) as the "recipe" or workflow for the hackathon, with the idea that it could be tailored into a workflow later. From the RMarkdown file, we would use the `batch_rename_files` R function we wrote — which is stored in the .R script of the same name — as some of the ingredients in this recipe/workflow. 

Throughout this whole process above following notes in the [RMarkdown document itself](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd#L8). 

Then, we [explored the `batch_rename_files.R` script](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd#L20) and also [used the script](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd#L41) to "source" the `batch_rename_files.R` script and "run" the `batch_rename_files()` function using [test files](https://github.com/olivertam/NDCN_compbio/tree/master/rename_files_examples/test_files). 

Then, **Carmen screenshared** while repeating the above on her computer. 

### Reflections & next steps

This was actually as far as we got in our 1.5 hours together, [despite having more planned](https://github.com/olivertam/NDCN_compbio/blob/master/hackathon-arenas/arenas_lab_usage.Rmd#L95). But that's fine! There were a few reasons for this: 

- Without knowing group size and expertise, I planned more content than I expected to get through
- There was setup I could have simplified, especially installing the `here` package and making `test_files` a subfolder within the `hackathon-arenas` folder
- a few of RMarkdown's new features gave us unanticipated problems, including that 1) you can't "Run" `setwd()` from a code chunk and 2) that you can't "Run" or copy-paste code that requires user-input. 

These RMarkdown features are actually helping you have reproducible practices, since having `setwd()` in your R code is highly indicitive of a non-reproducible workflow because it will likely contain a a [`path/that/only/works/on/my/machine`](https://rstats.wtf/project-oriented-workflow.html#setwd). And user input will not be possible from a knitted RMarkdown document, so it is better practice to not have that included either. However, it's nice to be able to have your first R experience in an RMarkdown document, so I will look into the options for these settings. During the hackathon we trouble-shooted by 1) copy-pasting `setwd()` in the console instead of "Running" it and 2) by commenting-out the user-input (which was for confirmaion purposes only so not essential to the function's operations), re-sourcing the .R script, and re-running the function call. 

**We discussed next steps and improvements** to this workflow for the Arenas lab.

The first was about what `batch_rename_files` does. It is a solid starting point but it is (intentionally) coarse so now we can refine it. Ideas are:

- it currently renames everything within a folder, we need more control over *which* files in the folder are renamed
- it currently names files afresh, ignoring any previous name. But we would like to *rename* them, which means extracting information from the current name and using some of that information for the new name
- we'd also like part of the renaming to include creating subfolders with appropriate naming

So what this will look like is adding more features to the `batch_rename_files` function (and likely breaking some of this into additional functions) that operate on conditionality (if X then Y) and also uses regular expressions so we can parse out information from the names and use them in both the condition and the new filename.

We'll be discussing this more in Office Hours next week, and will likely have a follow-up hackathon to put some of this into practice. Thanks everyone for joining and for reading!

<br>
<br>






