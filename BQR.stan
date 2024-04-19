/*
	Bayesian Quantile Regression
	© Georgios Boumis, 2024
	Contact: gboumis@ua.edu
*/

// function to return Asymmetric Laplace log-density (see Yu & Moyeed, 2001)
functions {
	real asymmetric_laplace(real y, real x, real b, real w, real p) {
		real mu = x * w + b;
		return log(p) + log1m(p) - 2 * ((y < mu) ? (1 - p) * (mu - y) : p * (y - mu));
	}
}
data {
	int<lower=0> N;
	real<lower=0, upper=1> p; // quantile
	vector[N] x; // predictor
	vector[N] y; // response
}
parameters {
	real b; // intercept
	real w; // slope
}
model {
	
	vector[N] LogLikelihood;
	
	for (i in 1:N){
		LogLikelihood[i] = asymmetric_laplace(y[i], x[i], b, w, p);
		target += LogLikelihood[i];
	}
}
