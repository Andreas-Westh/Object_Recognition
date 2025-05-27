library(tidyverse)
library(keras)
library(imager)
library(purrr)
#install_tensorflow()
#install_tensorflow(method = "conda", conda_python_version = "3.10")
library(reticulate)
use_condaenv("r-tensorflow", required = TRUE)
library(tensorflow)





parrots <- load.example("parrots") %>% as.data.frame()
plot(parrots)



modnn <- keras_model_sequential () %>%
  layer_dense(units = 50,
                activation = "relu",
                input_shape = ncol(x)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 1)


