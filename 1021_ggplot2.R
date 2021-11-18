# Learn R with Dr.Hu and His Friends
# Sun Zhaoyang R lecture No.3 2021.10.21
# Basic Visualization with ggplot2

# set current folder as working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# setwd("D://xxx//xxx")

library(ggplot2) # R package for visualization
library(readxl) # R package for import excel files
library(gridExtra) # R package for combine and arrange plots


data<- read_excel("WVS_CHN.xlsx", sheet="Sheet1")
View(data)

#Q46 Taking all things together, would you say you are
# 1 Very happy
# 2 Rather happy
# 3 Not very happy
# 4 Not at all happy
Q46 <- data$Q46
table(Q46)
recent_life_satisfaction <- ifelse(Q46 < 0, NA, 5-Q46) 
# 1-4 not happy - very happy
table(recent_life_satisfaction)


# Q49 All things considered, 
# how satisfied are you with your life as a whole these days? 
# 1 - 10, Completely dissatisfied - Completely satisfied
Q49 <- data$Q49
table(Q49)
recent_life_satisfaction <- ifelse(Q49 < 0, NA, Q49)
table(recent_ife_satisfaction)


# Q50 How satisfied are you with the financial situation of your household?
# 1 - 10, Completely dissatisfied - Completely satisfied
Q50 <- data$Q50
table(Q50)
househould_financial_satisfactiion <- ifelse(Q50 < 0, NA, Q50)
table(househould_financial_satisfactiion)


# Q260 Respondent's Sex
Q260 <- data$Q260
table(Q260)
male <- ifelse(Q260==1,1,0)
table(male)

#region province
region <- data$N_REGION_ISO


#####################################################################
##---ggplot: data, aesthetics, geometric objects and others----------
#####################################################################

## data
ggplot()

ggplot(data = data)

## data, basic plot aesthetic setting
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram()

## data, aesthetics, geometric
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'red', bins = 10)

## add title
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'black', bins = 10) +
  ggtitle('recent_life_satisfaction of Respondents')

## add lab 
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'black', bins = 10) +
  ggtitle('recent_life_satisfaction of Respondents') +
  ylab('') +
  xlab('Recent Life Satisfaction') +
  theme(plot.title = element_text(hjust = 0.5))

# add theme
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('recent_life_satisfaction of Respondents') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  theme(plot.title = element_text(hjust = 0.5))

# ?ggplot()

## how save my plot 
fig1 <- ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('recent_life_satisfaction of Respondents') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  theme(plot.title = element_text(hjust = 0.5))
fig1

ggsave("myfirstplot.pdf", fig1) 

## plot grid 1 plot arrange
fig2 <- ggplot(data = data, aes(y = recent_life_satisfaction, x = factor(male))) +
  geom_violin() +
  ggtitle("recent_life_satisfaction \n By Respondent's gender") +
  xlab('male') +
  ylab('recent_life_satisfaction')
fig2

grid.arrange(fig1, fig2, ncol=2)

grid.arrange(fig1, fig2, ncol=1)


## facet_plot 1 plot panel
ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('recent_life_satisfaction of Respondents \n By Region') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  facet_wrap( ~ factor(region)) + # add facet here
  theme(plot.title = element_text(hjust = 0.5))

#####################################################################
## -----------------------color--------------------------------------
#####################################################################

fig3 <- ggplot(data =data, aes(x = recent_life_satisfaction, color=factor(region), fill=factor(region))) +
  geom_histogram() +
  ggtitle('recent_life_satisfaction of Respondents \n By Region') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  facet_wrap( ~ factor(region)) + # add facet here
  theme(plot.title = element_text(hjust = 0.5))
fig3


fig3 <- fig3 + scale_fill_brewer(palette = 'Accent')
fig3

?scale_fill_brewer()


#####################################################################
## ------------------------analysis----------------------------------
#####################################################################


#####################################################################
## ------------------------one variable------------------------------
#####################################################################

## histogram
pic1 <- ggplot(data = data, aes(x = recent_life_satisfaction)) +
  geom_histogram() +
  xlab('recent_life_satisfaction') +
  ylab('') +
  ggtitle('recent_life_satisfaction of Respondents')
pic1


pic2 <- ggplot(data = data, aes(x = househould_financial_satisfactiion)) +
  geom_histogram() +
  xlab('househould_financial_satisfactiion') +
  ylab('') +
  ggtitle('househould_financial_satisfactiion')
pic2


#####################################################################
## ------------------------two variable------------------------------
#####################################################################

## point plot
pic3 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction)) +
  geom_point() +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction')
pic3


## jitter plot
pic4 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction)) +
  geom_jitter(width=0.1, height=0.3) +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction')
pic4

## add line auto
pic5 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction)) +
  geom_jitter(width=0.2, height=0.2) +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(color="grey")
pic5

## add line linear model
pic6 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction)) +
  geom_jitter(width=0.2, height=0.2) +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(method = lm, color="grey")
pic6

## add some details
pic7 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction, color = househould_financial_satisfactiion)) +
  #scale_color_continuous(low="green")+
  scale_color_continuous(low ="green", high="red")+
  geom_jitter(width=0.2, height=0.2) +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(method = lm, color="grey")
pic7

## add some details: dot
pic8 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction, color = househould_financial_satisfactiion)) +
  #scale_color_continuous(low="green")+
  scale_color_continuous(low ="#CC0033", high="#0066CC")+
  geom_jitter(width=0.2, height=0.2, shape=factor(male), dotsize = male) + # dot style
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(method = lm, color="grey")
pic8

## change type
pic9 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction, color = househould_financial_satisfactiion)) +
  #scale_color_continuous(low="green")+
  scale_color_continuous(low ="#CC0033", high="#0066CC")+
  geom_count() +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(method = lm, color="grey")
pic9

## change type
pic10 <- ggplot(data = data, aes(x = househould_financial_satisfactiion, y = recent_life_satisfaction, color = househould_financial_satisfactiion)) +
  #scale_color_continuous(low="green")+
  scale_color_continuous(low ="#CC0033", high="#0066CC")+
  geom_contour() +
  xlab('househould_financial_satisfactiion') +
  ylab('recent_life_satisfaction') +
  ggtitle('Will househould_financial_satisfactiion predict recent_life_satisfaction') +
  stat_smooth(method = lm, color="grey")
pic10


#####################################################################
## --------------------------- link ---------------------------------
#####################################################################

# Further Study
# https://stats.idre.ucla.edu/stat/data/intro_ggplot2_int/ggplot2_intro_interactive.html#(1)

# Detailed Hist Plot and Bar Plot
# https://www.sohu.com/a/125919313_466874