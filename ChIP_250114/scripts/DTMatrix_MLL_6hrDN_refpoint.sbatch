#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/deeptoolsMatrix%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="DTMatrix"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module purge

module load deeptools/3.5.0

computeMatrix reference-point --referencePoint TSS -S \
  bigwigs/VEH-MLL_S15_RPGCnorm.bw \
  bigwigs/VTP-MLL_S17_RPGCnorm.bw \
  bigwigs/CTX-MLL_S16_RPGCnorm.bw \
  bigwigs/Combo-MLL_S18_RPGCnorm.bw \
  -R reference_files/6hr_DN_genes.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_MLL_6hrDN_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_MLL_6hrDN_refpoint.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel Veh-MLL VTP-MLL CTX-MLL Combo-MLL \
  --regionsLabel "6 hour downregulated genes" \
  --colorMap BuPu \
  -o plots/Heatmap_RPGCnorm_MLL_6hrDN_refpoint.pdf \
  --plotTitle "MLL 6 hour downregulated genes, vehicle ordered"

plotProfile -m results/DTmatrix_RPGCnorm_MLL_6hrDN_refpoint.gz \
  -o plots/Profile_RPGCnorm_MLL_6hrDN_refpoint.pdf \
  --samplesLabel Veh-MLL VTP-MLL CTX-MLL Combo-MLL \
  --regionsLabel "6 hour downregulated genes" \
  --plotTitle "MLL 6 hour downregulated genes" \
  --perGroup
