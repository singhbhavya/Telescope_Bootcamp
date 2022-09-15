rule telescope:
    input:
        aligned_bam: "../res/{sample_name}.aligned.sorted.bam"
        annot = config['telescope_annot']
    params:
        outdir = "../res/"
    output:
        "../res/{sample_name}.report.tsv"
    log:
        "../res/{sample_name}.telescope.log"
    conda:
        "../env/telescope.yaml"
    shell:
        '''
        ## samtools to extract the bam to sam
        samtools view {aligned_bam} -o {sample_name}.temp.sam
        ## running telescope
        telescope assign \
         --logfile {log} \
         --updated_sam \
         {sample_name}.temp.sam {input.annot}

         ## moving output files
         mv {sample_name}.temp.updated.sam {params.outdir}{sample_name}.updated.sam
         mv {sample_name}.temp.telescope-TE_counts.tsv {params.outdir}{sample_name}.report.tsv
         mv {sample_name}.temp.telescope-stats_report.tsv {params.outdir}{sample_name}.stat_report.tsv

         ##removing the sam to save spaces

         rm {sample_name}.temp.sam
        '''