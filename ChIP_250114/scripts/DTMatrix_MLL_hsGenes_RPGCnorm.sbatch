#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=32G
#SBATCH --time=1-0:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge

module load deeptools/3.5.0

computeMatrix scale-regions -S \
  bigwigs/VEH-MLL_S15_RPGCnorm.bw \
  bigwigs/VTP-MLL_S17_RPGCnorm.bw \
  bigwigs/CTX-MLL_S16_RPGCnorm.bw \
  bigwigs/Combo-MLL_S18_RPGCnorm.bw \
  -R reference_files/highly_sensitive_genes.bed \
  -a 3000 \
  -b 3000 \
  -m 5000 \
  -o results/DTmatrix_MLL_hsGenes_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_MLL_hsGenes_RPGCnorm.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel VEH-MLL VTP-MLL CTX-MLL Combo-MLL \
  --colorMap Purples \
  --regionsLabel "highly sensitive genes (MANE)" \
  -o plots/Heatmap_MLL_hsGenes_RPGCnorm.pdf \
  --plotTitle "MLL ChIPs, VEH sorted, RPGC norm" \
  --heatmapHeight 5

plotProfile -m results/DTmatrix_MLL_hsGenes_RPGCnorm.gz \
  -out plots/Profile_MLL_hsGenes_RPGCnorm.pdf \
  --samplesLabel VEH-MLL VTP-MLL CTX-MLL Combo-MLL \
  --regionsLabel "highly sensitive genes (MANE)" \
  --plotTitle "MLL ChIPs" \
  --perGroup 
