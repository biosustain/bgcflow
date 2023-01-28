rule metabase_install:
    output:
        jar="resources/metabase/metabase.jar",
    log:
        "workflow/report/logs/metabase_install.log",
    params:
        version="v0.45.2"
    shell:
        """
        wget -O {output.jar} https://downloads.metabase.com/{params.version}/metabase.jar 2>> {log}
        """

rule metabase_duckdb_plugin:
    output:
        plugin="resources/metabase/plugins/duckdb.metabase-driver.jar",
    log:
        "workflow/report/logs/metabase_duckdb_install.log",
    params:
        release="0.1.5"
    shell:
        """
        wget -O {output.plugin} https://github.com/AlexR2D2/metabase_duckdb_driver/releases/download/{params.release}/duckdb.metabase-driver.jar 2>> {log}
        """