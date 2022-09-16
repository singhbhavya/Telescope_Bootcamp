rule star_index_gdc38_gencode38:
    conda: "..env/star.yaml"
    input: 
        fasta = 'databases/sequences/gdc38.fna',
        gtf = 'databases /annotations/gencode.v38.annotation.gtf'
    output:
        directory("databases/indexes/STAR_gdc38_gencode38"),
        "databases/indexes/STAR_gdc38_gencode38/SAindex"
    params:
        sjdbOverhang = 74
        ## what does this mean?
        ## why 74?
    threads: snakemake.utils.available_cpu_count()
    shell:
        '''
STAR\
    --runThreadN {threads}\
    --runMode genomeGenerate\
    --genomeDir {output[0]}\
    --outFileNamePrefix {output[0]}\
    --genomeFastaFiles {input.fasta}\
    --sjdbGTFfile {input.gtf}\
    --sjdbOverhang {params.sjdbOverhang}
        '''