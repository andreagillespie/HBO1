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
  bigwigs/VEH-Menin_S20_RPGCnorm.bw \
  bigwigs/VTP-Menin_S22_RPGCnorm.bw \
  bigwigs/CTX-Menin_S21_RPGCnorm.bw \
  bigwigs/Combo-Menin_S23_RPGCnorm.bw \
  -R /data/reference/dawson_labs/bed_files/Hg38/Hg38_MANE_ProteinCoding.bed \
  -a 3000 \
  -b 3000 \
  -m 5000 \
  -o results/DTmatrix_Menin_MANE_RPGCnorm.gz

plotHeatmap -m results/DTmatrix_Menin_MANE_RPGCnorm.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel VEH-Menin VTP-Menin CTX-Menin Combo-Menin \
  --colorMap Oranges \
  --regionsLabel "protein coding genes (MANE)" \
  -o plots/Heatmap_Menin_MANE_RPGCnorm.pdf \
  --plotTitle "Menin ChIPs, VEH sorted, RPGC norm"

plotProfile -m results/DTmatrix_Menin_MANE_RPGCnorm.gz \
  -out plots/Profile_Menin_MANE_RPGCnorm.pdf \
  --samplesLabel VEH-Menin VTP-Menin CTX-Menin Combo-Menin \
  --regionsLabel "protein coding genes (MANE)" \
  --plotTitle "Menin ChIPs" \
  --perGroup 
