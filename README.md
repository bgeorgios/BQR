# Bayesian Quantile Regression

Implementation of Bayesian Quantile Regression (BQR) with the use of Stan and R for a single predictor variable, i.e.,  ***y** = b + w****x***. In constrast to tradition Linear Regression which estimates the conditional mean function, i.e., *E[**y**|**x**]*, BQR can be used to estimate any conditional quantile function of the form *q<sub>p</sub>(**y**|**x**)*, with *p* being the desired percentile.

<p align="center">
  <img src="quantile-regression.png"/>
</p>
