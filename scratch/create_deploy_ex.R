#' ---
#' title: Create and Deploy Exercise
#' date: 2021-04-23
#' ---
#'
#' # Disclaimer
#' Show for gel_ex02 how an exercise is created and deployed

# load all functions in current project
devtools::load_all()
# create empty exercise skeleton
create_exercise(ps_ex_name        = "gel_ex04",
                ps_course_name    = "Genetic Evaluation",
                pn_exercise_count = 4,
                ps_author         = "Peter von Rohr",
                pn_nr_problem     = 3)

# deploy
devtools::load_all();deploy_uni_src(ps_ex_name = 'gel_ex04')

# rexpf
s_proj_dir <- here::here()
s_proj_name <- basename(s_proj_dir)
# rexpf directory
s_rexpf_dir <- file.path(dirname(dirname(s_proj_dir)), 'rexpf', s_proj_name)

s_ex_name        = "gel_ex02"

# copy ex
fs::dir_copy(path = file.path(s_proj_dir, "nb", s_ex_name), new_path = file.path(s_rexpf_dir, "ex"))

# copy sol
fs::dir_copy(path = file.path(s_proj_dir, "ex", s_ex_name), new_path = file.path(s_rexpf_dir, "sol"))


# check
list.files(file.path(s_proj_dir, "nb", s_ex_name))

list.files(file.path(s_rexpf_dir, "ex"))
