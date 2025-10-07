## The following library used in our calculation
library(dplyr)
library(meta)
library(dmetar)
library(gemtc)
library(metafor)
library(forestplot)
library(tidyverse) 

## Meta-analysis for OR
m.gen <- metagen(TE = TE, seTE = seTE,
                          data = tobacco_OR,
                         studlab = study,
                          sm = "OR",
                          fixed = TRUE, random = TRUE,
                          method.tau = "REML",
                          hakn = TRUE)
summary(m.gen)

## Meta-analysis for coefficients 
m.gen <- metagen(TE = TE, seTE = seTE,
                          data = tobacco_coff,
                         studlab = study,
                          sm = "MD",
                          fixed = TRUE, random = TRUE,
                          method.tau = "REML",
                          hakn = TRUE)
summary(m.gen)

## Publication bias
library(meta)
## Funnel plot
funnel.meta(m.gen, col = "black")

## Publication bias test
metabias(m.gen, method.bias = "linreg")
eggers.test(m.gen)

## Addressing publication bias: Trim-and-Fill estimate
tf <- trimfill(m.gen)
summary(tf)

## Subgroup meta-analysis by country income group
update.meta(m.gen, 
            subgroup = inc, 
            tau.common = FALSE)


# R script for Network meta-analysis

## The following library used in our calculation
library(dmetar)
library(gemtc)
library(netmeta) 
library(metafor)
library(forestplot)
library(tidyverse) 

## Model Fitting 
m.netmeta <- netmeta(TE = TE, seTE = seTE,
                          treat1 = treat1,  # Policy
                          treat2 = treat2,  # Control 
                          studlab = studyid, data = data_tobacco,
                          sm = "OR",
                          comb.fixed = FALSE, comb.random = TRUE,
                          reference.group = "Control",
                          details.chkmultiarm = TRUE,
                          sep.trts = " vs ")
m.netmeta
decomp.design(m.netmeta)

## Tobacco Policy Ranking
rank<-netrank(m.netmeta, small.values = "bad")
plot(rank, low = "red", mid = "yellow", high = "green", col = "black",
name ="",
main.col = col,
legend = TRUE,
axis.size = 12,
digits = 2)

## Network forest plot
forest(m.netmeta, reference.group = "Control", 
                   digits=2, 
                   drop.reference.group = TRUE,
                   axis.size = 14,
                   label.left ="Favors Control", 
                   label.right ="Favors Policy",
                   clip = c(0.5, 1, 1.5,2.0, 2.5), 
                   xlog = TRUE,
                   smlab = paste("","Random Effects Model"),
                   rightcols = c("effect", "ci"),
                   just.addcols = "right",
                   sortvar = -Pscore,
                   drop = TRUE, 
                   lineheight = "auto",
                   col = fpColors(box = "royalblue", 
                   line = "darkblue"))
