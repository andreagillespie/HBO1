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
bigwigs/VEH-MENIN-R1_S11_RPGCnorm.bw bigwigs/VEH-MENIN-R2_S14_RPGCnorm.bw \
bigwigs/VTP-MENIN-R1_S2_RPGCnorm.bw bigwigs/VTP-MENIN-R2_S25_RPGCnorm.bw \
bigwigs/CTX-MENIN-R1_S64_RPGCnorm.bw bigwigs/CTX-MENIN-R2_S19_RPGCnorm.bw \
bigwigs/Combo-MENIN-R1_S7_RPGCnorm.bw bigwigs/Combo-MENIN-R2_S30_RPGCnorm.bw \
-R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
-a 3000 -b 3000 -m 5000 -o results/DTmatrix_MENIN_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_MENIN_MANE_RPGCnorm.gz --sortUsingSamples 1 --sortUsing sum \
--samplesLabel VEH-MENIN-R1 VEH-MENIN-R2 VTP-MENIN-R1 VTP-MENIN-R2 CTX-MENIN-R1 CTX-MENIN-R2 Combo-MENIN-R1 Combo-MENIN-R2 \
--colorMap Oranges --regionsLabel "protein coding genes (MANE)" \
-o plots/Heatmap_MENIN_MANE_RPGCnorm.pdf --plotTitle "MENIN ChIPs, VEH_R1 sorted, RPGC norm"

plotProfile -m results/DTmatrix_MENIN_MANE_RPGCnorm.gz -out plots/Profile_MENIN_MANE_RPGCnorm.pdf \
--samplesLabel VEH-MENIN-R1 VEH-MENIN-R2 VTP-MENIN-R1 VTP-MENIN-R2 CTX-MENIN-R1 CTX-MENIN-R2 Combo-MENIN-R1 Combo-MENIN-R2 \
--regionsLabel "protein coding genes (MANE)" \
--plotTitle "MENIN ChIPs" --perGroup 
