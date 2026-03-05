# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise

library(tidyverse)
library(ggplot2)
library(Cairo)

# Load data here ----------------------
# Load each file with a meaningful variable name.
dat_gene <- read.csv("https://raw.githubusercontent.com/smrenwick/training-program-application-2026-MR/refs/heads/main/data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")

dat_meta <-read.csv("https://raw.githubusercontent.com/smrenwick/training-program-application-2026-MR/refs/heads/main/data/GSE60450_filtered_metadata.csv")

# Inspect the data -------------------------
dim(dat_gene)
head(dat_gene)
summary(dat_gene)

dim(dat_meta)
head(dat_meta)
summary(dat_meta)

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.

## Expression data
# 23735 rows    14 columns

## Metadata
# 12 rows    4 columns

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

# I am not familiar with this kind of work, but I am assuming you are asking for box plots of the 
# numeric data to compare the plots between luminal and basal cell populations?
# apologies if I have misunderstood.

# Perhaps this is easiest by creating a variable for cell type in the gene dataset.

# first we don't need the first 2 columns for this boxplot, so
dat_use <- dat_gene[,c(-1, -2)]

# now pivot longer
dat_use <- dat_use %>% 
  pivot_longer(col= everything(), 
               values_to = "expression", 
               names_to = "nucleic_acid")

# create new variable for cell typw
dat_use <- dat_use %>%
  mutate(cell_type = case_when(nucleic_acid == "GSM1480291" ~ "Luminal",
                               nucleic_acid == "GSM1480292" ~ "Luminal",
                               nucleic_acid == "GSM1480293" ~ "Luminal",
                               nucleic_acid == "GSM1480294" ~ "Luminal",
                               nucleic_acid == "GSM1480295" ~ "Luminal",
                               nucleic_acid == "GSM1480296" ~ "Luminal",
                               nucleic_acid == "GSM1480297" ~ "Basal",
                               nucleic_acid == "GSM1480298" ~ "Basal",
                               nucleic_acid == "GSM1480299" ~ "Basal",
                               nucleic_acid == "GSM1480300" ~ "Basal",
                               nucleic_acid == "GSM1480301" ~ "Basal",
                               nucleic_acid == "GSM1480302" ~ "Basal"))



# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2

plot <- ggplot(data = dat_use, aes(x=cell_type, y=expression, fill = cell_type)) + geom_boxplot() +
  labs(x="Cell type", y="Gene expression", fill = "Cell type") +
  scale_y_log10()
plot

## Save the plot
### Show code for saving the plot with ggsave() or a similar function

setwd("C:/TEMP")

CairoPDF(14, 14, file="Boxplot_celltype.pdf", bg="transparent") 
plot(plot)
dev.off()
