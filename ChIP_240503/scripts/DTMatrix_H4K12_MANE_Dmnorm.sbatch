#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-10:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

computeMatrix scale-regions -S \
bigwigs/VEH-H4K12-R1_S55_Dmnorm.bw bigwigs/VEH-H4K12-R2_S18_Dmnorm.bw \
bigwigs/CTX-H4K12-R1_S1_Dmnorm.bw bigwigs/CTX-H4K12-R2_S24_Dmnorm.bw \
bigwigs/VTP-H4K12-R1_S6_Dmnorm.bw bigwigs/VTP-H4K12-R2_S29_Dmnorm.bw \
bigwigs/Combo-H4K12-R1_S12_Dmnorm.bw bigwigs/Combo-H4K12-R2_S35_Dmnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_H4K12_MANE_Dmnorm.gz

plotHeatmap -m results/DTmatrix_H4K12_MANE_Dmnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel H4K12-VEH-R1 H4K12-VEH-R2 H4K12-CTX-R1 H4K12-CTX-R2 H4K12-VTP-R1 H4K12-VTP-R2 H4K12-Combo-R1 H4K12-Combo-R2 \
--colorMap pink_r --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_H4K12_MANE_Dmnorm.pdf --plotTitle "H4K12 ChIPs, VEH sorted, spike-in normalised"

plotProfile -m results/DTmatrix_H4K12_MANE_Dmnorm.gz -out plots/Profile_H4K12_MANE_Dmnorm.pdf \
--samplesLabel H4K12-VEH-R1 H4K12-VEH-R2 H4K12-CTX-R1 H4K12-CTX-R2 H4K12-VTP-R1 H4K12-VTP-R2 H4K12-Combo-R1 H4K12-Combo-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "H4K12 ChIPs, spike-in normalised" --perGroup 
