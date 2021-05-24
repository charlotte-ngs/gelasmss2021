# existing exercise data
s_data_root_online <- "https://charlotte-ngs.github.io/gelasmss2021"
s_data_file <- "asm_w03_ex02_bw_bc_reg.csv"
s_data_url_path <- file.path(s_data_root_online, "data", s_data_file)
# exam data
s_data_exam_file <- "gel_exam_p03.csv"
s_data_local_path <- file.path(here::here() , "docs", "data", s_data_exam_file)

### # read data from s_data_path
tbl_reg <- readr::read_csv(file = s_data_url_path)
tbl_reg
### # add random shoulder height
n_sh_mean <- 154
n_sh_sd <- 5.7
vec_sh <- rnorm(nrow(tbl_reg), mean = n_sh_mean, sd = n_sh_sd)
tbl_reg_withsh <- dplyr::bind_cols(tbl_reg, tibble::tibble(`Shoulder Height` = round(vec_sh, 0)))
# remove spaces from colnames
colnames(tbl_reg_withsh) <- c("Animal", "BreastCircumference", "BodyWeight", "ShoulderHeight")
# show the table
knitr::kable(tbl_reg_withsh,
             booktabs = TRUE,
             longtable = TRUE)

readr::write_csv2(tbl_reg_withsh, path = s_data_local_path)
