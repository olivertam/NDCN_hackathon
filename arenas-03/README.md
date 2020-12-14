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
