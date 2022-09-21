#Initial download script

#Load the packages
groundhog::groundhog.library(
  "
  library('tidyverse')
  library('here')
  "
  ,'2022-09-01', tolerate.R.version = '4.1.2'
)

#Create the data directory
if (!dir.exists("data")) dir.create("data")

# Now to download from Dryad from the following doi: https://doi.org/10.5061/dryad.1rn8pk0tb

#Downloaded on Sep 20th, 2022
download.file("https://datadryad.org/stash/downloads/file_stream/687181.xlsx", destfile = "data/mass_predictions.xlsx")

#The file above is an excel sheet with the body mass predictions for each bird in the study