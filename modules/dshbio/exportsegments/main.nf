process DSHBIO_EXPORTSEGMENTS {
    tag "${meta.id}"
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::dsh-bio=2.0.6" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/dsh-bio:2.0.6--hdfd78af_0' :
        'quay.io/biocontainers/dsh-bio:2.0.6--hdfd78af_0' }"

    input:
    tuple val(meta), path(gfa)

    output:
    tuple val(meta), path("*.fa"), emit: fasta
    path "versions.yml"              , emit: versions

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.suffix ? "${meta.id}${task.ext.suffix}" : "${meta.id}"
    """
    dsh-bio \\
        export-segments \\
        $args \\
        -i $gfa \\
        -o ${prefix}.fa

    cat <<-END_VERSIONS > versions.yml
    ${task.process.tokenize(':').last()}:
        dshbio: \$(dsh-bio --version 2>&1 | grep -o 'dsh-bio-tools .*' | cut -f2 -d ' ')
    END_VERSIONS
    """
}
