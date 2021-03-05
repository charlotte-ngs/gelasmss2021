#' ---
#' title: Convert Solutions To Exercises
#' date: 2021-03-05
#' ---
#'
#' # Disclaimer
#' Experiments on how to convert Rmarkdown documents that contain solutions to exercises to exercise documents.
#'
#'
#' # Approaches
#' There are several approaches to solve the problem of converting a solutions document to an exericse.
#'
#' 1. Parametrized Rmarkdown
#' 2. Conversion function
#'
#'
#' ## Conversion Function
#' This solution consists of reading the Rmd source file into a vector, search for the solution section using
#' `grep()` and cutting out all lines that belong to the solution function. This can work but is tedious and
#' cumbersome to maintain. The advantage of this approach is that the result is a Rmd file that can be used
#' to be handed out to students.
#'
#'
#' ## Parametrized Rmarkdown
#' In the yaml-header of the Rmd source file a parameter is inserted. This can be used to print comment signs
#' around the solution section whenever a pdf for the exercise is to be created. This can only be used, if
#' the Rmd source file is not distributed to students.
#'
#' The parameter based approach can also be used from the console by passing the parameters as a list to the
#' `rmarkdown::render()` function. The following function can be used for deployment
deploy_ex <- function(ps_ex_name){
  # check for file extension
  if (tolower(tools::file_ext(ps_name)) == 'rmd'){
    s_ex_name <- ps_ex_name
  } else {
    s_ex_name <- paste(ps_ex_name, '.Rmd', sep = '')
  }
  # add directory path
  s_ex_path <- file.path(here::here(), 'ex', s_ex_name)

}
