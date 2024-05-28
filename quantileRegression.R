# load required packages

library("quantreg")
library("rstan")
library("parallel")

# read data

data <- read.csv("data-example.csv")

# scatterplot of data

plot(Response ~ Predictor, data = data)

# fit Quantile Regression (50th percentile) by numerical optimization

model.fit <- rq(Response ~ Predictor,
                tau = 0.50,
                data = data,
                model = TRUE)

# print estimated coefficients

cat(paste0("Intercept = ", model.fit[["coefficients"]][1]))
cat(paste0("Slope = ", model.fit[["coefficients"]][2]))

# scatterplot of data with line

plot(
  Response ~ Predictor,
  data = data,
  pch = 21,
  col = "black",
  bg = "gray"
)
abline(model.fit, col = "blue", lwd = 1.5)

# fit Quantile Regression (95th percentile) by numerical optimization

model.fit <- rq(Response ~ Predictor,
                tau = 0.95,
                data = data,
                model = TRUE)

abline(model.fit, col = "red", lwd = 1.5)
legend(
  x = "topleft",
  legend = c("0.50 Quantile", "0.95 Quantile"),
  lty = c(1, 1),
  col = c("blue", "red"),
  lwd = 1.5
)

# number of MCMC chains

nc <- 4
Sys.setenv("MC_CORES" = nc)

# compile Bayesian Quantile Regression model

bayesian.model <- stan_model("BQR.stan")

# sample from the posterior (50th percentile)

feed.data <-
  list(
    N = nrow(data),
    x = data[["Predictor"]],
    y = data[["Response"]],
    p = 0.50
  )

fit.model <-
  sampling(
    object = bayesian.model,
    data = feed.data,
    chains = nc,
    cores = nc,
    iter = 4000,
    warmup = 2000,
    seed = 1999,
    control = list(adapt_delta = 0.97, max_treedepth = 12),
    sample_file = "Chain.txt",
    verbose = TRUE,
    show_messages = TRUE
  )

# save Bayesian summary results

results <- summary(fit.model)$summary
results <- as.data.frame(results)

# print posterior means

cat(paste0("Intercept = ", results[["mean"]][1]))
cat(paste0("Slope = ", results[["mean"]][2]))
