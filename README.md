# Clustering-Birds
In this repository I will be employing k-means clustering to group bird species by several size measurements and plot against several categorical variables mentioned by the original authors. 

## Author: Fiel Dimayacyac

## Directory Structure
```
├── Clustering-Birds.Rproj
├── data
│   ├── data_clean.csv
│   ├── mass_predictions.xlsx
│   └── _README.md
├── manuscript
│   ├── bibliography.bib
│   ├── bioinfo.cls
│   ├── manuscript_files
│   │   └── figure-latex
│   │       └── figure-1.pdf
│   ├── manuscript.log
│   ├── manuscript.pdf
│   ├── manuscript.Rmd
│   ├── manuscript.tex
│   ├── natbib.bst
│   ├── OUP_First_SBk_Bot_8401.eps
│   ├── OUP_First_SBk_Bot_8401-eps-converted-to.pdf
│   └── _README.md
├── outputs
│   ├── centered_clusters.png
│   ├── final_clustered_plot.png
│   ├── pre_cluster_plot.png
│   ├── _README.md
│   └── tot.withinss_minimization.png
├── Preregistration.pdf
├── Preregistration.Rmd
├── README.md
└── scripts
    ├── clustering_script.R
    ├── data_exploration.Rmd
    ├── download.R
    └── _README.md
```    
## Usage
First, run download.R to retrieve the data and download required libraries, and then data_exploration.Rmd to produce the cleaned data, and finally clustering_script.R to perform the analysis. Alternatively, you can simply look at the manuscript in the /manuscript directory. 
