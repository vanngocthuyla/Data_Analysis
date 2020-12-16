Comparison of the three PPLs (numpyro, pyro and pymc3) for running the ITC (isothermal titration calorimetry) data

## 1. Introduction to the data

Data of ITC to running the Bayesian model: [Mg1EDTAp1a.DAT](https://github.com/vanngocthuyla/bitc/inputs/)

## 2. Bayesian Models

[Reference 1](https://github.com/choderalab/bayesian-itc) and [Reference 2](https://github.com/nguyentrunghai/bayesian-itc/tree/d8cbf43240862e85d72d7d0c327ae2c6f750e600) 

## 3. Installation of three PPLs

- Numpyro: 
Numpyro v0.4.1, Numpy v1.18.5, Matplotlib v3.2.2, Arviz v0.10.0
- Pyro
Pyro v1.5.1, Torch v1.7.0, Numpy v1.18.5, Matplotlib v3.2.2, Arviz v0.10.0
- Pymc3
Pymc3 v3.8, Theano v1.0.5, Pandas v0.25, Arviz v0.4.1

## 4. Comparison of 3 PPLs

### Checking the convergence of 3 PPLs
- Numpyro
Trace plot
95% BCI
Summary
- Pyro
Trace plot
95% BCI
Summary
- Pymc3
Trace plot
95% BCI
Summary

### Comparison of 3 PPLs
- Time
- Gelman-rubin statistics 
- Plot mean/std with the functions of the number of samples

