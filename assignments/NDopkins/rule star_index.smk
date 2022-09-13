rule star_index

##Not real directory yet

input:
    refgtf = "hg38.gtf"
    reffa = "hg38.fa

output:
    "C:/Users/17729/.conda/envs/STAR/genome/refs/SA.index"
    "C:/Users/17729/.conda/envs/STAR/genome/refs/SA"

conda:
    "...envs/star.yam1"

threads: 
    snakemake.utils.available_cpu_count()

params:
    dir = "C:/Users/17729/.conda/envs/STAR/genome/refs"
    

shell:

"""
STAR
C:/Users/17729/.conda/envs/STAR 
--runThreadN {threads} 
--runMode genomeGenerate 
--genomeDir {params.dir}
--genomeFastaFiles {input.reffa}
--sjdbGTFfile {input.refgtf}
--sjdbOverhang {74}
"""