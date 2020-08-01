## ----setup, include=FALSE-----------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)

library(learnr)
library(ggthemes)
library(scales)
library(gt)
library(modelsummary)
library(dotwhisker)
library(interplot)
library(likert)
library(tidyverse)
library(gapminder)


# Functions preload
set.seed(114)

# Data of incubation

incubation_data = data.frame(
  sname = factor(
    c(
      "Minimum\n0%",
      "2.5%",
      "Median\n50%",
      "Average",
      "97.5%",
      "Maximum\n100%"
    ),
    levels = c(
      "Minimum\n0%",
      "2.5%",
      "Median\n50%",
      "Average",
      "97.5%",
      "Maximum\n100%"
    ),
    ordered = TRUE
  ),
  svalue = c(0, 2.2, 5.1, 5.5, 11.5, 14),
  stext = c(
    "\n(Unknown)",
    "\n2.2 days",
    "\n5.1 days",
    "\n5.5 days",
    "\n11.5 days",
    "\n14 days"
  )
)

## Data of cfr

age_groups <-
  c("≤9",
    "10-19",
    "20-29",
    "30-39",
    "40-49",
    "50-59",
    "60-69",
    "70-79",
    "≥80")
cfr_china <-
  data.frame(
    age = factor(age_groups, levels = age_groups, ordered = TRUE),
    deaths = c(0, 1, 7, 18, 38, 130, 309, 312, 208),
    cases = c(416, 549, 3619, 7600, 8571, 10008, 8583, 3918, 1408),
    cfr = 0.01 * c(0, 0.18, 0.19, 0.23, 0.44, 1.3, 3.6, 8., 14.8)
  )

## data of liker

input <- ("
  Mask    Bleach  WashHand
  3       2       4
  5       4       4
  4       2       4
  4       2       4
  4       1       5
  4       2       3
  4       3       5
  4       2       4
  5       2       4
  5       3       3
")

df_likert <- read.table(textConnection(input), header = TRUE)

df_likert$Mask <- factor(df_likert$Mask,
                   levels = c("1", "2", "3", "4", "5"),
                   ordered = TRUE)

df_likert$Bleach <- factor(df_likert$Bleach,
                     levels = c("1", "2", "3", "4", "5"),
                     ordered = TRUE)

df_likert$WashHand <- factor(df_likert$WashHand,
                     levels = c("1", "2", "3", "4", "5"),
                     ordered = TRUE)

m1 <- lm(mpg ~ cyl + hp + wt, data = mtcars)
m2 <- lm(mpg ~ cyl + hp + wt + hp, data = mtcars)
m3 <- lm(mpg ~ cyl + hp + wt + hp + am, data = mtcars)

m_cyl <- lm(mpg ~ wt * cyl, data = mtcars)


## ----out.width = "100%", echo = FALSE-----
knitr::include_graphics("images/picThanWords.jpg")


## ----goal-plots, results="hide", out.width="100%", echo=FALSE----
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(scales)) install.packages("scales")
if (!require(ggthemes)) install.packages("ggthemes")
if (!require(gapminder)) install.packages("gapminder")

library(ggplot2) # major function
library(ggthemes) # outlook
library(scales) # scale of the axes
library(gapminder) # data

gapminder_2007 <- filter(gapminder, year == 2007)

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, size = pop, 
                 color = continent), 
             alpha = 0.5)

ggplot(cfr_china, aes(x=age, y=cfr, group=1)) +
  geom_line() +
  geom_hline(yintercept = 0.01 * 2.3, linetype="dashed", alpha=0.5) +
  geom_bar(aes(width=cases/10000, fill=age), stat = "identity", position = "identity") +
  geom_text(aes(label=paste0(cfr*100,"%")), family="Palatino", size=3, nudge_y = 0.04) +
  geom_text(aes(label=paste0("(",deaths,"/",cases,")")), family="Palatino", size=3, nudge_y = 0.03) +
  scale_y_continuous(labels = percent) +
  scale_fill_tableau(palette = "Classic 10 Medium") +
  labs(title = "COVID-19 Case Fatality Rate (CFR) by Age Groups",
       subtitle = "Among 44,672 confirmed cases in China through February 11\nOverall CFR = 2.3% (dotted line)",
       x = "Age Group", y = NULL,
       caption = "Source: Characteristics of and Important Lessons From the Coronavirus Disease 2019 (COVID-19) Outbreak in China:\nSummary of a Report of 72314 Cases From the Chinese Center for Disease Control and Prevention. Wu Z, McGoogan JM. JAMA. 2020\nhttps://jamanetwork.com/journals/jama/fullarticle/2762130 and http://weekly.chinacdc.cn/en/article/id/e53946e2-c6c4-41e9-9a9b-fea8db1a8f51") +
  theme_minimal(base_size = 14, base_family = "Palatino") +
  theme(plot.caption = element_text(face = "italic", size=6),
        legend.position = "none")


ggplot(incubation_data, aes(ymax = svalue, ymin = 0, xmax = 2, xmin = 1, fill = sname)) +
  geom_rect(aes(ymax=14, ymin=0, xmax=2, xmin=1), fill ="#ece8bd") +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + 
  xlim(c(0, 2)) + ylim(c(0,28)) +
  scale_fill_few(palette = "Medium") +
  scale_color_few(palette = "Medium") +
  geom_text(aes(x = 0, y = 0, label=stext, colour=sname), size=4, family="Palatino") +
  facet_wrap(~sname, ncol = 3) +
  guides(fill=FALSE, colour=FALSE) +
  labs(title="COVID-19 Incubation Time", 
       subtitle = "Time before infected person becomes symptomatic\n (percentiles and mean) ",
       caption = "Source: COVID-19 Incubation Period: An Update. Stephen G. Baum, MD\n reviewing Lauer SA et al. Ann Intern Med 2020 Mar 10\nhttps://www.jwatch.org/na51083/2020/03/13/covid-19-incubation-period-update", 
       x=NULL, y=NULL) +
  theme_tufte(ticks = FALSE, base_size = 12, base_family = "Palatino") +
  theme(axis.text = element_blank(),
        plot.caption = element_text(face = "italic", size=6),
        strip.text = element_text(size = 12))


## ----basePlot, exercise = TRUE------------
hist(mtcars$mpg)


## ----saving, eval = F---------------------
## png("<working directory>/histgraph.png")
## hist(mtcars$mpg)
## dev.off()


## ----out.width = "100%", echo = FALSE-----
knitr::include_graphics("images/ggplot_geom.png")


## ----basic, eval = FALSE------------------
## ggplot(___) +
##   geom_point(
##     mapping = aes(x = ___, y = ___,
##                   color = ___,
##                   size  = ___),
##     alpha  = ___
##   )


## ----pointGoal,echo=FALSE-----------------
library(gapminder)

gapminder_2007 <- filter(gapminder, year == 2007)

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, size = pop, 
                 color = continent), 
             alpha = 0.5)


## ----point, exercise = TRUE---------------
library(gapminder)

gapminder_2007 <- filter(gapminder, year == 2007)

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp))


## ----point-solution-----------------------
# Color adjustment
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 color = continent))

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 color = pop))

# Size adjustment
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop)) + 
  scale_size_area(max_size = 10)

# Transparency adjustment
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, size = pop), 
             alpha = 0.5)

# Combo

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, size = pop, 
                 color = continent), 
             alpha = 0.5)


## ----cfr-df, echo = FALSE-----------------
# Case Fatality Rate

cfr_china


## ----cfr-plot, echo = FALSE---------------
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(scales)) install.packages("scales")
if (!require(ggthemes)) install.packages("ggthemes")

library(ggplot2)
library(scales)
library(ggthemes)

ggplot(cfr_china, aes(x=age, y=cfr, group=1)) +
  geom_line() +
  geom_hline(yintercept = 0.01 * 2.3, linetype="dashed", alpha=0.5) +
  geom_bar(aes(width=cases/10000, fill=age), stat = "identity", position = "identity") +
  geom_text(aes(label=paste0(cfr*100,"%")), family="Palatino", size=3, nudge_y = 0.04) +
  geom_text(aes(label=paste0("(",deaths,"/",cases,")")), family="Palatino", size=3, nudge_y = 0.03) +
  scale_y_continuous(labels = percent) +
  scale_fill_tableau(palette = "Classic 10 Medium") +
  labs(title = "COVID-19 Case Fatality Rate (CFR) by Age Groups",
       subtitle = "Among 44,672 confirmed cases in China through February 11\nOverall CFR = 2.3% (dotted line)",
       x = "Age Group", y = NULL,
       caption = "Source: Characteristics of and Important Lessons From the Coronavirus Disease 2019 (COVID-19) Outbreak in China:\nSummary of a Report of 72314 Cases From the Chinese Center for Disease Control and Prevention. Wu Z, McGoogan JM. JAMA. 2020\nhttps://jamanetwork.com/journals/jama/fullarticle/2762130 and http://weekly.chinacdc.cn/en/article/id/e53946e2-c6c4-41e9-9a9b-fea8db1a8f51") +
  theme_minimal(base_size = 14, base_family = "Palatino") +
  theme(plot.caption = element_text(face = "italic", size=6),
        legend.position = "none")


## ----steps, exercise = TRUE---------------
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(scales)) install.packages("scales")
if (!require(ggthemes)) install.packages("ggthemes")

library(ggplot2)
library(scales)
library(ggthemes)

ggplot(data = cfr_china,
       aes(x = age, y = cfr, group = 1))


## ----steps-solution-----------------------
ggplot(data = cfr_china,
       aes(x = age, y = cfr, group = 1)) + 
  geom_bar(aes(width = cases / 10000, fill = age),
           stat = "identity",
           position = "identity") +
  geom_hline(yintercept = 0.01 * 2.3,
             linetype = "dashed",
             alpha = 0.5) +
  geom_line() +
  geom_text(
    aes(label = paste0(cfr * 100, "%")),
    family = "Palatino",
    size = 3,
    nudge_y = 0.04
  ) +
  geom_text(
    aes(label = paste0("(", deaths, "/", cases, ")")),
    family = "Palatino",
    size = 3,
    nudge_y = 0.03
  ) +
  scale_y_continuous(labels = percent) +
  scale_fill_tableau(palette = "Classic 10 Medium") + 
  labs(
    title = "COVID-19 Case Fatality Rate (CFR) by Age Groups",
    subtitle = "Among 44,672 confirmed cases in China through February 11\nOverall CFR = 2.3% (dotted line)",
    x = "Age Group",
    y = NULL,
    caption = "Source: Characteristics of and Important Lessons From the Coronavirus Disease 2019 (COVID-19) Outbreak in China:\nSummary of a Report of 72314 Cases From the Chinese Center for Disease Control and Prevention. Wu Z, McGoogan JM. JAMA. 2020\nhttps://jamanetwork.com/journals/jama/fullarticle/2762130 and http://weekly.chinacdc.cn/en/article/id/e53946e2-c6c4-41e9-9a9b-fea8db1a8f51"
  ) +
  theme_minimal(base_size = 14, base_family = "Palatino") +
  theme(plot.caption = element_text(face = "italic", size = 6),
        legend.position = "none")


## ----save, eval = FALSE-------------------
## ggsave("cfr.png")


## ----incubation-df, echo = FALSE----------
incubation_data %>% 
  mutate(sname = c("0%", "2.5%", "50%", "Average", "97.5%", "100%"),
         stext = str_sub(stext, start = 2))


## ----incubation-plot, echo = FALSE--------
ggplot(incubation_data, aes(ymax = svalue, ymin = 0, xmax = 2, xmin = 1, fill = sname)) +
  geom_rect(aes(ymax=14, ymin=0, xmax=2, xmin=1), fill ="#ece8bd") +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + 
  xlim(c(0, 2)) + ylim(c(0,28)) +
  scale_fill_few(palette = "Medium") +
  scale_color_few(palette = "Medium") +
  geom_text(aes(x = 0, y = 0, label=stext, colour=sname), size=4, family="Palatino") +
  facet_wrap(~sname, ncol = 3) +
  guides(fill=FALSE, colour=FALSE) + # removed the legend
  labs(title="COVID-19 Incubation Time", 
       subtitle = "Time before infected person becomes symptomatic\n(percentiles and mean) ",
       caption = "Source: COVID-19 Incubation Period: An Update. Stephen G. Baum, MD\n reviewing Lauer SA et al. Ann Intern Med 2020 Mar 10\nhttps://www.jwatch.org/na51083/2020/03/13/covid-19-incubation-period-update", 
       x=NULL, y=NULL) +
  theme_tufte(ticks = FALSE, base_size = 12, base_family = "Palatino") +
  theme(axis.text = element_blank(),
        plot.caption = element_text(face = "italic", size=6),
        strip.text = element_text(size = 12))


## ----incubation, exercise = TRUE----------
ggplot(incubation_data,
       aes(
         ymax = svalue,
         ymin = 0,
         xmax = 2,
         xmin = 1,
         fill = sname
       )) 


## ----incubation-solution------------------
ggplot(incubation_data,
       aes(
         ymax = svalue,
         ymin = 0,
         xmax = 2,
         xmin = 1,
         fill = sname
       )) +
  geom_rect(aes(
    ymax = 14,
    ymin = 0,
    xmax = 2,
    xmin = 1
  ), fill = "#ece8bd") +
  geom_rect() +
  coord_polar(theta = "y", start = -pi / 2) +
  xlim(c(0, 2)) + ylim(c(0, 28)) +
  scale_fill_few(palette = "Medium") +
  scale_color_few(palette = "Medium") +
  geom_text(aes(
    x = 0,
    y = 0,
    label = stext,
    colour = sname
  ),
  size = 4,
  family = "Palatino") +
  facet_wrap( ~ sname, ncol = 3) +
  guides(fill = FALSE, colour = FALSE) +
  labs(
    title = "COVID-19 Incubation Time",
    subtitle = "Time before infected person becomes symptomatic\n(percentiles and mean) ",
    caption = "Source: COVID-19 Incubation Period: An Update. Stephen G. Baum, MD\n reviewing Lauer SA et al. Ann Intern Med 2020 Mar 10\nhttps://www.jwatch.org/na51083/2020/03/13/covid-19-incubation-period-update",
    x = NULL,
    y = NULL
  ) +
  theme_tufte(ticks = FALSE,
              base_size = 12,
              base_family = "Palatino") +
  theme(
    axis.text = element_blank(),
    plot.caption = element_text(face = "italic", size = 6),
    strip.text = element_text(size = 12)
  )


## ----likert, exercise = TRUE--------------
df_likert

if (!require(likert)) install.packages("likert")
library(likert)

likert(df_likert) %>%
  plot(type = "bar")


## ----likert-solution----------------------
likert(df_likert) %>%
  plot(
    type = "heat",
    low.color = "white",
    high.color = "blue",
    text.color = "black",
    text.size = 4,
    wrap = 50
  )

likert(df_likert) %>%
  plot(type = "density",
       facet = TRUE,
       bw = 0.5)


## ----dotwhisker, exercise = TRUE----------
m1 <- lm(mpg ~ cyl + hp + wt, data = mtcars)


## ----dotwhisker-solution------------------
if (!require(dotwhisker)) install.packages("dotwhisker")
library(dotwhisker)

dwplot(m1)


## ----dwMulti, exercise = TRUE-------------
m2 <- lm(mpg ~ cyl + hp + wt + hp, data = mtcars)
m3 <- lm(mpg ~ cyl + hp + wt + hp + am, data = mtcars)

dwplot(list(m1, m2, m3))


## ----dwMulti-solution---------------------
dwplot(list(m1, m2, m3)) %>%
  relabel_predictors(
    c(
      wt = "Weight",
      cyl = "Cylinders",
      disp = "Displacement",
      hp = "Horsepower",
      gear = "Gears",
      am = "Manual"
    )
  ) +
  theme_bw() + xlab("Coefficient Estimate") + ylab("") +
  geom_vline(xintercept = 0,
             colour = "grey60",
             linetype = 2) +
  ggtitle("Predicting Gas Mileage") +
  theme(
    plot.title = element_text(face = "bold"),
    legend.justification = c(0, 0),
    legend.position = c(0, 0),
    legend.background = element_rect(colour = "grey80"),
    legend.title = element_blank()
  ) 


## ----smallMultiple, exercise = TRUE-------
small_multiple(list(m1, m2, m3)) +
  ylab("Coefficient Estimate") +
  geom_hline(yintercept = 0,
             colour = "grey60",
             linetype = 2) +
  ggtitle("Predicting Gas Mileage") +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "none",
    axis.text.x  = element_text(angle = 60, hjust = 1)
  ) 


## ----interact, exercise = TRUE------------
m_cyl <- lm(mpg ~ wt * cyl, data = mtcars)
summary(m_cyl)


## ----interact-solution--------------------
if (!require(interplot)) install.packages("interplot")
library(interplot)

interplot(m = m_cyl, var1 = "cyl", var2 = "wt")
interplot(m = m_cyl, var1 = "wt", var2 = "cyl")


## ----interHist----------------------------
interplot(m = m_cyl, var1 = "cyl", var2 = "wt", hist = TRUE) +
    geom_hline(yintercept = 0, linetype = "dashed")


## ----interFactor--------------------------
mtcars$gear <- factor(mtcars$gear)
m_gear <- lm(mpg ~ gear * wt, data = mtcars)

interplot(m = m_gear, var1 = "wt", var2 = "gear")


## ----network------------------------------
if (!require(network)) install.packages("network")
if (!require(sna)) install.packages("sna")

library(network)
library(sna)
n <- network(rgraph(10, tprob = 0.2), directed = FALSE)

n %v% "family" <- sample(letters[1:3], 10, replace = TRUE)
n %v% "importance" <- sample(1:3, 10, replace = TRUE)

e <- network.edgecount(n)
set.edge.attribute(n, "type", sample(letters[24:26], e, replace = TRUE))
set.edge.attribute(n, "day", sample(1:3, e, replace = TRUE))

if (!require(ggnetwork)) install.packages("ggnetwork")
library(ggnetwork)

ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(aes(linetype = type), color = "grey50") +
  geom_nodes(aes(color = family, size = importance)) +
  theme_blank()


## ----map, message=FALSE, cache=TRUE-------
if (!require(ggmap)) install.packages("ggmap")
library(ggmap)

china <- c(left = 72, bottom = 0, right = 135, top = 52)

get_stamenmap(china, zoom = 5, maptype = "toner-lite") %>% 
  ggmap() 


## ----modeltable, exercise = TRUE----------
summary(m1); summary(m2); summary(m3)

if (!require(gt)) install.packages("gt")
if (!require(modelsummary)) install.packages("modelsummary")
library(modelsummary)
library(gt)


## ----modeltable-solution------------------
msummary(list(m1, m2, m3),
         stars = TRUE,
         title =  gt::md('This is *the* title'),
         subtitle = 'And a subtitle',
         notes = list('A first note', gt::md('A **bold** note'))) %>%
  tab_style(style = cell_fill(color = "lightcyan"),
			  locations = cells_body(columns = vars(`Model 2`), rows = 3:4)
			  )


## ----modelOut, eval = FALSE---------------
## msummary(models, filename = 'table.tex')
## msummary(models, filename = 'table.rtf')
## msummary(models, filename = 'table.html')
## msummary(models, filename = 'table.jpeg')
## msummary(models, filename = 'table.png')

