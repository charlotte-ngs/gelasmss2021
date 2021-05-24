set.seed(5374)
# according to google and https://timeforchange.org/are-cows-cause-of-global-warming-meat-methane-CO2
n_min_met_prod_per_year <- 59
n_max_met_prod_per_year <- 142
n_av_met_prod_per_year <- mean(c(n_min_met_prod_per_year,n_max_met_prod_per_year))
n_sd_met_prod_per_year <- (n_max_met_prod_per_year - n_min_met_prod_per_year) / 6
# number of bull
n_nr_bull <- 7
vec_bull_eff <- rnorm(n_nr_bull, sd = n_sd_met_prod_per_year / 4)
# number of daughters per bull
n_nr_dau <- 3
# number of observations
n_nr_met_obs <- n_nr_bull * n_nr_dau
# bull incidence matrix
mat_bull_design <- kronecker(diag(n_nr_bull), matrix(rep(1,n_nr_dau), ncol = 1))

# observations
mat_obs <- n_av_met_prod_per_year + crossprod(t(mat_bull_design), vec_bull_eff) + rnorm(n_nr_met_obs, mean = 0, n_sd_met_prod_per_year)
# data tibble
tbl_met <- tibble::tibble(Offspring = c(1:n_nr_met_obs),
                          Bull = sort(rep(1:n_nr_bull, n_nr_dau)),
                          Methane = round(mat_obs[,1], 0))

s_data_exam_file <- "gel_exam_p04.csv"
s_data_local_path <- file.path(here::here() , "docs", "data", s_data_exam_file)

readr::write_csv2(tbl_met, path = s_data_local_path)
