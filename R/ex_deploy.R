## --- Exercise Deployment Wrapper --------------------------------------------
#'
#' @title Exercise Deployment
#'
#' @description
#' Wrapper for deployment of a given exercise in a course. The deployment
#' consists of producing the pdf-output of the exercise without solutions and
#' the pdf-document with the solutions.
#'
#' @details
#' This wrapper assumes that the source Rmd file containing the exercise problems
#' and the solutions is in a subdirectory called 'ex' under the course project directory.
#'
#' @examples
#' \dontrun{
#' devtools::load_all()
#' deploy_exercise(ps_ex_name = 'asm_ex02')
#' }
#'
#' @param ps_ex_name exercicse name
#'
#' @export deploy_exercise
deploy_exercise <- function(ps_ex_name){

  s_proj_dir <- here::here()
  s_proj_name <- basename(s_proj_dir)
  s_out_dir <- file.path(s_proj_dir, 'docs')
  s_rexpf_dir <- file.path(dirname(dirname(s_proj_dir)), 'rexpf', s_proj_name)
  # call rteachtools deployment function with a set of default parameters
  rteachtools::deploy_ex(ps_ex_path = file.path(s_proj_dir, 'ex', ps_ex_name, ps_ex_name),
                         ps_ex_out_dir = file.path(s_out_dir, 'ex'),
                         ps_sol_out_dir = file.path(s_out_dir, 'sol'),
                         ps_rexpf_src   = file.path(s_proj_dir, 'nb'),
                         ps_rexpf_trg   = s_rexpf_dir)

  return(invisible(TRUE))

}
