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
  if (tolower(tools::file_ext(ps_ex_name)) == 'rmd'){
    s_ex_name <- ps_ex_name
  } else {
    s_ex_name <- paste(ps_ex_name, '.Rmd', sep = '')
  }
  # add directory path and check
  s_ex_path <- file.path(here::here(), 'ex', s_ex_name)
  cat(" * Setting source path to: ", s_ex_path, '\n')
  if (!file.exists(s_ex_path))
    stop(" *** [deploy_ex] ERROR: CANNOT FIND exercise source path: ", s_ex_path)
  # determine path for output files
  s_ex_out_dir <- file.path(here::here(), 'docs', 'ex')
  if (!dir.exists(s_ex_out_dir)){
    cat(" * Creating ex out dir: ", s_ex_out_dir, '\n')
    dir.create(path = s_ex_out_dir, recursive = TRUE)
  }
  # render source file to exercise version
  s_ex_out_path <- file.path(s_ex_out_dir, paste(tools::file_path_sans_ext(s_ex_name), '.pdf', sep = ''))
  cat(" * Rendering ex source to: ", s_ex_out_path, '\n')
  rmarkdown::render(input = s_ex_path, output_file = s_ex_out_path, params = list(doctype = 'exercise'))
  # render source file to solution document
  s_sol_out_dir <- file.path(here::here(), 'docs', 'sol')
  if (!dir.exists(s_sol_out_dir)){
    cat(" * Creating sol out dir: ", s_sol_out_dir, '\n')
    dir.create(path = s_sol_out_dir, recursive = TRUE)
  }
  s_sol_out_path <- file.path(s_sol_out_dir, paste(tools::file_path_sans_ext(s_ex_name), '_sol.pdf', sep = ''))
  cat(" * Rendering ex source to: ", s_sol_out_path, '\n')
  rmarkdown::render(input = s_ex_path, output_file = s_sol_out_path, params = list(doctype = 'solution'))

  return(invisible(TRUE))
}


#' # Generate a Notebook for exercise
#' In a notebook, only the part of the problem without the solution should be contained.
#' To have this, we have to cut out the part that contains the solution.
s_ex_path <- file.path(here::here(), 'ex', 'asm_ex02.Rmd')
con_ex_src <- file(description = s_ex_path, open = 'r')
vec_ex_src <- readLines(con = con_ex_src)
close(con = con_ex_src)

# adapt the yample front matter
l_yml_fm_ex <- rmarkdown::yaml_front_matter(input = s_ex_path)
l_yml_fm_nb <- list(title = gsub(pattern = '`r tools::toTitleCase(params$doctype)`',
                                 replacement = 'Notebook', l_yml_fm_ex$title, fixed = TRUE),
                    author = l_yml_fm_ex$author,
                    date = l_yml_fm_ex$date,
                    output = 'html_notebook')


head(vec_ex_src)

# get yaml boundaries
(vec_yaml_bound <- grep('---', vec_ex_src, fixed = TRUE))

# get vector of comment starts and ends
vec_comment_start <- grep(pattern = "comment-start", vec_ex_src)
vec_comment_end <- grep(pattern = "comment-end", vec_ex_src)

# put together the nb source
vec_nb_src <- c('---',
                paste('title: ', l_yml_fm_nb$title, sep = ''),
                paste('author: ', l_yml_fm_nb$author, sep = ''),
                paste('date: ', l_yml_fm_nb$date, sep = ''),
                paste('output: ', l_yml_fm_nb$output, sep = ''),
                '---',
                vec_ex_src[(vec_yaml_bound[2]+1):(vec_comment_start[1]-1)])
if (length(vec_comment_start) > 1){
  for (idx in 2:length(vec_comment_start)){
    vec_nb_src <- c(vec_nb_src,
                    vec_ex_src[(vec_comment_end[idx-1]+1):(vec_comment_start[idx]-1)])
  }
}

cat(paste0(vec_nb_src, collapse = '\n'), '\n', file = 'asm_ex02_nb.Rmd')
