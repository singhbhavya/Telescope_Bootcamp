#! /usr/bin/env python
# -*- coding: utf-8 -*-

## What does it mean to index a genome and why do we have to do it prior to alignment?
## A: Basically it assigns a number to the regions of the reference genome, so during alignment, we can directly jump to the correct region and scan through the region instead of scanning through the entire file.

rule star_index:
	## input filename
	input: 
		bams_r1 = "../files/{sample_name}_R1.fastq"
		bams_r2 = "../files/{sample_name}_R2.fastq"
		refgtf = "../refs/hg38.gtf"
		reffa = "../refs/hg38.fa"
	## output filename
	output:
		"../res/{sample_name}.aligned.sorted.bam"
		"../res/{sample_name}.ReadsPerGene.out.tab"
		"../refs/SAindex"
		"../refs/SA"
	## env file path
	conda:
		"../env/star.yaml"
	## cpu
	threads: 8
	## local variables
	params: 
		dir = "../refs"
		outdir = "../res"
	## the scripts
	shell:
		'''
		## --sjdbOverhang: tells STAR how many bases to concatenate from donor and acceptor sides of the junctions
		## If you have 100b reads, the ideal value of --sjdbOverhang is 99
		STAR --runMode genomeGenerate \
			 --runThreadN {threads} \
			 --genomeDir {params.dir} \
			 --genomeFastaFiles {input.reffa} \
			 --sjdbGTFfile {input.refgtf} \
			 --sjdbOverhang 70
		
		## STAR alignment rule
		STAR --runMode alignReads \
  			 --runThreadN {threads} \
  			 --genomeDir {params.dir} \
  			 --readFilesIn ${bams_r1} {bams_r2} \
  			 --outSAMattributes NH HI NM MD AS XS \
  			 --outFileNamePrefix {params.outdir}/{sample_name}. \
  			 --outSAMtype BAM SortedByCoordinate \
			 --quantMode GeneCounts \
  			 --outSAMstrandField intronMotif \

		## samtools index
		samtools index {params.outdir}/{sample_name}.Aligned.sortedByCoord.out.bam -o {params.outdir}/{sample_name}.aligned.sorted.bam
		'''
		
## Simlink
## ls -lh for more information

	
			 
	