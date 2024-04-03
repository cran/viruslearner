#' Viral New Dataset
#'
#' @description The dataset contains information about patients, specifically 
#' their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, cd_2023) and 
#' viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling patient 
#' recovery and viral load persistence or suppression, column `cd_2023` is 
#' identified as the outcome variable for CD4 cell counts, and column `vl_2023` 
#' is identified as the outcome variable for viral load. 
#'
#' @format A data frame with 87 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("viral_new", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(viral_new)
#' }
"viral_new"


#' Viral Rates Dataset
#'
#' @description The dataset contains information about patients, specifically 
#' their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, cd_2023) and 
#' viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling patient 
#' recovery and viral load persistence or suppression, column `cd_2023` is 
#' identified as the outcome variable for CD4 cell counts, and column `vl_2023` 
#' is identified as the outcome variable for viral load. The data also 
#' contains information about variables related to adherence to antiretroviral 
#' therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 87 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("viralrates", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(viralrates)
#' }
"viralrates"


#' Viral Rates Dataset for Training CD4 Counts Outcome
#'
#' @description This training dataset contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient recovery, column `cd_2023` is identified as the outcome variable. 
#' The dataset also contains information about variables related to adherence to 
#' antiretroviral therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 65 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("cd_train", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(cd_train)
#' }
"cd_train"


#' Viral Rates Dataset for Training Viral Load Outcome
#'
#' @description The training dataset contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient viral load persistence or suppression, column `vl_2023` is 
#' identified as the outcome variable. The dataset also contains information 
#' about variables related to adherence to antiretroviral therapy (ART) and cell 
#' recovery and viral change rates.
#'
#' @format A data frame with 65 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("vl_train", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(vl_train)
#' }
"vl_train"


#' Viral Rates Dataset for Testing CD4 Counts Outcome
#'
#' @description This testing dataset contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient recovery, column `cd_2023` is identified as the outcome variable. 
#' The dataset also contains information about variables related to adherence to 
#' antiretroviral therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 22 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("cd_test", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(cd_test)
#' }
"cd_test"


#' Viral Rates Dataset for Testing Viral Load Outcome
#'
#' @description This testing dataset contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient viral load persistence or suppression, column `vl_2023` is 
#' identified as the outcome variable. The dataset also contains information 
#' about variables related to adherence to antiretroviral therapy (ART) and cell 
#' recovery and viral change rates.
#'
#' @format A data frame with 22 rows and 21 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("vl_test", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(vl_test)
#' }
"vl_test"


#' Mortality Dataset
#'
#' @description contains information about patients with various medical 
#' conditions. It includes patient demographics, comorbidities, infection sites, 
#' severity scores, mortality status, length of stay and age group.
#'
#' @format A data frame with 123 rows and 25 variables:
#' \describe{
#'   \item{V1}{Patient ID.}
#'   \item{V2}{Age of the patient.}
#'   \item{V3}{Gender of the patient.}
#'   \item{V4}{Wheter the patient has sepsis.}
#'   \item{COMORBILIDAD}{Wheter the patient has diabetes mellitus.}
#'   \item{V6}{Wheter the patient has arterial hypertehsion.}
#'   \item{V7}{Wheter the patient is obese.}
#'   \item{V8}{Whether the patient has Chronic Obstructive Pulmonary Disease.}
#'   \item{V9}{Whether the patient has Chronic Kidney Disease.}
#'   \item{V10}{Whether the patient has other comorbidities.}
#'   \item{SITIOSDEINFECCIÓN}{Site of pulmonary infection.}
#'   \item{V12}{Site of urinary infection.}
#'   \item{V13}{Site of abdominal infection.}
#'   \item{V14}{Site of soft tissue infection.}
#'   \item{V15}{Site of urinary infection.}
#'   \item{V16}{Site of other infection.}
#'   \item{V17}{Q SOFA score}
#'   \item{V18}{NEWS 2 score}
#'   \item{V19}{Total NEWS 2 score}
#'   \item{V20}{SOFA score}
#'   \item{V21}{Total SOFA score}
#'   \item{V22}{Severity of the patient's conditions }
#'   \item{V23}{Whether the patient survived or died}
#'   \item{V24}{Length of stay in hours}
#'   \item{Agrupada}{Age group}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("mortality", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(mortality)
#' }
"mortality"


