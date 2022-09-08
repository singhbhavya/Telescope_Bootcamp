#! /usr/bin/env python
# -*- coding: utf-8 -*-

# Rule to download FASTQs, based on samples from the config.

rule fasterq_dump:
    conda: "../envs/sra_toolkit.yaml"
    output:
        R1 = "runs/{s}/{s}_1.fastq"
        R2 = "runs/{s}/{s}_2.fastq"
    threads: 8
    params:
        tmpdir = config['fasterq_dump_tmp'],
        outdir = "runs/{s}"
    shell:
        """
        fasterq-dump –-threads {threads} –-progress --O {params.outdir} --temp {params.tmpdir} {wildcards.s}
        """
