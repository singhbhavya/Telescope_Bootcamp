rule star_alignment:
    conda:
        "../envs/star.yaml"
    input:
        sample = "samples/{samid}.fastq.gz",
        genome = config['indexes']['star']
    output:
        aligned_bam = "results/star_alignment/{samid}/{samid}_GDC38.aligned.out.bam"
    params:
        out_prefix = "results/star_alignment/{samid}/{samid}_GDC38.",
        outFilterMultimapNmax = config['outFilterMultimapNmax'],
        winAnchorMultimapNmax = config['winAnchorMultimapNmax']
        ## not sure what any of these mean, I just used your command lines for my reference
        ## why do you need to specify an output file name prefix in the params instead of specifying it in the output line?
        ## still having trouble knowing when to use parameters and what they should be
    threads: config['star_alignment_threads']
        ## do all rules require thread specification? for example, does the telescope rule need threads?
        ## what is the typical thread count for the star rule?
    shell:
        '''
        STAR\
            --runThreadN {threads}\
            --genomeDir {input.genome}\
            --readFilesIn {input.single}\
            --outSAMattributes NH HI NM MD AS XS\ *
            --outSAMtype BAM Unsorted\ *
            --outFileNamePrefix {params.out_prefix}\ *
            --quantMode GeneCounts\ *
            --outSAMstrandField introMotif\ *
            --outFilterMultimapNmax {params.outFilterMultimapNmax}\ *
            --winAnchorMultimapNmax {params.winAnchorMultimapNmax}\ *
            --outSAMunmapped Within KeepPairs\  *
            --readFilesCommmand zcat *
        '''
## why the three quotation marks?
## not sure what any of the starred (*) commands actually do