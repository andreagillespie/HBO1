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

computeMatrix scale-regions -S \
bigwigs/Veh-input_S6_RPGCnorm.bw bigwigs/Combo-input_S7_RPGCnorm.bw \
bigwigs/Veh-MENIN_S2_RPGCnorm.bw bigwigs/Combo-MENIN_S4_RPGCnorm.bw \
bigwigs/Veh-MLL_S1_RPGCnorm.bw bigwigs/Combo-MLL_S3_RPGCnorm.bw \
-R reference_files/RNAseq_downGenes_DT.bed -a 3000 -b 3000 -m 5000 \
-o results/DTmatrix_RPGCnorm_MLL_MENIN_downGenes_geneRegion.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_MLL_MENIN_downGenes_geneRegion.gz \
--sortUsingSamples 5 --sortUsing sum --heatmapHeight 5 \
--samplesLabel Veh-input_S6 Combo-input_S7 Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "down genes" --colorMap Greys Greys OrRd OrRd BuPu BuPu \
-o plots/Heatmap_RPGCnorm_MLL_MENIN_downGenes_geneRegion_VEHsorted.pdf \
--plotTitle "RNAseq down regulated genes, vehicle MLL ordered"

plotProfile -m results/DTmatrix_RPGCnorm_MLL_MENIN_downGenes_geneRegion.gz \
-out plots/Profile_RPGCnorm_MLL_MENIN_downGenes_geneRegion.pdf \
--samplesLabel Veh-input_S6 Combo-input_S7 Veh-MENIN_S2 Combo-MENIN_S4 Veh-MLL_S1 Combo-MLL_S3 \
--regionsLabel "down genes" --plotTitle "RNAseq down regulated genes, TSS centered" --perGroup
