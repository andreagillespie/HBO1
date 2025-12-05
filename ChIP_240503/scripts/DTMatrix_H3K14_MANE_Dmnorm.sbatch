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
bigwigs/VEH-H3K14-R1_S22_Dmnorm.bw bigwigs/VEH-H3K14-R2_S15_Dmnorm.bw \
bigwigs/CTX-H3K14-R1_S65_Dmnorm.bw bigwigs/CTX-H3K14-R2_S20_Dmnorm.bw \
bigwigs/VTP-H3K14-R1_S3_Dmnorm.bw bigwigs/VTP-H3K14-R2_S26_Dmnorm.bw \
bigwigs/Combo-H3K14-R1_S8_Dmnorm.bw bigwigs/Combo-H3K14-R2_S31_Dmnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_H3K14_MANE_Dmnorm.gz

plotHeatmap -m results/DTmatrix_H3K14_MANE_Dmnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel H3K14-VEH-R1 H3K14-VEH-R2 H3K14-CTX-R1 H3K14-CTX-R2 H3K14-VTP-R1 H3K14-VTP-R2 H3K14-Combo-R1 H3K14-Combo-R2 \
--colorMap Reds --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_H3K14_MANE_Dmnorm.pdf --plotTitle "H3K14 ChIPs, VEH sorted, spike-in normalised"

plotProfile -m results/DTmatrix_H3K14_MANE_Dmnorm.gz -out plots/Profile_H3K14_MANE_Dmnorm.pdf \
--samplesLabel H3K14-VEH-R1 H3K14-VEH-R2 H3K14-CTX-R1 H3K14-CTX-R2 H3K14-VTP-R1 H3K14-VTP-R2 H3K14-Combo-R1 H3K14-Combo-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "H3K14 ChIPs, spike-in normalised" --perGroup 
