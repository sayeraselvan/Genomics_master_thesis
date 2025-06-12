# Genomics Master Thesis

**Author**: Siva Subramanian Ayeraselvan  
**Date**: June 2025

---

## Project Description

This repository contains the scripts, data files, and documentation associated with my Master's thesis in Genomics. The project focuses on analyzing genomic datasets to address biological questions related to:

- Adaptation
- Niche modeling
- Conservation genomics

The analyses combine next-generation sequencing (NGS) data processing with advanced statistical and ecological modeling.

---


## Repository Structure

-├── GEMMA/ # GWAS / GEA genome environmental association scripts
-│ └── GEA_scripts/ 
-├── mar/ # mutation area relationship - conservation genomics
-├── maxent_manual/ # detailed overview to perform maxent
-├── gradient_forest/ # GF analysis i performed
-└── README.md # This file

---

## Methods Summary

The following methods and analyses are included:

- Genome-Environment Associations using GEMMA
- Species Distribution Modeling with MaxEnt
- Gradient Forest analysis for adaptive genomic variation
- Mutation-Area Relationship (MAR) analysis for conservation applications

---

## Software and Tools

- Python >= 3.x
- R >= 4.x
- GEMMA
- maxENT
- Gradient Forest (R package)
- BEDTools
- VCFtools
- Samtools
- BCFtools

R packages used include:  
`gradientForest`, `tidyverse`, `data.table`, `raster`, `dismo`, `rgdal`, `vegan`, `ggplot2`.

---

## How to use this

### Clone the repository

```bash
git clone git@github.com:sayeraselvan/Genomics_master_thesis.git
cd Genomics_master_thesis
