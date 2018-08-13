#how to run several regressions in four lines of code
library(tidyverse)
library(stargazer)
data <- read_csv("/home/dj-ubuntu/Documents/Dem Attitudes Marcus/sweden_wvs.csv")

nms <- c("give_income", "increase_taxes", "gov_reduce_poll", "higher_price", "people_nervous", "accept_problems", 
  "less_urgent")


#here is all the code you need to run as many regressions as you want with the same set of covariates
dep_vars <- names(mtcars[-which(colnames(mtcars) == "mpg")])
frm <- paste0(dep_vars, " ~ mpg") %>% map(as.formula)
models <- map(frm, function(x) lm(formula = x, data = mtcars))

 
#do what you wish with the results, I like stargazer:
stargazer(models,
          type = "text")

#after you've run your regressions, you can just as easily get heteroscedasticity or cluster robust standard errors
#here are huber-white robust standard errors for the 10 models in the table
hw_se <- lapply(models, function(x) coeftest(x, vcovHC(x, "HC1"))[,2])

#then add them to your stargazer call
stargazer(models,
          se = hw_se,
          type = "text")

#some notes:
#this does not work
models <- map(frm, lm(formula = frm, data = mtcars))
#you need the anonymous function

#it works the same with lapply if you want a non-tidyverse solution (the pipe is from magrittr not tidyverse per se)
frm <- paste0(dep_vars, " ~ mpg") 
frm <- lapply(frm, as.formula)
models <- lapply(frm, function(x) lm(formula = x, data = mtcars))

#looping is another solution to get the same result
m <- vector("list", length(dep_vars))
for(i in 1:length(dep_vars)){
  m[[i]] <- lm(formula = frm[[i]], data = data)
}
#it's only slightly more verbose, but it doesn't play as well with stargazer (notice the dep_vars)
stargazer(m,
          type = "text")


gss <- forcats::gss_cat
gss



m1 <- lm(cut ~ carat, data = data)
m2 <- lm(color ~ carat, data = data)
m3 <- lm(clarity ~ carat, data = data)
m4 <- lm(depth ~ carat, data = data)
m5 <- lm(table ~ carat, data = data)
m6 <- lm(price ~ carat, data = data)

se1 <- coeftest(m1, vcovHC(m1))[,2]
se2 <- coeftest(m2, vcovHC(m2))[,2]
se3 <- coeftest(m3, vcovHC(m3))[,2]
se4 <- coeftest(m4, vcovHC(m4))[,2]
se5 <- coeftest(m5, vcovHC(m5))[,2]
se6 <- coeftest(m6, vcovHC(m6))[,2]

