


require(MoBPS)

help("creating.diploid")


# random with nsnp = 6 and nind=5
l_di_pop <- creating.diploid(dataset = "random", nsnp = 6, nindi = 5)
str(l_di_pop)

l_di_pop$info$chromosome
l_di_pop$info

l_di_pop$info$cohorts


### ########################

pkg <- "sim1000G"
if (!is.element(pkg, installed.packages())) install.packages(pkg)

require(sim1000G)

set.seed(732)
examples_dir = system.file("examples", package = "sim1000G")
vcf_file = file.path(examples_dir,"region.vcf.gz")


# Alternatively provide a vcf file here:
# vcf_file = "~/fs/tmp/sim4/pop1/region-chr4-312-GABRB1.vcf.gz"

vcf = readVCF( vcf_file, maxNumberOfVariants = 600 , min_maf = 0.01, max_maf = 1)

startSimulation(vcf, totalNumberOfIndividuals = 5)
ids = generateUnrelatedIndividuals(3)
ids[4] <- SIM$mate(1,2)
ids[5] <- SIM$mate(1,3)

genotype = retrieveGenotypes(ids)
genotype
dim(genotype)

which(genotype[2,] == 2)
genotype[,c(1,2,129)]



