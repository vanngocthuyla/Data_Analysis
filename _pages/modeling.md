---
layout: page
title: Data modeling
permalink: /modeling
---


# Statistical modeling

In the initial phases of drug design, high-throughput screening assays can be conducted under biochemical/cellular conditions to generate concentration-response datasets. Fitting curves to these datasets using classical Hill equations provides the estimation IC50,  an important metric for comparing the potency of various compounds. Typically, controls in the assay are utilized for response normalization but not for curve fitting. Our research demonstrates that incorporating controls can enhance the accuracy of IC50 estimation, particularly for incomplete curves [[Ref](https://pubs.acs.org/doi/10.1021/acs.jmedchem.3c00107)].

We are also interested in analyzing datasets from various analytical techniques, delving into the binding processes of enzymes and ligands to gain insights into enzymatic mechanisms and facilitate drug development. We aim to improve accuracy in model estimation, and subsequently, enhance the quantification of binding parameters. Among multiple techniques, our focus has been on Isothermal Titration Calorimetry (ITC), where Bayesian regression is employed for dataset analysis. Additional information can be found below:

- [Comparison](https://vanngocthuyla.github.io/Data_Analysis/_pages/modeling/bitc-PPL-benchmark) of the three PPLs (numpyro, pyro and pymc3) for running the ITC (isothermal titration calorimetry) data;
- Bayesian Regression and Model Selection for Isothermal Titration Calorimetry with Enantiomeric Mixtures [[Ref](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0273656)];
- Bayesian Regression Quantifies Uncertainty of Binding Parameters from Isothermal Titration Calorimetry More Accurately Than Error Propagation [[Ref](https://www.mdpi.com/1422-0067/24/20/15074)].
