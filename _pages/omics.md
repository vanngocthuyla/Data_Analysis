---
layout: page
title: Omics Analysis
sitemap: false
permalink: /omics
---


# Transcriptomic Analysis

Whole transcriptome sequencing data or RNA-sequencing data serves as a valuable resource to elucidate the fundamental molecular mechanisms of biological conditions, offering a molecular foundation for addressing questions of interest. The analysis of treatment and control datasets allows the identification of differentially expressed genes (DEGs) in specific circumstances or cell subtypes. Comparing these DEGs with reported markers facilitates the diagnosis of genetic diseases. Additionally, quantifying DEGs reveals disease-induced expression patterns, offering insights into the disease stages.

I developed a pipeline to identify differentially expressed genes (DEGs) from RNA-sequencing data ([Van NT La et al., 2021](https://iopscience.iop.org/article/10.1088/1755-1315/749/1/012033/pdf)). 

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/Pipeline.png' width="800"> </div>   

Subsequently, [functional annotation](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/Annotation) can be applied to gather insights into the molecular functions, biological roles, and subcellular locations of the identified DEGs. Although this project primarily focuses on rubber trees, the pipeline is versatile and can be adapted to analyze RNA-seq data from other sources, provided the research objectives are clearly defined. 

After identifying DEGs, several machine learning methods can be employed for further analysis, encompassing tasks such as cell subtype classification and feature selection. Various supervised algorithms ([LDA](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/LDA), [Naive Bayes](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/Naive_Bayes), [SVM](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/SVM), [swLDA](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/swLDA), [Random Forest](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/RF)) and unsupervised methods ([Hclust](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/hclust), [K-means](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/kmean), [PCA](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/PCA)) have been showcased. The outcomes can be also effectively visualized through [heatmap](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/Heatmap) and [PCA plot](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/PCA_Plot). 


# Genomic Analysis

Human genomic data encompasses information about mutations associated with genetic diseases. These mutations may involve an extra copy of a chromosome, known as trisomy, occurring during fertilization. Alternatively, they could be copy number variants (CNV), where specific sequences of the genome are repeated. These variants often correlate with the earlier onset of symptoms and may be either genetically inherited or acquired during development.

With the availability of whole-genome sequencing (WGS) and whole exome sequencing (WES), an analysis pipeline can be constructed for the early identification of these mutations, providing valuable insights to mitigate risks for patients.

More information can be found at: [Idenfitication of Abnormality in Human Sequencing Data](https://vanngocthuyla.github.io/Data_Analysis/_pages/omics/NIPT) 
