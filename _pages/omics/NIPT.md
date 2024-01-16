# Abnormality in Human Sequencing Data

Certain chromosomal anomalies such as trisomy 13 (Patau syndrome), 18 (Edwards syndrome), and 21 (Down syndrome) can be predicted through the analysis of whole-genome sequencing (WGS) data, serving as non-invasive prenatal testing (NIPT). The pipeline, constructed through [R code](https://github.com/vanngocthuyla/Data_Analysis/tree/gh-pages/scripts/sequencing/NIPT.R) and informed by the research of Stephanie C. Yu and colleagues [1], utilized a dataset of normal cases from WGS samples of patients for model training. The resulting figures, similar to figure 1 below, demonstrate that all data points, where each point signifies a patient sample, fall below the dashed line. This confirmed the pipeline's ability to detect all normal cases.

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/sequencing/NIPT_Normal.jpg' width="800"> </div> 
<div align="center">Figure 1. Normal cases without chromosome abnormalities</div>

Testing datasets, drawn from the research by Stephanie C. Yu, comprised 21 cases of trisomy 13, 27 cases of trisomy 18, and 36 cases of trisomy 21 [1]. These datasets were subsequently employed to evaluate the performance of the developed pipeline. The results indicated accurate identification, with 21 out of 21 positive cases of trisomy 13 (figure 2A) and 36 out of 36 positive cases of trisomy 21 (figure 2C) correctly identified, along with all correctly classified negative cases. In the case of trisomy 18, there was only one data point below the dashed line, representing a false negative result, while 26 out of 27 cases of trisomy 18 were still successfully detected (figure 2B).

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T13.jpg' width="800"> </div>
<div align="center">A</div>

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T18.jpg' width="800"> </div>  
<div align="center">B</div>

<div align="center"> <img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/NIPT_T21.jpg' width="800"> </div>
<div align="center">C</div>
<div align="center">Figure 2. Testing datasets for NIPT</div>

The testing results demonstrated that the pipeline achieved 100% accuracy in detecting trisomy 13 and 21, and 98.81% accuracy for trisomy 18.


**Reference:**

[1] Size-based molecular diagnostics using plasma DNA for noninvasive prenatal testing", Stephanie C. Y. Yu, K. C. Allen Chan Yama W. L. Zheng, Peiyong Jiang, Gary J. W. Liao Hao Sun, Ranjit Akolekarc, Tak Y. Leungd, Attie T. J. I. Goe, John M. G. van Vugte, Ryoko Minekawac, Cees B. M. Oudejanse, Kypros H. Nicolaidesc, Rossa W. K. Chiu and Y. M. Dennis Lo, 2014, PNAS.
