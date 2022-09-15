rule fastq_dump:
    conda:
        "../env/fastq_dump.yaml"
    input:
        config['sra_run_table']
    output:
        "../files/{sample_name}_R1.fastq"
		"../files/{sample_name}_R2.fastq"
    threads: 8
    params:
        tmpdir = config['tmp_dir']
        outdir = config['fastq_out']
    shell:
        """
        fasterq-dump –-threads {threads} –-progress --O {params.outdir} --temp {params.tmpdir} {wildcards.sample_name}
        """