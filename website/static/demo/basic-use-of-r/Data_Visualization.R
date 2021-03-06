#' ---
#' title: "Demo: Data Visualization"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---
#' 

#' ## Load packages
#' If you are using the package for the first time, you will have to first install it \
# install.packages("survival") 
# install.packages("lattice")
# install.packages("ggplot2")
# install.packages("emojifont")
# install.packages("gtrendsR")
library(survival)
library(lattice)
library(ggplot2)
library(emojifont)
library(gtrendsR)

#'## Get data
#' Load data set from package
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' ## Basic plots
#' Basic plot with 1 variable
plot(pbc$bili)

#' Basic plot with 2 variables - checking the correlation between `age` and `bili`
plot(pbc$age, pbc$bili)

#' Basic plot with 2 variables - add axis labels
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age")

#' Basic plot with 2 variables - add axis labels - change size of axis and labels
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age",
     cex.axis = 1.2, cex.lab = 1.4)

#' Basic plot with 2 variables - add axis labels - change the size and type of points
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age",
     cex.axis = 1.2, cex.lab = 1.4,
     cex = 2, pch = 16)


#' Basic plot with 2 variables - add axis labels - change size of axis and labels - change the colour \
#' Note that can set the colours in different ways:\
#' * using numbers that correspond to a colour \
#' * using the name of the colour \
#' * using the RGB colour specification (Red Green Blue) `?rgb` \
#' * using the HEX colour code
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.2, cex.lab = 1.4,
     col = 2)
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.2, cex.lab = 1.4,
     col = "red")
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.2, cex.lab = 1.4,
     col = rgb(1,0,0))
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.2, cex.lab = 1.4,
     col = "#FF0000")

#' Basic plot with 3 variables - xaxis represents `age`, yaxis represents `serum bilirubin` and colours represent `sex`
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.5, cex.lab = 1.4, col = pbc$sex, pch = 16)
legend(30, 25, legend = c("male", "female"), col = c(1,2), pch = 16)

#' Histogram for continuous variables - checking the distribution of `bili`
hist(pbc$bili, breaks = 50)
hist(pbc$bili, breaks = seq(min(pbc$bili), max(pbc$bili), length = 20))

#' Multiple panels
par(mfrow=c(2,2))
hist(pbc$bili, prob=T)
hist(pbc$chol, prob=T)
hist(pbc$albumin, prob=T)
hist(pbc$alk.phos, prob=T)
#' Note that sometimes you will have to clear all plots in order to get 1 panel again (brush icon in `Plots` tab)

#' Barchart for categorical variables - checking the frequency of `males` and `females`
plot(pbc$sex)

#' Piechart for categorical variables - checking the frequency of `males` and `females`
pie(table(pbc$sex))

#' Boxplot for investigating the distribution of a continuous variable per group - cheking the distribution of `age` per `sex` group
boxplot(pbc$age ~ pbc$sex, ylab = "Age", xlab = "Gender")

#' Multivariate plot
pairs(cbind(pbc$bili, pbc$chol, pbc$albumin))

#' Density plots of `serum bilirubin` per `sex` group to investigate the distribution \
pbc_male_bili <- pbc$bili[pbc$sex == "m"]
pbc_female_bili <- pbc$bili[pbc$sex == "f"]
plot(density(pbc_male_bili), col = rgb(0,0,1,0.5), ylim = c(0,0.40),
     main = "Density plots", xlab = "bili", ylab = "")
polygon(density(pbc_male_bili), col = rgb(0,0,1,0.5), border = "blue")
lines(density(pbc_female_bili), col = rgb(1,0,0,0.5))
polygon(density(pbc_female_bili), col = rgb(1,0,0,0.5), border = "red")
legend(5,0.3, c("male", "female"), 
       col = c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)), lty = 1)  

#' ## Lattice family
#' Correlation between `serum bilirubin` and `age`
xyplot(bili ~ age, data = pbc, type = "p", lwd = 2)

#' Smooth evolution of `serum bilirubin` with `age`
xyplot(bili ~ age, data = pbc, type = "smooth", lwd = 2)

#' Smooth evolution of `serum bilirubin` with `age` per `sex`
xyplot(bili ~ age, group = sex, data = pbc, type = "smooth", lwd = 2, col = c("red", "blue"))

#' Smooth evolution with points of `serum bilirubin` with `age` per `sex`
xyplot(bili ~ age, group = sex, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red", "blue"))

#' Smooth evolution with points of `serum bilirubin` with `age` per `sex` (as separate panel)
xyplot(bili ~ age | sex, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"))   

#' Smooth evolution with points of `serum bilirubin` with `age` per `status` (as separate panel)
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"))  

#' Smooth evolution with points of `serum bilirubin` with `age` per `status` (as separate panel - change layout)
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"), layout = c(2,2)) 

#' Smooth evolution with points of `serum bilirubin` with `age` per `status` (as separate panel - change layout) \
#' Add labels for `status`
pbc$status <- factor(pbc$status, levels = c(0, 1, 2), labels = c("censored", "transplant", "dead"))
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"), layout = c(3,1))  

#' Individual patient plot
xyplot(bili ~ day, group = id, data = pbcseq, type ="l", col = "black")

#' Individual patient plot per `status`
pbcseq$status <- factor(pbcseq$status, levels = c(0, 1, 2), labels = c("censored", "transplant", "dead"))
xyplot(bili ~ day | status, group = id, data = pbcseq, type ="l", col = "black", layout = c(3,1),
       grid = TRUE, xlab = "Days", ylab = "Serum bilirubin")

#' Barchart for categorical variables - checking the frequency of `males` and `females`
barchart(pbc$sex)

#' Correlation between `serum bilirubin` per `sex` group
bwplot(pbc$bili ~ pbc$sex)


#' ## Ggplot family 
#' Correlation between `age` with `serum bilirubin` \
#' Each `sex` has a different colour
ggplot(pbc, aes(age, bili, colour = sex)) + 
  geom_point()

ggplot(pbc, aes(age, bili, colour = sex)) + 
geom_point(alpha = 0.3) +
geom_smooth()

#' Correlation between `day` with `serum bilirubin` for patient 93 \
#' A smoothed curve is added in blue
ggplot(pbcseq[pbcseq$id == 93,], aes(day, bili)) +
geom_line() +
geom_smooth(colour = 'blue', span = 0.4) +
labs(title = "Patient 93", subtitle = "Evolution over time", 
     y = "Serum bilirubin", x = "Days")

#' Correlation between `serum bilirubin` per `stage`
ggplot(pbc, aes(stage, bili, group = stage)) +
geom_boxplot() +
labs(y = "Serum bilirubin", x = "Stage")

#' Density plot of `serum bilirubin` per `sex` to investigate the distribution \
#' Be aware that a plot is an object in R, so you can save it
p <- ggplot(pbc, aes(bili, fill = sex)) +
geom_density(alpha = 0.25) 
p

p + scale_fill_manual(values = c("#999999", "#E69F00"))

                     
#' ## Let's have some fun
set.seed(123)
x1 <- rnorm(10)
y1 <- rnorm(10)
x2 <- rnorm(10)
y2 <- rnorm(10)
plot(x1, y1, cex = 0)
text(x1, y1, cex = 1.5, col='red')
plot(x1, y1, cex = 0)
text(x1, y1, labels = emoji('heartbeat'), cex = 1.5, col = 'red', family = 'EmojiOne')
text(x2, y2, labels = emoji('cow'), cex = 1.5, col = 'steelblue', family = 'EmojiOne')

search_emoji('face')

plot(x1, y1, cex=0)
text(x1, y1, labels = emoji('nerd_face'), cex=1.5, col='red', family = 'EmojiOne')

plot(x1, y1, cex=0)
text(x1, y1, labels = emoji('face_with_head_bandage'), cex=1.5, col='blue', family='EmojiOne')


#' Using google data
google.trends1 = gtrends(c("feyenoord"), gprop = "web", time = "all")[[1]]

ggplot(data = google.trends1, aes(x = date, y = hits)) +
  geom_line() +
  labs(y = "Feyenoord", x = "Time") +
  ggtitle("Hits on Google")



#' Using twitter data
# rt <- rtweet::search_tweets(q = "#rstats", n = 1000, include_rts = FALSE)
# cl <- rtweet::search_tweets(q = "#climate", n = 1000, include_rts = FALSE)
# bg <- rtweet::search_tweets(q = "@BillGates", n = 1000, include_rts = FALSE)
# emc <- rtweet::search_tweets(q = "@ErasmusMC", n = 1000, include_rts = FALSE, by = "months")
# lumc <- rtweet::search_tweets(q = "@LUMC_Leiden", n = 1000, include_rts = FALSE)
# 
# ts_plot(rt)
# ts_plot(cl)
# ts_plot(bg)
# ts_plot(emc)
# ts_plot(lumc)


