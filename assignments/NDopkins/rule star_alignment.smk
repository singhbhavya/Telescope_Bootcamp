rule star_alignment:
conda:
    "../envs/star.yaml"
input: 
    single = "samples/{samid}.fastq.gz"
    genome = config['indcexes']['star']
output:
    aligned_bam = "results/star_alignment/{samid}/{samid}_GDC38.Aligned.out.bam"
params:
    out_prefix = "results/star_alignment/{samid}/{samid}_GDC38."
    outFilterMultimapNmax  = config['outFilterMultimapNmax']
    winAnchorMultimapNmax  = config['winAnchorMultimapNmax']
threads: 
    snakemake.utils.available_cpu_count()
benchmark: 
    "benchmarks/star_alignment/{samid}_star_alignment.tsv"
shell:
"""
Star/
--runThreadN {threads}\
--genomeDir {input.genome}\
--readFilesIn {input.single}\
--outSAMtype BAM Unsorted\
--outFileNamePrefix {params.out_prefix}\
--quantMode GeneCounts\
--outSAMstrandField intronMotif\
--outFilterMultimapNmax {params.outFilterMultimapNmax}\
--winAnchorMultimapNmax {params.winAnchorMultimapNmax}\
--outSAMunmapped Within KeepPairs\
--readFilesCommand zcat
"""