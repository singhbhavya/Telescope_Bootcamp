#Telescope bootcamp homework 9/12

conda install -c bioconda telescope
telescope sc assign [aligned_bam] [annotated_gtf]
 

rule telescope:
    conda:
        "../envs/star.yaml"
    input: 
        aligned_bam = "results/star_alignment/{samid}/{samid}_GDC38.aligned.out.bam"
        annotated_gtf = "databases/annotations/hg38.cytoband.gtf"
    output:
        TE_count = results/telescope/{samid}/{samid}_telescope-TE_counts.tsv
        stats = results/telescope/{samid}/{samid}_telescope-stats_report.tsv
    params:
        tempdir = 
        