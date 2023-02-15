### Global data and mapping ----
library(tidyverse)
library(FSA)
ggplot(data = ChinookArg,
       mapping = aes(x = tl, y = w)) +
  geom_point()

### with no lefthand arguments ----
ggplot(ChinookArg, aes(x = tl, y = w)) +
  geom_point()

### Global data and local mapping ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w))

### Local data and local mapping ----
ggplot() +
  geom_point(data = ChinookArg,
             mapping = aes(x = tl, y = w))

### Save plot as object ----
p <- ggplot() +
  geom_point(data = ChinookArg,
             mapping = aes(x = tl, y = w))

## Themes and Labels ----

### bw theme ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  theme_bw() 

### dark theme ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  theme_dark()

### classic theme ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  theme_classic()

### classic with labels and larger font ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### ggthemes: wsj ----
library(ggthemes)
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20) +
  theme_wsj()

### ggthemes: economist ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20) +
  theme_economist()

### ggthemes: excel ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20) +
  theme_excel()

## geoms ----

### points ----
ggplot(data = ChinookArg) +
  geom_point(mapping = aes(x = tl, y = w)) + 
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### jittered points (needed) ----
library(FSAdata)
ggplot(data = StripedBass1) +
  geom_point(mapping = aes(x = ageO, y = ageS)) + #<<
  labs(x = "Otolith Age",  
       y = "Scale Age") + 
  theme_classic(base_size = 20)

### jittered points ----
ggplot(data = StripedBass1) +
  geom_jitter(mapping = aes(x = ageO, y = ageS)) + #<<
  labs(x = "Otolith Age",  
       y = "Scale Age") + 
  theme_classic(base_size = 20)

### boxplot ----
ggplot(data = ChinookArg) +
  geom_boxplot(mapping = aes(x = loc, y = tl)) + #<<
  labs(x = "Location",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### histogram ----
ggplot(data = ChinookArg) +
  geom_histogram(mapping = aes(x = w), bins = 12) + #<<
  labs(x = "Weight (g)",  
       y = "Count") + 
  theme_classic(base_size = 20)

### density plot ----
ggplot(data = ChinookArg) +
  geom_density(mapping = aes(x = tl), fill = "gray") + #<<
  labs(x = "Total Length (mm)",  
       y = "Density") + 
  theme_classic(base_size = 20)

### multiple geoms (same geom) ----
ggplot(data = ChinookArg) +
  geom_density(aes(x = tl, fill = loc), alpha = 0.5) + #<<
  labs(x = "Total Length (mm)",  
       y = "Density") + 
  theme_classic(base_size = 20)

### multiple geoms (different geoms) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = loc)) + 
  geom_smooth(method = "lm", #<<
              aes(x = tl, y = w, #<<
                  color = loc, fill = loc)) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

## Scales ----

### color (not mapped) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w), color = "red") + 
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color (mapped to data) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = loc)) + 
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color (common error) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = "red")) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color scale (discrete) ----
library(RColorBrewer)
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = loc)) + 
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color scale (continuous) ----
library(viridis)
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = tl)) + 
  scale_color_viridis(direction = -1, option = "C") + 
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color (hexcode) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, color = loc)) + 
  scale_color_manual(values = c("#173f5f","#3caea3","#ed553b")) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color and fill ----
ggplot(data = ChinookArg) +
  geom_boxplot(mapping = aes(x = loc, y = w),
               color = "#D55E00", fill = "#E69F00") +
  labs(x = "Location",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color and fill ----
ggplot(data = ChinookArg) +
  geom_boxplot(aes(x = loc, y = w),
               color = "#D55E00", fill = "#E69F00") +
  geom_point(aes(x = loc, y = w, size = w),
             alpha = 0.3) +
  labs(x = "Location",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color and fill ----
ggplot(data = ChinookArg) +
  geom_boxplot(aes(x = loc, y = w),
               color = "#D55E00", fill = "#E69F00") + 
  geom_jitter(aes(x = loc, y = w, size = w),
              width = 0.1, alpha = 0.3) +
  labs(x = "Location",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

### color and fill ----
ggplot(data = ChinookArg) +
  geom_jitter(aes(x = loc, y = w, size = w),
              width = 0.1) +
  geom_boxplot(aes(x = loc, y = w), 
               alpha = 0.5,
               color = "#D55E00", fill = "#E69F00") +
  labs(x = "Location",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

## Other Scales ----

### shape ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, 
                 shape = loc, col = loc),
             size = 2) + 
  scale_color_manual(values = c("#173f5f","#3caea3","#ed553b")) +
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20)

## Faceting ----

### facet wrap ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, col = loc)) + 
  scale_color_manual(values = c("#173f5f","#3caea3","#ed553b")) + 
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20) +
  theme(legend.position = "none") +
  facet_wrap(~loc) 

### facet wrap (adjust columns) ----
ggplot(data = ChinookArg) +
  geom_point(aes(x = tl, y = w, col = loc)) + 
  geom_smooth(method = "lm", 
              aes(x = tl, y = w, 
                  color = loc)) + 
  scale_color_manual(values = c("#173f5f","#3caea3","#ed553b")) + #<<
  labs(x = "Total Length (mm)",  
       y = "Weight (g)") + 
  theme_classic(base_size = 20) +
  theme(legend.position = "none") +
  facet_wrap(~loc, ncol = 2) 

## Patchwork ----

### patchwork example ----
library(patchwork)
p1 <- ggplot(ChinookArg) + geom_point(aes(x = tl, y = w, col = loc))
p2 <- ggplot(ChinookArg) + geom_smooth(aes(x = tl, y = w))
p3 <- ggplot(ChinookArg) + geom_boxplot(aes(x = loc, y = w))
p4 <- ggplot(ChinookArg) + geom_boxplot(aes(x = loc, y = tl))
(p1 | p2 | p3) /
  p4

### Extensive Example ----
library(FSAdata)
ggplot(data = BullTroutRML2,
       aes(x = age, y = fl, col = era)) +
  geom_point(alpha = 0.5) + 
  geom_smooth(method="nls", data = BullTroutRML2,
              formula=y~Linf*(1-exp(-k*(x-0))), 
              method.args = list(start=c(Linf=400,k=1)),
              se=FALSE) +
  scale_color_manual(values = c("#173f5f","#ed553b")) +
  labs(x = "Age (years)",  
       y = "Fork Length (mm)",
       color = "Time Period") + 
  theme_classic(base_size = 20) +
  theme(strip.background = element_rect(fill="lightgray"),
        strip.text.x = element_text(size = 14, face = "bold"),
        legend.position = "top",
        legend.box.background=element_rect()) +
  facet_wrap(~lake) 

## Additional Resources ----

# ggplot2, Second Edition by Hadley Wickham
# https://ggplot2-book.org/

# R Graph Gallery
# https://www.r-graph-gallery.com/)

# ggplot2 website
# https://ggplot2.tidyverse.org/index.html)

# ggplot2 cheatsheet
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)

# Overview of color packages:
# https://github.com/EmilHvitfeldt/r-color-palettes

# Midway's github repo for ggplot
# https://github.com/stevemidway/ggSeminar

# Midway et al. 2023: Approaches for Figures
# https://aslopubs.onlinelibrary.wiley.com/doi/epdf/10.1002/lol2.10288

# Midway 2020: Effective Data Viz
# https://www.sciencedirect.com/science/article/pii/S2666389920301896

