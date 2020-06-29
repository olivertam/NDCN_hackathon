# NDCN_hackathon
Chan Zuckerberg Initiative's Neurodegeneration Challenge Network (CZI NDCN) CompBio Office Hours 

## Hackathon Summary, June 26, 2020
*We’re using the word “hackathon” here to mean working together on something computational that perhaps isn’t any single person’s responsibility, but benefits everyone in the lab.*

Last week was our second [CZI NDCN](https://chanzuckerberg.com/science/programs-resources/neurodegeneration-challenge/) mini hackathon where we worked with the Arenas Lab to systemize how they collect and organize data so that it is more streamlined for their own work and for sharing with the broader community. The hackathon was led by Oliver Tam (@olivertam) and Julie Lowndes (@jules32). The goals were to:

1. Work hands-on with the Arenas Lab to check image file naming using R, RStudio, & RMarkdown
2. Discuss and test ideas for how to build from this experience towards streamlining their lab workflow
3. Create a supportive space where we feel safe and empowered learning together

We [led the hackathon](https://www.openscapes.org/blog/2020/03/11/how-to-run-a-remote-workshop/) using a combination of Zoom (including screensharing and breakout rooms for troubleshooting), Google Docs for shared notes, and RStudio and RMarkdown for live-coding in R. We had 7 participants join us who came to learn about how to code in R, how to automate the image process and pipelines. Many people had experience running other people’s code and were interested in discussions and demos of how to tweak existing code for their own needs. 

This hackathon came from our NDCN Computational Office Hours that we hold each week, and builds on ideas and momentum from the [first hackathon](TODO URL) we led in May. 
We designed these hackathons with Carmen Salto from the Arenas Lab and Oliver Tam from the Hammell Lab, building from our first initial discussions and then iterating with more folks from the Arenas Lab. Thank you to Oliver for writing the code and leading this hackathon, and to Carmen, Ernest, and Shanzheng for all of your input for the weeks leading up to the hackathon. 

### Setup
**Background description of the problem**: The Arenas Lab leads research on Parkinson’s Disease, and their workflows includes microscopy and imaging that focuses on cell culture, differentiating cells, and immunostainings. Multiple people in the Arenas lab, including Carmen and Shanzheng, work at the microscope, taking lots of pictures. They would like to: 
standardize their file naming conventions, 
use R to check that files are named correctly, and also 
organize named files into folders. 

This hackathon focused on the second step using R code to check that files are named correctly. Beforehand, the Arenas lab has discussed how to standardize their file naming conventions amongst themselves and with Oliver. The hackathon provided a good insight for future steps where files would be organized and moved (or copied) into folders. 

In our first hackathon with the Arenas lab last month, we created a script to rename files without retaining any of the current name. These two scripts could ultimately be used together to rename and check, rename and check. 

**Hackathon 2 plan**: We prepared the `name_checker` function in an R script, and the day’s workflow in an RMarkdown document. During the hackathon, first Oliver screenshared to introduce the function and demonstrate how it worked using a perfectly named file. Then Carmen screenshared to run the code with image files that were not named according to the shared convention. 

The `name_checker.R` script checks that files conform to the Arenas lab convention: 

We expect 8 sections, each separated by an underscore `_`:

1. Experimental name and researcher initials
2. Experiment date and experiment number
3. Condition and replicate number
4. Immunohistochemistry date
5. Dye, antibodies or transcript
6. Image capture date
7. Microscope type
8. Lens, zoom and image number

The first 3 sections would be used (in a future script) to sort the
file into subfolders.

Example:

`NES-SAI2d15-CS_200514-01_Vehicle-1_200517_DAPI+goPitx3-dk488+rbAldh1-dk555+moTh-dk647_200519_CF_10Xz1-1.tiff`

Where:

- Experiment name & initial: `NES-SAI2d15-CS`. experiment name is NES-SAI2d15, CS is Carmen Salto
- Experiment date and number: `200514-01`. 14 May 2020, number 1
- Condition & replicate: `Vehicle-1`. Vehicle condition, replicate 1
- Immunohistochemistry date: `200517`: 17 May 2020
- Dye/antibodies/transcript:
  `DAPI+goPITX3-dk488+rbALDH1-dk555+moTH-dk647`. Each element
  separated by `+`, while primary and secondary antibody pairs are
  separated by `-`.
- Image capture date: `200520`: 20 May 2020
- Microscope type: `CF`. Confocal microscope 
- Lens, zoom & image number: `10X-z2-3`. 10x lens, 2 zoom, number 3.

**Accessing the code & getting oriented**: Everyone downloaded (or cloned) the hackathon GitHub repository: <https://github.com/olivertam/NDCN_compbio>. Then we opened it in RStudio by double-clicking the `.NDCN_hackathon.Rproj` file from Finder/Windows Explorer to open the repo as a RStudio project. Then we navigated to the "arenas-02" folder and opened `[name_checker_usage.Rmd](https://github.com/olivertam/NDCN_hackathon/blob/master/arenas-02/name_checker_usage.Rmd)`, which contained our workflow for the day. 

### Features discussion

We started off demonstrating what the user’s experience would be using this code (i.e. calling the function `name_checker` from the RMarkdown file). Now we can look more at the code to see how it is working (i.e. looking at the `name_checker` code itself) and what else we might want to add.

Oliver created the `name_checker()` function through discussions with the Arenas lab. Their lab discussed what their current personal naming conventions are when they name files at the microscope, and what nice lab conventions could be. Deciding on team norms and writing code to address them is a very iterative process. Today’s hackathon was a good demonstration of this, because there are always additional features that could be added to the code, based on the needs of the group. We talked about balancing the needs and behavior of the user with the features in the code. 

Oliver described this balance as “how much detail do you need vs how much flexibility do you need.” For example, a question was asked about whether the code could highlight the part of the name that is not as expected. Oliver said yes, but that would require you knowing what is expected, and first writing that into the code.

Oliver also screenshared to demonstrate where we would tweak the code to incorporate these updates. The majority of the checks in `name_checker` are: if you remove the underscore, are there 8 sections? Then it gets a bit more stringent: for example, if it’s supposed to be a date, check if it’s numbers. But if you would like it to check that the antibodies and dyes are correct, you would have to first tell the code what is “correct”.

These are some updates/iterations that we discussed. 

- **File types**. The function is designed to only look at certain file types. Can we add to it?
- **Underscores**. The 8 sections are separated by underscores. Do we still like this? What if we wanted to change it to dashes? 
- **FirstCaps**. Currently gene names are in ALLCAPS. But what if we wanted them in FirstCaps? 
- **Dyes and antibodies**. Combining dyes and antibodies gets quite long and complicated. What are other options?
- **Verbose mode**. We can also use the `verbose` argument to give more information to the user.
- **Checking multiple folders**. The function currently operates on just one folder you provide. But we could have the code look through multiple folders.


### Reflections & next steps

Ernest Arenas, the PI of the Arenas Lab, said that this hackathon had empowered them to work with code to systematize and automate their workflows. He said that they feel more comfortable knowing a bit more about how the function Oliver had written works, and how it draws on other functions and logic that they were able to follow. 

As the Arenas Lab plays with the code more in real situations, they’ll discuss more about how they would like to modify it. We'll be discussing this more in Office Hours next week, and will likely have a follow-up hackathon to put some of this into practice. Thanks everyone for joining and for reading!

<br>
<br>

