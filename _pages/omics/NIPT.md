# Abnormality in Human Sequencing Data

## Introduction

Chromosomal anomalies are genetic disorders caused by abnormalities in the number or structure of chromosomes. These anomalies can involve either the loss or gain of entire chromosomes (aneuploidy) or structural changes such as duplications, deletions, or translocations. Chromosomal anomalies can lead to various developmental and health conditions in humans, including serious disorders like Down syndrome (trisomy 21), Edwards syndrome (trisomy 18), and Patau syndrome (trisomy 13). These disorders occur due to errors during cell division, which result in an extra copy or a missing chromosome in the affected individual's cells.

Chromosomal anomalies can arise spontaneously, often during the formation of eggs and sperm, but certain factors such as advanced maternal age can increase the risk. As a result, early detection of these anomalies is critical, particularly during pregnancy, to inform parents and clinicians about the health of the fetus.

## Current Methods for Identifying Chromosomal Anomalies

Chromosomal anomalies have been identified through invasive procedures such as amniocentesis and chorionic villus sampling (CVS), which involve extracting samples of amniotic fluid or placental tissue. While effective, these methods carry risks for both the mother and the fetus, such as miscarriage. In recent years, non-invasive prenatal testing (NIPT) has emerged as a safer alternative. NIPT analyzes fetal DNA fragments circulating in the maternal bloodstream, allowing for early detection of chromosomal abnormalities with minimal risk. Advances in high-throughput genomic technologies, particularly whole-genome sequencing (WGS), have further improved the accuracy of NIPT.

## Importance of Non-Invasive Prenatal Testing (NIPT)

NIPT is a significant breakthrough in prenatal care, offering a highly accurate, low-risk method to screen for chromosomal anomalies. It allows parents to make informed decisions without exposing the fetus to the risks associated with invasive testing methods. Additionally, NIPT can be performed early in pregnancy, providing timely information about the likelihood of trisomies such as trisomy 13, 18, and 21, and other chromosomal anomalies.

## Computational Analysis and Results

To develop a reliable non-invasive prenatal testing pipeline, I employed whole-genome sequencing (WGS) data to detect chromosomal anomalies such as trisomy 13, 18, and 21. The pipeline was built using [R](https://github.com/vanngocthuyla/Data_Analysis/tree/gh-pages/scripts/sequencing/NIPT.R) and informed by the methods established by Stephanie C. Yu and colleagues [1]. It was initially trained on normal cases from WGS samples to create a robust model for distinguishing between normal and abnormal chromosomal patterns.

The pipeline’s performance was visually represented by plotting patient samples on a graph, with each point indicating a sample’s chromosomal status. As seen in Figure 1, all data points for normal cases fall below the dashed line, confirming the pipeline's ability to accurately identify samples without chromosomal abnormalities.

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_Normal.jpg' width="800"> </div> 
<div align="center">Figure 1. Normal cases without chromosome abnormalities</div>

## Validation with Positive Cases

Testing datasets from the research of Stephanie C. Yu [1], which included 21 cases of trisomy 13, 27 cases of trisomy 18, and 36 cases of trisomy 21, were used to validate the pipeline's performance. The results demonstrated that the pipeline accurately identified all cases of trisomy 13 (Figure 2A) and trisomy 21 (Figure 2C), with 100% sensitivity and specificity. For trisomy 18, the pipeline correctly identified 26 out of 27 cases, with one false negative (Figure 2B), leading to an accuracy rate of 98.81%.

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T13.jpg' width="800"> </div>
<div align="center">A</div>

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T18.jpg' width="800"> </div>  
<div align="center">B</div>

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T21.jpg' width="800"> </div>
<div align="center">C</div>
<div align="center">Figure 2. Testing datasets for NIPT</div>

## Summary and Conclusion

The non-invasive prenatal testing (NIPT) pipeline developed in this study offers a highly accurate and reliable method for detecting chromosomal anomalies, specifically trisomy 13, 18, and 21. With 100% accuracy for trisomy 13 and 21, and 98.81% for trisomy 18, the pipeline demonstrated its effectiveness in identifying these critical conditions. The use of whole-genome sequencing (WGS) data allowed for comprehensive analysis, and the application of this pipeline in prenatal care can significantly reduce the need for invasive testing, making early detection safer for both mother and fetus.

In conclusion, this pipeline provides a scalable, efficient solution for non-invasive prenatal testing, enabling early diagnosis of chromosomal anomalies and contributing to improved prenatal care and informed decision-making.

**Reference:**

[1] Size-based molecular diagnostics using plasma DNA for noninvasive prenatal testing", Stephanie C. Y. Yu, K. C. Allen Chan Yama W. L. Zheng, Peiyong Jiang, Gary J. W. Liao Hao Sun, Ranjit Akolekarc, Tak Y. Leungd, Attie T. J. I. Goe, John M. G. van Vugte, Ryoko Minekawac, Cees B. M. Oudejanse, Kypros H. Nicolaidesc, Rossa W. K. Chiu and Y. M. Dennis Lo, 2014, PNAS.
