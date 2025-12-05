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
bigwigs/Veh-input_S6_RPGCnorm.bw bigwigs/Combo-input_S7_RPGCnorm.bw \
bigwigs/Veh-MENIN_S2_RPGCnorm.bw bigwigs/Combo-MENIN_S4_RPGCnorm.bw \
bigwigs/Veh-MLL_S1_RPGCnorm.bw bigwigs/Combo-MLL_S3_RPGCnorm.bw \
-R bdgdiff/COMBOvVEH_c3.0_cond1.bed bdgdiff/COMBOvVEH_c3.0_cond2.bed -a 3000 -b 3000 \
-o results/DTmatrix_RPGCnorm_MLL_MENIN_diffPeaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_MLL_MENIN_diffPeaks_refpoint.gz --sortUsingSamples 3 --sortUsing sum \
--samplesLabel Veh-input_S6 Combo-input_S7 Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "combo MLL up peaks" "vehicle MLL up peaks" --colorMap Greys Greys OrRd OrRd BuPu BuPu \
-o plots/Heatmap_RPGCnorm_MLL_MENIN_diffPeaks_refpoint_VEHsorted.pdf --plotTitle "diff MLL peaks Combo vs Veh, vehicle MLL ordered"

plotProfile -m results/DTmatrix_RPGCnorm_MLL_MENIN_diffPeaks_refpoint.gz -out plots/Profile_RPGCnorm_MLL_MENIN_diffPeaks_refpoint.pdf \
--samplesLabel Veh-input_S6 Combo-input_S7 Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "combo MLL up peaks" "vehicle MLL up peaks" --plotTitle "diff MLL peaks Combo vs Veh" --perGroup
