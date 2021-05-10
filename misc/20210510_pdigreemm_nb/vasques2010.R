#' ---
#'
#'
#' ---
#'

require(pedigreemm)
milk <- within(milk, sdMilk <- milk / sd(milk))
fm1 <- pedigreemm(sdMilk ~ lact + log(dim) + (1|id) + (1|herd), data = milk, pedigree = list(id = pedCowsR))
summary(fm1)
