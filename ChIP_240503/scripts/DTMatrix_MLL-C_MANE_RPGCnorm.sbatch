#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=1-0:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod

module load deeptools/3.5.0

computeMatrix scale-regions -S \
bigwigs/VEH-MLL-C-R1_S41_RPGCnorm.bw bigwigs/VEH-MLL-C-R2_S52_RPGCnorm.bw \
bigwigs/VTP-MLL-C-R1_S43_RPGCnorm.bw bigwigs/VTP-MLL-C-R2_S54_RPGCnorm.bw \
bigwigs/CTX-MLL-C-R1_S42_RPGCnorm.bw bigwigs/CTX-MLL-C-R2_S53_RPGCnorm.bw \
bigwigs/Combo-MLL-C-R1_S45_RPGCnorm.bw bigwigs/Combo-MLL-C-R2_S56_RPGCnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_MLL-C_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_MLL-C_MANE_RPGCnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel VEH-MLL-C-R1 VEH-MLL-C-R2 VTP-MLL-C-R1 VTP-MLL-C-R2 CTX-MLL-C-R1 CTX-MLL-C-R2 Combo-MLL-C-R1 Combo-MLL-C-R2 \
--colorMap Purples --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_MLL-C_MANE_RPGCnorm.pdf --plotTitle "MLL-C ChIPs, VEH_R1 sorted, RPGC norm"

plotProfile -m results/DTmatrix_MLL-C_MANE_RPGCnorm.gz -out plots/Profile_MLL-C_MANE_RPGCnorm.pdf \
--samplesLabel VEH-MLL-C-R1 VEH-MLL-C-R2 VTP-MLL-C-R1 VTP-MLL-C-R2 CTX-MLL-C-R1 CTX-MLL-C-R2 Combo-MLL-C-R1 Combo-MLL-C-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "MLL-C ChIPs" --perGroup 
