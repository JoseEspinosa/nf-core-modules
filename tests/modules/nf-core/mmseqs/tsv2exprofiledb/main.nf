#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MMSEQS_TSV2EXPROFILEDB } from '../../../../../modules/nf-core/mmseqs/tsv2exprofiledb/main.nf'

workflow test_mmseqs_tsv2exprofiledb {

    input = file(params.test_data['sarscov2']['illumina']['test_single_end_bam'], checkIfExists: true)

    MMSEQS_TSV2EXPROFILEDB ( input )
}
