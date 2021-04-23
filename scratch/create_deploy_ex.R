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
create_exercise(ps_ex_name        = "gel_ex02",
                ps_course_name    = "Genetic Evaluation",
                pn_exercise_count = 2,
                ps_author         = "Peter von Rohr",
                pn_nr_problem     = 1)

# deploy
devtools::load_all();deploy_uni_src(ps_ex_name = 'gel_ex02')
