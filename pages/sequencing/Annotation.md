# Homology-based Annotation
Homology-based Annotation for the list of DEGs (Differentially Expressed Genes) in interest

## Introduction

The list of DEGs between two or more environmental conditions can be retrieved from samples of RNA-seq data by Tuxedo/New-Tuxedo package. Since the functional annotation of DEGs are not always ready, we introduced the homology-based annotation using the coding sequences of DEGs. 

## The annotation includes:  
* Run blastx in Blast2GO and compare the blastx results from different databases

The coding sequences of DEGs between two conditions can be annotated by homology sequences in four databases: NR, UniProt/SwissProt, Reference Protein and KEGG. Venn Diagrams plots the results and compare the list of DEGs annotated from each database.   

* Run InterProScans and retrieve GO terms of DEGs for GO enrichment

InterProScan first can be run through available tool named "Interproscan functional predictions of ORFs" in GALAXY platform or Blast2GO softwares. The results can be saved under .tabular or .xml format. In GALAXY platform, you can choose "Include Gene Ontology (GO) mappings" to retrieve the GO terms of DEGs together with IPS terms. In Blast2GO software, you need to run additional steps to convert IPS terms to GO terms.  

* Run KEGG annotation and draw KEGG pathway(s) in interest  

The example results shows the KEGG pathways of DEGs belonging to terpenoid backbone biosynthesis. The colored boxes are the DEGs.  

## Results  

- Blast2GO results of some DEGs including Blastx description, IPS terms, GO terms and GO names  

|SeqName|Description_Blastx|InterPro IDs|GO IDs|GO Names|
|-------|------------------|------------|------|--------|
|CDS_01|uncharacterized protein|IPR024738 (PFAM); IPR024738 (PTHR21277:PANTHER); IPR024738 (PANTHER)|C:GO:0070461|C:SAGA-type complex|
|CDS_02|---NA---|no IPS match|no IPS match|no IPS match|
|CDS_03|uncharacterized protein|PTHR33181:SF19 (PANTHER); PTHR33181 (PANTHER)|no GO terms|no GO terms|
|CDS_04|copper transport protein ATX1-like|G3DSA:3.30.70.100 (GENE3D); IPR006121 (PFAM); IPR006121 (PANTHER); IPR006121 (PTHR22814:PANTHER); IPR006121 (PROSITE_PROFILES); IPR036163 (SUPERFAMILY)|P:GO:0030001; F:GO:0046872|P:metal ion transport; F:metal ion binding|
|CDS_05|hypothetical protein MANES_06G110000|PTHR34656:SF2 (PANTHER); PTHR34656 (PANTHER)|no GO terms|no GO terms|
|CDS_06|copper transport protein ATX1-like|IPR006121 (PFAM); IPR006121 (G3DSA:3.30.70.GENE3D); IPR006121 (PTHR22814:PANTHER); IPR006121 (PANTHER); IPR006121 (PROSITE_PROFILES); IPR036163 (SUPERFAMILY)|P:GO:0030001; F:GO:0046872|P:metal ion transport; F:metal ion binding|
|CDS_07|hypothetical protein MANES_06G110000|PTHR34656:SF2 (PANTHER); PTHR34656 (PANTHER)|no GO terms|no GO terms|
|CDS_08|pentatricopeptide repeat-containing protein|IPR011990 (G3DSA:1.25.40.GENE3D); IPR002885 (PFAM); IPR011990 (G3DSA:1.25.40.GENE3D); IPR032867 (PFAM); IPR002885 (PFAM); IPR002885 (PANTHER)|F:GO:0005515; F:GO:0008270|F:protein binding; F:zinc ion binding|
|CDS_09|probable cyclic nucleotide-gated ion channel 20|IPR005821 (G3DSA:1.10.287.GENE3D); IPR014710 (G3DSA:2.60.120.GENE3D); IPR014710 (PANTHER); IPR014710 (PTHR45651:PANTHER); IPR000595 (PROSITE_PROFILES); IPR018490 (SUPERFAMILY); IPR018490 (SUPERFAMILY)|F:GO:0005216; P:GO:0006811; C:GO:0016020; P:GO:0055085|F:ion channel activity; P:ion transport; C:membrane; P:transmembrane transport|
|CDS_10|transcription factor bHLH149-like|IPR036638 (G3DSA:4.10.280.GENE3D); IPR036638 (PANTHER); IPR036638 (PTHR33124:PANTHER); IPR011598 (PROSITE_PROFILES); IPR036638 (SUPERFAMILY)|F:GO:0046983|F:protein dimerization activity|
  
- Venn Diagram for DEGs annotated of 4 different databases: NR, UniProt, RefSeq and KEGG  

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/sequencing/Venn_Diagram_for DEGs_annotated.jpg' width="400"> </div>   
  
- KEGG pathway of DEGs in the terpenoisd biosynthesis:   

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/sequencing/KEGG_TPS_Biosynthesis.jpg' width="1200"> </div>  
