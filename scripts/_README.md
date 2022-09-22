# _README SCRIPTS

This directory contains all the scripts required for analysis. This includes the downloading script, as well as the scripts where analysis is actually carried out. 

* download.R: This script downloads the data that will be clustered from data dryad into the /data directory. It also loads the required libraries via groundhog.

* data_exploration.Rmd: This R Markdown file contains the data exploration process for the data downloaded in download.R. In this exploration I investigate the distributions of each of the bone measurements, and pick two to use for clustering. Finally, I filter and clean the data for clustering analysis.

* clustering_script.R: This is the script where clustering analysis is carried out. This script performs k-means clustering and produces plots found in the /outputs directory. 