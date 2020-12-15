# Homology-based Annotation
Homology-based Annotation for the list of DEGs (Differentially Expressed Genes) in interest

## Introduction

The list of DEGs between two or more environmental conditions can be retrieved from samples of RNA-seq data by Tuxedo/New-Tuxedo package. Since the functional annotation of DEGs are not always ready, we introduced the homology-based annotation using the coding sequences of DEGs. 

## The annotation includes: 
1. Run blastx and compare the blastx results from different databases

The coding sequences of DEGs between two conditions can be annotated by homology sequences in four databases: NR, UniProt/SwissProt, Reference Protein and KEGG. Venn Diagrams plots the results and compare the list of DEGs annotated from each database. 

2. Run InterProScans and retrieve GO terms of DEGs for GO enrichment

InterProScan first can be run through available tool named "Interproscan functional predictions of ORFs" in GALAXY platform or Blast2GO softwares. The results can be saved under .tabular or .xml format. In GALAXY platform, you can choose "Include Gene Ontology (GO) mappings" to retrieve the GO terms of DEGs together with IPS terms. In Blast2GO software, you need to run additional steps to convert IPS terms to GO terms. 

3. Run KEGG annotation and draw KEGG pathway(s) in interest

The example results shows the KEGG pathways of DEGs belonging to terpenoid backbone biosynthesis. The colored boxes are the DEGs.

#### NOTE: Some useful codes can be found in 'codes' to retrieve the annotation and/or convert the ID from different databases.
