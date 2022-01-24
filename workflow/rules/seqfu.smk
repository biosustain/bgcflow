rule seqfu_stats:
    input: 
        fna = expand("data/interim/fasta/{strains}.fna", strains = STRAINS)
    output:
        all_csv = "data/processed/tables/df_seqfu_stats.csv"
    conda:
        "../envs/seqfu.yaml"
    log: "workflow/report/logs/seqfu.log"
    shell:
        """
        seqfu stats {input.fna} --csv -b > {output.all_csv}
        head {output.all_csv} > {log}
        """