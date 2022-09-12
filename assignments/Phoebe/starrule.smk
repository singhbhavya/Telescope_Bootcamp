#! /usr/bin/env python
# -*- coding: utf-8 -*-

## What does it mean to index a genome and why do we have to do it prior to alignment?
## A: Basically it assigns a number to the regions of the reference genome, so during alignment, we can directly jump to the correct region and scan through the region instead of scanning through the entire file.

rule star_index:
	## input filename
	input: 
		#bams = "{sample_name}.fastq"
		#fake directory
		refgtf = "hg38.gtf"
		reffa = "hg38.fa"
	## output filename
	output:
		"../refs/SAindex"
		"../refs/SA"
	## env file path
	conda:
		"../envs/star.yaml"
	## cpu
	threads: 8
	## local variables
	params: 
		dir = "../refs"
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
			 --sjdbOverhang 99
		'''
		
## Simlink
## ls -lh for more information

	
			 
	