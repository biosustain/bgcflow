rule antismash_summary:
    input: 
        _all_ = expand("data/interim/antismash/{strains}/{strains}.gbk", strains=STRAINS),
        antismash_dir = "data/interim/antismash/",
        fna_dir = "data/interim/fasta/",
        df_samples = config["samples"],
    output:
        df_antismash_summary = "data/processed/tables/df_antismash_summary.csv"
    conda:
        "../envs/bgc_analytics.yaml"
    shell:
        """
        python workflow/bgcflow/bgcflow/data/make_genome_dataset.py {input.fna_dir} {input.antismash_dir} {input.df_samples} {output.df_antismash_summary}
        """