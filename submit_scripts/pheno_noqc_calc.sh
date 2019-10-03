#!/bin/bash -e

# Job Name
#$ -N pheNoQcCalc 

# Execute the script from the Current Working Directory
#$ -cwd

# Merge the output of the script, and any error messages generated to one file
#$ -j y

# Send the output of the script to a directory called 'UGE-output' uder current
# working directory (cwd)
if [ ! -d "UGE-output" ]; then #Create output directory in case it does NOT
          exist
mkdir UGE-output
fi
#$ -o UGE-output/

# Tell the job your hardware requirements
#$ -l mem_free=100G
#$ -pe threaded 8

# Send mail when the job is submitted, and when the job
# completes
#$ -m be

#  Specify an email address to use
#$ -M rohit.farmer@nih.gov

singularity exec cytof_workflow_v3.sif Rscript --vanill scripts/script1_arcsinh.R meta/pheno_noqc_20_10k.yaml
singularity exec cytof_workflow_v3.sif Rscript --vanilla scripts/script2_clust.R meta/pheno_noqc_20_10k.yaml
singularity exec cytof_workflow_v3.sif Rscript --vanilla scripts/script3_dr.R meta/pheno_noqc_20_10k.yaml


