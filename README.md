# Bayesian Quantile Regression

Implementation of Bayesian Quantile Regression (BQR) with the use of Stan and R languages for a single predictor variable, i.e.,  ***y** = b + w****x*** + ε. In constrast to tradition Linear Regression which estimates the conditional mean function, i.e., *E[**y**|**x**]*, BQR can be used to estimate any conditional quantile function of the form *q<sub>p</sub>(**y**|**x**)*, with *p* being the desired percentile. Bayesian inference is possible via the Asymmetric Laplace density function (see Yun & Moyeed, 2001). The **BQR.stan** script can be easily modified to accommodate multiple predictors.

<p align="center">
  <img src="quantile-regression.png"/>
</p>

**Reference**

1. Yu, K. and Moyeed, R.A., 2001. Bayesian quantile regression. *Statistics & Probability Letters, 54*(4), pp.437-447.
