

create_exercise <- function(ps_ex_name){
  s_proj_dir <- here::here()
  s_ex_src_dir <- file.path(s_proj_dir, "ex")
  rmarkdown::draft(file = "ex/gel_ex01",
                   template = "rttexercise",
                   package = "rteachtools",
                   edit = FALSE)
  template <- readLines(con = "ex/gel_ex01/gel_ex01.Rmd")
  whisker::whisker.render(template = template, data = list(course_name = "Genetic Evaluation", exercise_count = 1, creation_date = format(Sys.Date(), "%Y-%m-%d"), author = "Peter von Rohr"))

}
