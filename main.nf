#!/usr/bin/env nextflow
nextflow.enable.dsl=2
import nextflow.splitter.CsvSplitter

def fetchRunAccessions( tsv ) {
    def splitter = new CsvSplitter().options( header:true, sep:'\t' )
    def reader = new BufferedReader( new FileReader( tsv ) )
    splitter.parseHeader( reader )
    List<String> run_accessions = []
    Map<String,String> row
    while( row = splitter.fetchRecord( reader ) ) {
       run_accessions.add( row['run_accession'] )
    }
    return run_accessions
}

accessions = fetchRunAccessions( params.inputFile )

//--------------------------------------------------------------------------
// Includes
//--------------------------------------------------------------------------

include { download } from './modules/download.nf'

//--------------------------------------------------------------------------
// Main Workflow
//--------------------------------------------------------------------------

workflow {
  download(accessions)
}