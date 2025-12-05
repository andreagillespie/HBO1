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

computeMatrix reference-point --referencePoint center -S \
  bigwigs/VEH-Menin_S20_RPGCnorm.bw \
  bigwigs/VTP-Menin_S22_RPGCnorm.bw \
  bigwigs/CTX-Menin_S21_RPGCnorm.bw \
  bigwigs/Combo-Menin_S23_RPGCnorm.bw \
  -R bdgdiff/COMBOvVEH_Menin_c3.0_cond1.bed bdgdiff/COMBOvVEH_Menin_c3.0_cond2.bed \
  -a 3000 \
  -b 3000 \
  -o results/DTmatrix_RPGCnorm_MENIN_COMBO_diffPeaks_refpoint.gz

plotHeatmap -m results/DTmatrix_RPGCnorm_MENIN_COMBO_diffPeaks_refpoint.gz \
  --sortUsingSamples 1 \
  --sortUsing sum \
  --samplesLabel Veh-Menin VTP-Menin CTX-Menin Combo-Menin \
  --regionsLabel "combo Menin up peaks" "vehicle Menin up peaks" \
  --colorMap OrRd \
  -o plots/Heatmap_RPGCnorm_MENIN_COMBO_diffPeaks_refpoint.pdf \
  --plotTitle "diff Menin peaks Combo vs Veh, vehicle ordered"

plotProfile -m results/DTmatrix_RPGCnorm_MENIN_COMBO_diffPeaks_refpoint.gz \
  -o plots/Profile_RPGCnorm_MENIN_COMBO_diffPeaks_refpoint.pdf \
  --samplesLabel Veh-MENIN VTP-MENIN CTX-Menin Combo-Menin \
  --regionsLabel "combo Menin up peaks" "vehicle Menin up peaks" \
  --plotTitle "diff Menin peaks Combo vs Veh" \
  --perGroup
