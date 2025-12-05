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
bigwigs/VEH-H3K23-R1_S33_Dmnorm.bw bigwigs/VEH-H3K23-R2_S16_Dmnorm.bw \
bigwigs/CTX-H3K23-R1_S66_Dmnorm.bw bigwigs/CTX-H3K23-R2_S21_Dmnorm.bw \
bigwigs/VTP-H3K23-R1_S4_Dmnorm.bw bigwigs/VTP-H3K23-R2_S27_Dmnorm.bw \
bigwigs/Combo-H3K23-R1_S9_Dmnorm.bw bigwigs/Combo-H3K23-R2_S32_Dmnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_H3K23_MANE_Dmnorm.gz

plotHeatmap -m results/DTmatrix_H3K23_MANE_Dmnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel H3K23-VEH-R1 H3K23-VEH-R2 H3K23-CTX-R1 H3K23-CTX-R2 H3K23-VTP-R1 H3K23-VTP-R2 H3K23-Combo-R1 H3K23-Combo-R2 \
--colorMap Greens --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_H3K23_MANE_Dmnorm.pdf --plotTitle "H3K23 ChIPs, VEH sorted, spike-in normalised"

plotProfile -m results/DTmatrix_H3K23_MANE_Dmnorm.gz -out plots/Profile_H3K23_MANE_Dmnorm.pdf \
--samplesLabel H3K23-VEH-R1 H3K23-VEH-R2 H3K23-CTX-R1 H3K23-CTX-R2 H3K23-VTP-R1 H3K23-VTP-R2 H3K23-Combo-R1 H3K23-Combo-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "H3K23 ChIPs, spike-in normalised" --perGroup 
