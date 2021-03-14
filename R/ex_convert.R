## --- Convert Exercise To Notebook -------------------------------------------
#' @title Convert Exercise To Notebook
#'
#' @description
#' Wrapper function to convert a RMarkdown exercise source file to a notebook
#'
#' @details
#' The wrapper assumes for convenience directory settings that are used in the
#' course project directory
#'
#' @examples
#' \dontrun{
#' convert_exercise_to_nb(ps_ex_name = 'asm_ex02')
#' }
#'
#' @param ps_ex_name exercise name
#' @param pb_force boolean flag to force overwrite the generated notebook
#'
#' @export convert_exercise_to_nb
convert_exercise_to_nb <- function(ps_ex_name, pb_force = FALSE){
  s_proj_dir <- here::here()
  s_out_dir <- file.path(s_proj_dir, 'docs')
  rteachtools::convert_ex_to_nb(ps_ex_path      = file.path(s_proj_dir, 'ex', ps_ex_name, ps_ex_name),
                               ps_nb_out_dir    = file.path(s_proj_dir, 'nb', ps_ex_name),
                               ps_nb_deploy_dir = file.path(s_out_dir, 'nb'),
                               pb_force         = pb_force)

  return(invisible(TRUE))

}

