#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=prod_med

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint center -S \
bigwigs/Veh-MENIN_S2_RPGCnorm.bw bigwigs/Combo-MENIN_S4_RPGCnorm.bw \
bigwigs/Veh-MLL_S1_RPGCnorm.bw bigwigs/Combo-MLL_S3_RPGCnorm.bw \
-R macs/broadpeaks/Combo-MLL_S3_peaks.broadPeak macs/broadpeaks/Veh-MLL_S1_peaks.broadPeak -a 3000 -b 3000 \
-o results/DTmatrix_RPGCnorm_MLL_MENIN_bothPeaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_MLL_MENIN_bothPeaks_refpoint.gz --sortUsingSamples 3 --sortUsing sum \
--samplesLabel Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "combo MLL peaks" "vehicle MLL peaks" --colorMap OrRd OrRd BuPu BuPu \
-o plots/Heatmap_RPGCnorm_MLL_MENIN_bothPeaks_refpoint_VEHsorted.pdf --plotTitle "MLL peaks centered, vehicle MLL ordered"

plotProfile -m results/DTmatrix_RPGCnorm_MLL_MENIN_bothPeaks_refpoint.gz -out plots/Profile_RPGCnorm_MLL_MENIN_bothPeaks_refpoint.pdf \
--samplesLabel Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "combo MLL peaks" "vehicle MLL peaks" --plotTitle "MLL peaks" --perGroup
