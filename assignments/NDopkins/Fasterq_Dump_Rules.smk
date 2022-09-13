channels:
-bioconda
dependencies:
-sra-tools 

rule fasterq_dump:
conda: ##"C:/Users/17729/.conda/envs/sra_toolkit.yaml" ##?
    ##Is this an appropriate place for downloading SRA files and stuff?
    ##Folder does not exist (yet)
output: 
R1 = "runs/{s}/{s}_1.fastq"
R2 = "runs/{s}/{s}_2.fastq"
threads: snakemake.utils.available_cpu_count()
params:
tmpdir = confid['faster1_dump_tmp']
outdir = "runs/{s}"
shell:
"""
fasterq_dump --{threads} --progress --0 {params.tmpdir} {wildcard.s} --	SRP333128
"""
##RiboSeq Atlas SRP