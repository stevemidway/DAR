# Anscombe's Quartet Tutorial

# Load necessary library
library(tidyverse)

# Load Anscombe's quartet data (built-in dataset in R)
data(anscombe)

# Reshape the data for ggplot2
anscombe_long <- data.frame(
  x = c(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4),
  y = c(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4),
  set = factor(rep(1:4, each = 11))
)

# Numerical summaries
# Calculate means, standard deviations, and correlations for each dataset
anscombe_long %>% 
  group_by(set) %>%
  summarize(mean_x = mean(x),
            mean_y = mean(y),
            var_x = var(x),
            var_y = var(y))


# Plot Anscombe's quartet
ggplot(anscombe_long, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 2) +
  geom_smooth(method = "lm", se = FALSE, 
              color = "red", linetype = "dashed") +
  facet_wrap(~set) +
  theme_classic() +
  labs(title = "Anscombe's Quartet: The Importance of Visualization",
       subtitle = "All datasets have the same statistical properties!",
       x = "X Values",
       y = "Y Values")


