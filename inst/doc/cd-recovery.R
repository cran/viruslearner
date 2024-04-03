## ----basal, message=FALSE-----------------------------------------------------
library(tidyverse)
library(viraldomain)
data(viral, package = "viraldomain")
recovery_rates <- viral |>
  mutate(
    recovery_rate_2021 = (cd_2021 - cd_2019) / cd_2019,
    recovery_rate_2022 = (cd_2022 - cd_2021) / cd_2021,
    recovery_rate_2022_2yr = (cd_2022 - cd_2019) / cd_2019,
    viral_rate_2021 = (vl_2021 - vl_2019) / (vl_2019+1),
    viral_rate_2022 = (vl_2022 - vl_2021) / (vl_2021+1),
    viral_rate_2022_2yr = (vl_2022 - vl_2019) / (vl_2019+1)
  )

## ----longplot, echo = FALSE, fig.cap="Cohort’s response to ART from 2019 to 2022. A, Viral load (HIV RNA copies/mL blood). B, CD4 T cell count (cells/mm3 blood)"----
library(ggpubr)
library(tidyr)
ggarrange(
  viral |>
    pivot_longer(cols = starts_with("vl_"), names_to = "year_vl", values_to = "VL") |>
    ggplot(aes(x = year_vl, y = log10(VL+1))) + 
    geom_boxplot() + 
    labs(x = "Year", y = "Log10(HIV RNA copies/mL)") + 
    theme_bw(),
  viral |>
    pivot_longer(cols = starts_with("cd_"), names_to = "year_cd", values_to = "CD") |>
    ggplot(aes(x = year_cd, y = CD)) + 
    geom_boxplot() + 
    labs(x = "Year", y = "CD4T cells/mm^3 blood") + 
    theme_bw(),
  labels = c("A", "B"), nrow = 2
  )

## ----rateplot, echo = FALSE, fig.cap="Patterns of HIV Viral Dynamics in Response to Treatment. A, Viral Load Change Rates Across Years. B, Longitudinal Analysis of CD4 T Cell Recovery Rates Over Time."----
ggarrange(
  recovery_rates |>
    pivot_longer(cols = starts_with("viral_"), names_to = "year_vr", values_to = "VR") |>
    ggplot(aes(x = year_vr, y = log10(VR+1))) + 
    geom_boxplot() + 
    labs(x = "Year", y = "Viral load change rate") + 
    theme_bw(),
  recovery_rates |>
    pivot_longer(cols = starts_with("recovery_"), names_to = "year_rr", values_to = "RR") |>
    ggplot(aes(x = year_rr, y = RR)) + 
    geom_boxplot() + 
    labs(x = "Year", y = "CD4T Cell Recovery Rate") + 
    theme_bw(),
  labels = c("A", "B"), nrow = 2
  )

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

