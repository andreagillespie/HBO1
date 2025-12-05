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
bigwigs/VEH-H4K12-R1_S55_RPGCnorm.bw bigwigs/VEH-H4K12-R2_S18_RPGCnorm.bw \
bigwigs/VTP-H4K12-R1_S6_RPGCnorm.bw bigwigs/VTP-H4K12-R2_S29_RPGCnorm.bw \
bigwigs/CTX-H4K12-R1_S1_RPGCnorm.bw bigwigs/CTX-H4K12-R2_S24_RPGCnorm.bw \
bigwigs/Combo-H4K12-R1_S12_RPGCnorm.bw bigwigs/Combo-H4K12-R2_S35_RPGCnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_H4K12_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_H4K12_MANE_RPGCnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel VEH-H4K12-R1 VEH-H4K12-R2 VTP-H4K12-R1 VTP-H4K12-R2 CTX-H4K12-R1 CTX-H4K12-R2 Combo-H4K12-R1 Combo-H4K12-R2 \
--colorMap pink_r --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_H4K12_MANE_RPGCnorm.pdf --plotTitle "H4K12 ChIPs, VEH_R1 sorted, RPGC norm"

plotProfile -m results/DTmatrix_H4K12_MANE_RPGCnorm.gz -out plots/Profile_H4K12_MANE_RPGCnorm.pdf \
--samplesLabel VEH-H4K12-R1 VEH-H4K12-R2 VTP-H4K12-R1 VTP-H4K12-R2 CTX-H4K12-R1 CTX-H4K12-R2 Combo-H4K12-R1 Combo-H4K12-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "H4K12 ChIPs" --perGroup 
