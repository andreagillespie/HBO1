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
bigwigs/VEH-H3K79-R1_S44_RPGCnorm.bw bigwigs/VEH-H3K79-R2_S17_RPGCnorm.bw \
bigwigs/VTP-H3K79-R1_S5_RPGCnorm.bw bigwigs/VTP-H3K79-R2_S28_RPGCnorm.bw \
bigwigs/CTX-H3K79-R1_S67_RPGCnorm.bw bigwigs/CTX-H3K79-R2_S23_RPGCnorm.bw \
bigwigs/Combo-H3K79-R1_S10_RPGCnorm.bw bigwigs/Combo-H3K79-R2_S34_RPGCnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_H3K79_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_H3K79_MANE_RPGCnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel VEH-H3K79-R1 VEH-H3K79-R2 VTP-H3K79-R1 VTP-H3K79-R2 CTX-H3K79-R1 CTX-H3K79-R2 Combo-H3K79-R1 Combo-H3K79-R2 \
--colorMap Blues --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_H3K79_MANE_RPGCnorm.pdf --plotTitle "H3K79 ChIPs, VEH_R1 sorted, RPGC norm"

plotProfile -m results/DTmatrix_H3K79_MANE_RPGCnorm.gz -out plots/Profile_H3K79_MANE_RPGCnorm.pdf \
--samplesLabel VEH-H3K79-R1 VEH-H3K79-R2 VTP-H3K79-R1 VTP-H3K79-R2 CTX-H3K79-R1 CTX-H3K79-R2 Combo-H3K79-R1 Combo-H3K79-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "H3K79 ChIPs" --perGroup 
