## Telescope bootcamp homework 9/15

## What exactly is snakemake and yaml? why do we use them in particular, and how do they help us fulfill particular tasks?

## installing telescope
conda install -c bioconda telescope
## running telescope on single cell sample
telescope sc assign [aligned_bam] [annotated_gtf]
 

rule telescope:
    conda:
        "../envs/telescope.yaml"
    input: 
        aligned_bam = "results/star_alignment/{samid}/{samid}_GDC38.aligned.out.bam",
        annotated_gtf = "databases/annotations/hg38.cytoband.gtf"
    log: 
    output:
        TE_count = results/telescope/{samid}/{samid}_telescope-TE_counts.tsv,
        stats = results/telescope/{samid}/{samid}_telescope-stats_report.tsv
    params:
        tempdir = ?
    shell:
        """
        telescope assign\
            --input
            --log
            --output
            --params
            
        