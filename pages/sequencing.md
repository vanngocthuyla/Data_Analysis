# Transcriptomic Analysis:

Whole transcriptome sequencing data or RNA-sequencing data serves as a valuable resource to elucidate the fundamental molecular mechanisms of biological conditions, offering a molecular foundation for addressing questions of interest. The analysis of treatment and control datasets allows the identification of differentially expressed genes (DEGs) in specific circumstances or cell subtypes. Comparing these DEGs with reported markers facilitates the diagnosis of genetic diseases. Additionally, quantifying DEGs reveals disease-induced expression patterns, offering insights into the disease stages.

The pipeline developed to identify DEGs from RNA-sequencing data can be found at the link below: 
- Profiling and [Annotation](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/Annotation) of the set of RNA transcripts under specific circumstances or in specific cells.

While this work primarily centers around rubber trees, the pipeline is adaptable for the analysis of RNA-seq data from any other source with similar objectives. 

After identifying DEGs, machine learning methods can be employed for further analysis, encompassing tasks such as cell subtype classification and feature selection. Various supervised algorithms ([LDA](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/LDA), [Naive Bayes](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/Naive_Bayes), [SVM](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/SVM), [swLDA](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/swLDA), [Random Forest](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/RF)) and unsupervised methods ([Hclust](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/hclust), [K-means](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/kmean), [PCA](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/PCA)) have been showcased. The outcomes can be also effectively visualized through [heatmap](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/Heatmap) and [PCA plot](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/PCA_Plot). 


# Genomic Analysis

Human genomic data encompasses information about mutations associated with genetic diseases. These mutations may involve an extra copy of a chromosome, known as trisomy, occurring during fertilization. Alternatively, they could be copy number variants (CNV), where specific sequences of the genome are repeated. These variants often correlate with the earlier onset of symptoms and may be either genetically inherited or acquired during development.

With the availability of whole-genome sequencing (WGS) and whole exome sequencing (WES), an analysis pipeline can be constructed for the early identification of these mutations, providing valuable insights to mitigate risks for patients.

More information can be found at: [Idenfitication of Abnormality in Human Sequencing Data](https://vanngocthuyla.github.io/Data_Analysis/pages/sequencing/NIPT) 
