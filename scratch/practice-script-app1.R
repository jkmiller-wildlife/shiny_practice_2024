# load packages ---- 
library(palmerpenguins)
library(tidyverse)

# filter penguins df for obs where body mass is >= 3000 & <= 4000 ----
body_mass_df <- penguins %>% 
  filter(body_mass_g %in% c(3000:4000))


# create scatterplot ----
ggplot(na.omit(body_mass_df),
       aes(x = flipper_length_mm, y = bill_length_mm,
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("darkorange", "purple", "cyan4")) +
  scale_shape_manual(values = c(19, 17, 15)) +
  labs(x = "Flipper Length (mm)", y = "Bill Length (mm)", color = "Penguin species",
       shape = "Penguin species") +
  theme_minimal() +
  theme(legend.position = c(0.85, 0.2),
        legend.background = element_rect(color = "white"))

