rule telescope:
		input:
				alignments: "telescope/data/{sample}/{sample}.sam"
				annotation: "telescope/data/{sample}/{sample}.gtf"
		threads: snakemake.utils.available_cpu_count()
		params:
				temp: "telescope/output/{sample}/temp/"
		log: "telescope/logs/{sample}.log"
		shell:
				"""
				telescope bulk assign \
				--logfile {log} \
				--tempdir {params.temp} \
				--debug \
				{input.alignments} {input.annotation}				
				"""