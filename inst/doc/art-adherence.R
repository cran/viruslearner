## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(viruslearner)

## ----coords, message=FALSE----------------------------------------------------
library(FactoMineR)
data(viral_new, package = "viruslearner")
res_pca <- PCA(viral_new, graph = FALSE)
print(res_pca)

## ----plotcoords, echo = FALSE, message = FALSE, fig.cap="PC1 vs PC2 dispersion. Specific features of the shape of ART trajectory as prognostic factor for overall treatment."----
library(tidyverse)
library(cowplot)
res_pca$ind$coord |>
    bind_cols(viral_new) |>
  ggplot(aes(x = Dim.1, y = Dim.2)) +
  geom_point(size = 1.5) +
  theme_half_open(12) + 
  background_grid()

## ----rotation-----------------------------------------------------------------
res_pca$var$coord

## ----plotrot, echo = FALSE, message = FALSE, fig.cap="Distribution of patients in the PC1 vs PC2 space. Contributions of baseline and longitudinal measures are reflected by the directions and magnitudes of the arrows."----
library(factoextra)
var_pca <- get_pca_var(res_pca)
fviz_pca_var(res_pca, col.var = "black")

## ----varpc--------------------------------------------------------------------
eig_val <- get_eigenvalue(res_pca)
eig_val

## ----plotvarpc, echo = FALSE, message = FALSE, fig.cap="Variance captured by each PC. Together, PC1 and PC2 provide structure into the factors influencing ART adherence and treatment effectiveness."----
fviz_eig(res_pca, addlabels = TRUE)

## ----outvspc, echo = FALSE, message = FALSE, warning = FALSE, fig.cap="Outcome variables vs first two PC's. A, Association of PC1 with cd_2022. B, Association of PC1 with vl_2022. C, Association of PC2 with cd_2022. D, Association of PC2 with vl_2022."----
library(ggpubr)
library(broom)
pca_fit <- viral_new |> 
  scale() |>
  prcomp()
variance_exp <- pca_fit |>  
  tidy("pcs") |> 
  pull(percent)
variance_exp <- pca_fit |>  
  tidy("pcs") |> 
  pull(percent)
ggarrange(
  res_pca$ind$coord |>
    bind_cols(viral_new) |>
    ggplot(aes(x = Dim.1, y = cd_2023)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(x = paste0("PC1: ", round(variance_exp[1]*100), "%"),
         y = "CD4T cells/mm blood") +
    theme_minimal_hgrid(12),
  res_pca$ind$coord |>
    bind_cols(viral_new) |>
    ggplot(aes(x = Dim.1, y = log10(vl_2023 + 1))) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(x = paste0("PC1: ", round(variance_exp[1]*100), "%"),
         y = "Log(HIV RNA copies/ml)") +
    theme_minimal_hgrid(12),
  res_pca$ind$coord |>
    bind_cols(viral_new) |>
    ggplot(aes(x = Dim.2, y = cd_2023)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(x = paste0("PC2: ", round(variance_exp[2]*100), "%"),
         y = "CD4T cells/mm blood") +
    theme_minimal_hgrid(12),
  res_pca$ind$coord |>
    bind_cols(viral_new) |>
    ggplot(aes(x = Dim.2, y = log10(vl_2023 + 1))) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(x = paste0("PC2: ", round(variance_exp[2]*100), "%"),
         y = "Log(HIV RNA copies/ml)") +
    theme_minimal_hgrid(12),
  labels = c("A", "B", "C", "D"), nrow = 2, ncol = 2
  )

## ----corpc--------------------------------------------------------------------
res_pca$ind$coord

