# Nanoneedle-Biopsy

## Repository contents
This repository contains a Collection of scripts in R and MATLAB, used to analyse DESI-MS images of glioma tissue sections and nanoneedle biopsies in the paper "Nondestructive Spatial Lipidomics for Glioma Classification".

[HDI files] - Contains the .txt files with (x,y) position and intensity of 1000 most intense DESI-MS peaks. These files were exported from the raw files by using [High Definition Imaging (HDI) Software](https://www.waters.com/waters/en_US/High-Definition-Imaging-%28HDI%29-Software/nav.htm?cid=134833914&locale=en_US) (Waters Corporation).

[ROIs_definition] - Contains the coordinates of the regions of interest for the single sections and replicas in each image file.

[Parsing in MATLAB] - Contains the MATLAB commands used to convert the HDI files into a format convenient for importing into R as [HyperSpec objects](https://github.com/r-hyperspec/hyperSpec).

[Denoising] - Contains the R scripts used for importing and denoising of DESI-MS images.

[Normalization-HCA-plotting] - Contains the R scripts used for importing, TIC normalization, clustering and plotting of DESI-MS images.

[spectra merging] - Contains the script used to merge 2 datasets after setting the m/z values equals when they are different below a given tolerance (for DESI-MSI between 0.002 and 0.0025 m/z)






