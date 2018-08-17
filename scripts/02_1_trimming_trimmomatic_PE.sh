#!/bin/bash

DATA_DIRECTORY=                                    #path to raw data directory
QC_SCRIPT=				           #path to 02_2_trimming_trimmomatic_PE.qsub
SCRIPT=						#path to script directory
HEADER=						#path to header.txt file


#Running trimming script on every fastq files
cd $DATA_DIRECTORY
for dir in $(ls) ;
do
        cd $dir ;
        FILE_R1=$(ls *_R1.fastq.gz) ;
        FILE_R2=$(ls *_R2.fastq.gz) ;
        echo "cd ${DATA_DIRECTORY}/${dir}" >> tmp ;
        echo "FILE_R1=${DATA_DIRECTORY}/${dir}/${FILE_R1}" >> tmp ;
        echo "FILE_R2=${DATA_DIRECTORY}/${dir}/${FILE_R2}" >> tmp ;
        cat $HEADER tmp $QC_SCRIPT > $SCRIPT/${QC_SCRIPT##*/}_${dir}.qsub
        qsub $SCRIPT/${QC_SCRIPT##*/}_${dir}.qsub ;
        rm tmp ;
        cd .. ;
done
