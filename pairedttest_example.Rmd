---
title: "Paired t-test Example"
author: "Amit Dingare"
date: "September 24, 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(MASS)
data(anorexia)
attach(anorexia)
head(anorexia)
```


```{r}
library(psych)
#descriptive statistics on weight before treatment

describe(anorexia$Prewt)

#descriptive statistics on weight after treatment
describe(anorexia$Postwt)

#create a new variable containing differences
weight.differences = Postwt - Prewt

#create a boxplot to identify any outliers in our data

boxplot(weight.differences,main = "Boxplot of weight differences before and after treatment",ylab = "weight differences",col = "green")

#Create a histogram to visually assess normality
#attach weight.differences to anorexia data frame
anorexia$weight.differences = weight.differences

library(ggplot2)
ggplot(anorexia,aes(x=weight.differences)) + geom_histogram(aes(y=..density..),binwidth = 0.9) + stat_function(fun = dnorm, colour = "blue",args = list(mean = mean(anorexia$weight.differences), sd = sd(anorexia$weight.differences))) + scale_x_continuous(name="Weight differences") + ggtitle("Histogram of weight differences before and after anorexia treatment")

#Test if the weight differences are normally distributed
shapiro.test(weight.differences)
```


```{r}
#Perform a power analysis to check the sample size has adequate power to detect a difference if it exists
#install package pwr and load it
library(pwr)
pwr.t.test(n=72,d=0.5,sig.level = 0.05,type = c("paired"))

#Perform a paired t test
t.test(Postwt,Prewt,paired = TRUE)

```

