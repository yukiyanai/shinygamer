if (!require(remotes)) install.packages("remotes")
if (!require(tidyverse)) {
  install.packages("tidyverse")
  library(tidyverse)
}
if (!require(stringi)) install.packages("stringi")
if (!require(gt)) {
  install.packages("gt")
  library(gt)
}
if (!require(webshot)) {
  install.packages("webshot")
  webshot::install_phantomjs()
}
if (!require(rgamer)) {
  remotes::install_github("yukiyanai/rgamer")
  library(rgamer)  
}
if (!require(shinyMatrix)) {
  install.packages("shinyMatrix")
  library(shinyMatrix)
} 
library(shiny)
