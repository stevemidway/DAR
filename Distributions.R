# Load libraries
library(tidyverse)

# Set seed for reproducibility
set.seed(123)

# Sample sizes
sample_sizes <- c(10, 25, 100)

# Normal Distribution Parameters
mean_norm <- 0
sd_norm <- 1

# Binomial Distribution Parameters
size_binom <- 10
prob_binom <- 0.5

# Poisson Distribution Parameters
lambda_pois <- 3

# Create empty data frame to store all samples
all_samples <- data.frame()

# Loop through each sample size and distribution
for (n in sample_sizes) {
  
  # Normal Distribution
  norm_samples <- rnorm(n, mean = mean_norm, sd = sd_norm)
  norm_df <- data.frame(
    value = norm_samples,
    distribution = "Normal",
    sample_size = paste("n =", n)
  )
  
  # Binomial Distribution
  binom_samples <- rbinom(n, size = size_binom, prob = prob_binom)
  binom_df <- data.frame(
    value = binom_samples,
    distribution = "Binomial",
    sample_size = paste("n =", n)
  )
  
  # Poisson Distribution
  pois_samples <- rpois(n, lambda = lambda_pois)
  pois_df <- data.frame(
    value = pois_samples,
    distribution = "Poisson",
    sample_size = paste("n =", n)
  )
  
  # Combine data for all distributions
  all_samples <- bind_rows(all_samples, norm_df, binom_df, pois_df)
}

# Organize and label
all_samples$distribution <- factor(all_samples$distribution, 
                                   levels = c("Normal", "Binomial", "Poisson"))
all_samples$sample_size <- factor(all_samples$sample_size, 
                                  levels = c("n = 10", "n = 25", "n = 100"))

# Plot all distributions using ggplot2
ggplot(all_samples, aes(x = value, fill = distribution)) +
  geom_histogram(color = "black", bins = 10, alpha = 0.7) +
  facet_grid(distribution ~ sample_size, scales = "free") +
  scale_fill_manual(values = c("Normal" = "#26547c", 
                               "Binomial" = "#ef476f", 
                               "Poisson" = "#ffd166")) +
  labs(title = "Normal, Binomial, and Poisson Distributions",
       x = "Value",
       y = "Frequency",
       fill = "Distribution") +
  theme_classic() +
  theme(strip.text = element_text(size = 12),
        legend.position = "none")
