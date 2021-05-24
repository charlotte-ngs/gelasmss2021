require(dplyr)

n_h2_imf <- 0.25
n_nr_founder <- 3
n_nr_obs_imf <- 6
n_nr_ani_imf <- n_nr_founder + n_nr_obs_imf
set.seed(2153)
### # intercept and two levels of a fixed effect
vec_beta <- c(1.64, 0.9, 0.5)
mat_x <- matrix(c(1, 1, 0,
                  1, 0, 1,
                  1, 0, 1,
                  1, 0, 1,
                  1, 1, 0,
                  1, 0, 1), nrow = n_nr_obs_imf, byrow = TRUE)
n_sigma_p2 <- 2.25
n_sigma_a2 <- n_sigma_p2 * n_h2_imf
n_sigma_e2 <- n_sigma_p2 - n_sigma_a2

### # pedigree
tbl_ped_prob2 <- tibble::tibble(Animal = c((n_nr_founder+1):n_nr_ani_imf),
                                Sire   = c(1, 1, 3, 4, 4, 8),
                                Dam    = c(2, 2, 5, 6, 7, 6))
### # extended pedgiree with founders
tbl_ped_prob2_ext <- tibble::tibble(Animal = c(1:n_nr_ani_imf),
                                    Sire   = c(rep(NA, n_nr_founder), tbl_ped_prob2$Sire),
                                    Dam    = c(rep(NA, n_nr_founder), tbl_ped_prob2$Dam))

### # generate vector of bv
generate_vec_bv <- function(ptbl_ped, pn_sigmaa2){
  ### # get pedigree
  ped <- pedigreemm::pedigree(sire = ptbl_ped$Sire, dam = ptbl_ped$Dam, label = as.character(ptbl_ped$Animal))
  ### # number of animal
  n_nr_ani <- nrow(ptbl_ped)
  ### # get matrix D
  diag_mat_d <- diag(pedigreemm::Dmat(ped = ped), nrow = n_nr_ani, ncol = n_nr_ani)
  ### # get matrix A based on pedigree
  mat_a <- as.matrix(pedigreemm::getA(ped = ped))
  ### # cholesky of A
  mat_r <- t(chol(mat_a))
  ### # sqrt(D) to mat_s
  mat_s <- sqrt(diag_mat_d)
  ### # matrix L
  mat_l <- mat_r %*% solve(mat_s)
  ### # sample the vector of mendelian sampling
  vec_m <- rnorm(n_nr_ani, mean = 0, sd = sqrt(diag(diag_mat_d) * pn_sigmaa2))
  ### # adding pedigree Information
  vec_a_result <- mat_l %*% vec_m
  ### # return result
  return(vec_a_result)
}
### # vector of breeding values
vec_bv_imf <- generate_vec_bv(ptbl_ped = tbl_ped_prob2_ext, pn_sigmaa2 = n_sigma_a2)
### # design matrix Z
mat_z_imf <- cbind(matrix(0, nrow = n_nr_obs_imf, ncol = n_nr_founder), diag(1, nrow = n_nr_obs_imf, ncol = n_nr_obs_imf))

### # generate observations
vec_y_imf <- crossprod(t(mat_x), vec_beta) + crossprod(t(mat_z_imf), vec_bv_imf) + rnorm(n_nr_obs_imf, mean = 0, sd = sqrt(n_sigma_e2))

### # population mean
n_mu_inf <- mean(vec_y_imf)

### # create the final dataset
mat_sex <- crossprod(t(mat_x), c(0,1,2))
tbl_data_prob2 <- tbl_ped_prob2 %>% mutate(Sex = mat_sex[,1], Observation = round(vec_y_imf[,1], digits = 2))

# write file
s_data_file <- "gel_exam_p02.csv"
s_data_local_path <- file.path(here::here(), "docs", "data", s_data_file)
readr::write_csv2(tbl_data_prob2, path = s_data_local_path)
