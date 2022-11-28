#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process downloadFiles {
  publishDir params.outputDir, mode: "copy"
  
  input:
    val id
    
  output:
    path("${id}**.fastq")

  script:
    template 'downloadFiles.bash'
}


workflow download {

  take:

    accessions

  main:

    ids = Channel.fromList( accessions )
    downloadFiles(ids)
    
}