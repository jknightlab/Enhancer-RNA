#!/bin/bash
#$ -cwd
#$ -q short.qc
#$ -pe shmem 2
#$ -j y

module load SAMtools/1.9-foss-2018b

INPUT="./test.data"
data=$(find $INPUT -name "*_chr.uniq.mapped.bam")

for SAMPLE in $data; do   

   Basename=$(echo $SAMPLE | awk -F"/" '{print $NF}' | awk -F "_chr.uniq.mapped.bam" '{print $1}')  
   echo $Basename >> CPM.output2     
   samtools flagstat -@ 12 $SAMPLE | awk 'NR==1{print $1}' >> CPM.output2
done 

paste - - < CPM.output2 > CPM.output3
rm CPM.output2

/apps/well/bedtools/2.27.0/bin/bedtools multicov \
-bams \
${INPUT}/210120_chr.uniq.mapped.bam ${INPUT}/211132_chr.uniq.mapped.bam  \
${INPUT}/215180_chr.uniq.mapped.bam ${INPUT}/216192_chr.uniq.mapped.bam \
${INPUT}/220145_chr.uniq.mapped.bam ${INPUT}/221157_chr.uniq.mapped.bam \
${INPUT}/225110_chr.uniq.mapped.bam ${INPUT}/226122_chr.uniq.mapped.bam \
${INPUT}/230170_chr.uniq.mapped.bam ${INPUT}/231182_chr.uniq.mapped.bam \
${INPUT}/235135_chr.uniq.mapped.bam ${INPUT}/236147_chr.uniq.mapped.bam \
-bed $INPUT/distal.ATAC.regions.Chr7.txt > output/eRNA.counts_6rep.txt
