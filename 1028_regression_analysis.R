# Learn R with Dr.Hu and His Friends
# Sun Zhaoyang R lecture No.5 2021.10.28
# Basic Regression Analysis

# set current folder as working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# setwd("D://xxx//xxx")


library(readxl) # R package for import excel files
library(stargazer) # R package for making regression table
library(ggplot2) # R package for plotting

data<- read_excel("WVS_CHN.xlsx", sheet="Sheet1")
#View(data)

#Q46 Taking all things together, would you say you are
# 1 Very happy
# 2 Rather happy
# 3 Not very happy
# 4 Not at all happy
Q46 <- data$Q46
table(Q46)
happiness <- ifelse(Q46 < 0, NA, 5-Q46) 
# 1-4 not happy - very happy
table(happiness)


# Q49 All things considered, 
# how satisfied are you with your life as a whole these days? 
# 1 - 10, Completely dissatisfied - Completely satisfied
Q49 <- data$Q49
table(Q49)
recent_life_satisfaction <- ifelse(Q49 < 0, NA, Q49)
table(recent_life_satisfaction)


# Q50 How satisfied are you with the financial situation of your household?
# 1 - 10, Completely dissatisfied - Completely satisfied
Q50 <- data$Q50
table(Q50)
househould_financial_satisfactiion <- ifelse(Q50 < 0, NA, Q50)
table(househould_financial_satisfactiion)


# Q112. How would you place your views on corruption in your country?
# 1 - 10, There is no corruption in my country - There is abundant corruption in my country
Q112 <- data$Q112
table(Q112)
corruption <- ifelse(Q112 < 0, NA, Q112)
table(corruption)


# Q164. How important is God in your life? 
# 1 - 10, Not at all important - Very important
Q164 <- data$Q164
table(Q164)
god_is_important <- ifelse(Q164 < 0, NA, Q164)
table(god_is_important)


# Q260 Respondent's Sex
Q260 <- data$Q260
table(Q260)
male <- ifelse(Q260==1,1,0)
table(male)


# Q262 Respondent's Age
Q262 <- data$Q262
table(Q262)
age <- Q262

#region province
region <- data$N_REGION_ISO

attach(data)

# Start Time


start_time <- floor(K_TIME_START) + (K_TIME_START - floor(K_TIME_START))/0.6

# End Time
end_time <- floor(K_TIME_END) + (K_TIME_END - floor(K_TIME_END))/0.6

data_regression <- cbind.data.frame(start_time, end_time)
#####################################################################
##---------------linear model: Ordinary Least Square-----------------
#####################################################################

## new model set
M_01 <- lm(end_time ~ start_time, data = data)
## model summary
summary(M_01)


# make a beautiful table with stargazer
stargazer(M_01, title="Trial Regression", type="text", out="Trial Regression.html")



#####################################################################
## ---------------------Further Analysis-----------------------------
#####################################################################

# plot
# 高斯-马尔可夫定理(Gauss-Markov Theorem)
# 最佳线性无偏估计(BLUE, Best Linear unbiased estimator)

# 残差零均值
# 同方差性
# 残差之间不相关

# Further Study
# https://zhuanlan.zhihu.com/p/34119477
# https://zhuanlan.zhihu.com/p/33899560

# plot
ggplot(data = data, aes(x = start_time, y = end_time)) +
  geom_jitter(width=0.0, height=0.0) +
  xlab('start_time') +
  ylab('end_time') +
  ggtitle('Jitter Plot')

plot(start_time, end_time)

# plot and line
plot(start_time, end_time)
abline(M_01)

# residual analysis
y.res<-residuals(M_01)
plot(start_time, y.res)

# Comprehensive analysis
plot(M_01)

# 生成的图形如上所示，下面对生成的图形进行解释
# OLS回归的统计假设为：正态性，独立性，线性，同方差性

# 线性 Residuals vs Fitted 
# 残差图与拟合图 若应变量与自变量线性相关，那么残差值与拟合值就没有任何系统关联
# 在图中可以看到有一个明显的曲线关系，这说明可能要对回归模型添加一个二次项

# 正态性 Normal Q-Q 
# 正态QQ图 用于检验残差正态性 如果满足正态假设，
# 那么图上的点就应该均匀的落在呈45°角的直线上（图中虚线），不然就违反了正态性的假设

# 同方差性 Scale-Location 
# 位置尺度图 如果满足同方差性，那么图中水平线周围的点应该随机分布

# Residuals VS Leverage 
# 残差与杠杆图 从图形中可以鉴别出离群点，高杠杆值点和强影响点 
# 离群点：表明拟合回归模型对其预测效果不佳 高杠杆值点：是一个异常的预测变量值的组合 强影响点：表明它对模型参数的估计产生的影响过大，非常不成比例

# 链接：https://www.jianshu.com/p/464bd93c3410


# 正态性-qqPlot()
# 与基础包中的plot()相比，qqPlot()函数提供了更为精确的正态性假设检验的方法，
# 它画出了在n-p-1个自由度的t分布下的残差
library(car)
qqPlot(M_01)


# 线性-crPlots()
# 通过成分残差图也称偏残差图，可以看看因变量与自变量之间是否呈线性关系，
# 也可以看看是否有不同于已设定线性模型的系统偏差，图形可以使用car包中的crPlots()函数绘制
crPlots(M_01)


# spreadlevelPlot()
# spreadlevelPlot()函数则会绘制最佳拟合曲线散点图，
# 如果违反同方差假设，你将会看到一个非水平的曲线
spreadLevelPlot(M_01)




# 异方差
bptest(M_01)  # 0 假设是同方差
ncvTest(M_01)  # 0 假设是方差不变

# multi-colinearity
vif(M_01)






#####################################################################
## --------------------------- link ---------------------------------
#####################################################################

# Further Study
# https://zhuanlan.zhihu.com/p/23310623
# https://www.jianshu.com/p/464bd93c3410
# https://sammo3182.github.io/slides_gh/slides/courses/analysisOfPoliticalData/09_assumptions.html#1
