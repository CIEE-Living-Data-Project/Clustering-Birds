#Initial download script

#Load the packages
groundhog::groundhog.library(
  "
  library('rdryad')
  library('tidyverse')
  library('here')
  "
  ,'2022-09-01', tolerate.R.version = '4.1.2'
)

# Now to download from Dryad from the following doi: https://doi.org/10.5061/dryad.1rn8pk0tb

rdryad::dryad_download("10.5061/dryad.1rn8pk0tb")
system("cp -r /home/fieldima/.cache/R/rdryad/10_5061_dryad_1rn8pk0tb/ data/")