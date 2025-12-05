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
bigwigs/VEH-MLL-N-R1_S37_RPGCnorm.bw bigwigs/VEH-MLL-N-R2_S48_RPGCnorm.bw \
bigwigs/VTP-MLL-N-R1_S39_RPGCnorm.bw bigwigs/VTP-MLL-N-R2_S50_RPGCnorm.bw \
bigwigs/CTX-MLL-N-R1_S38_RPGCnorm.bw bigwigs/CTX-MLL-N-R2_S49_RPGCnorm.bw \
bigwigs/Combo-MLL-N-R1_S40_RPGCnorm.bw bigwigs/Combo-MLL-N-R2_S51_RPGCnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_MLL-N_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_MLL-N_MANE_RPGCnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel VEH-MLL-N-R1 VEH-MLL-N-R2 VTP-MLL-N-R1 VTP-MLL-N-R2 CTX-MLL-N-R1 CTX-MLL-N-R2 Combo-MLL-N-R1 Combo-MLL-N-R2 \
--colorMap Purples --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_MLL-N_MANE_RPGCnorm.pdf --plotTitle "MLL-N ChIPs, VEH_R1 sorted, RPGC norm"

plotProfile -m results/DTmatrix_MLL-N_MANE_RPGCnorm.gz -out plots/Profile_MLL-N_MANE_RPGCnorm.pdf \
--samplesLabel VEH-MLL-N-R1 VEH-MLL-N-R2 VTP-MLL-N-R1 VTP-MLL-N-R2 CTX-MLL-N-R1 CTX-MLL-N-R2 Combo-MLL-N-R1 Combo-MLL-N-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "MLL-N ChIPs" --perGroup 
