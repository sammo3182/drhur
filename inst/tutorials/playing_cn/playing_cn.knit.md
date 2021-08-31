---
title: "Learning R with Dr. Hu and His Friends"
output: 
  learnr::tutorial:
    progressive: true
    allow_skip: true
runtime: shiny_prerendered
---



# 课程I: 数据输入／输出

哈！大家好，我是萌萌！欢迎来到“Learning R with Dr. Hu and His Friends”!

现在你进入的是通往`R expert`之路的第一站，我将和胡老师一起引领你走入R的世界，领略其中风采。

希望这节课能让你初步了解R语言的**说话风格**！对，就是“说话风格”——R作为一种编程语言，本质上就是一种与计算机对话的方式。
我们常见的C++, Java和Python也是如此。
了解一种语言的“说话方式”的特点有助于我们更好的通过它与计算机进行“**沟通**”。

## 概念

### 对象是什么？

R是对象指向型编程（Object-oriented programming）语言。
这类语言的基本操作单位是类（class）和对象（object）。
其中，类是概括性的，规定了其所属对象的属性类型，是其所辖对象的模板，比如在`国家`这一类下，所有个体都包含人口、疆域、政权类型等属性。
对象是类模板的一个具象，比如基于`国家`类可以创建的对象`中国`、`法国`、`爱尔兰`等。


### 函数是什么？

<img src="images/handShadow.gif" width="60%" />


```r
light <- function(finger){
  {{shadow <- finger + 5}}
}
handShadow <- light(finger = 3)
handShadow
```

### 数据包是什么

数据包（package）相当于你智能手机里的app。
当你买到手机的时候，功能都是有限的。
通过app，你可以让手机的功能极大丰富起来。

## 知识点

本章节我们将要学习的知识点有以下几个方面：

1.  输入/输出数据
2.  保存数据
3.  合并数据

## 数据输入

### 对象赋值 `<-`

语法：<名称> `<-` <对象>

举例：


```r
aValidObject <- 1:5
aValidObject # 展示对象内容
```

```
## [1] 1 2 3 4 5
```

+ 命名规则
    1. 不要以数字开头 (错误: `1stday`)
    1. 除了 `.` 和 `-`以外没有其他特殊符号(错误: `M&M`)
    1. 区分大小写 (`X != x`) `!表示“非”/“否”，`!=`表示“不等于”
    1. 如需必要请勿重写内置函数 (避免: `list <- c(1:5)`)


### 另一种赋值符 `=`

用法和`<-`等效。
但更多写过更倾向使用 `<-` 而不是 `=`。

Why?

<img src="images/APLkeyBoard.png" width="60%" />

+ 指向直观


```r
a <- 12
25 -> b
```

+ 不可以和“等于”混淆（本章最后一节会详述）
+ 可以通过快捷键一次性输入
    + PC: `Alt + -`
    + Mac: `option + -`


### 什么时候用 "="?
当你不想创建一个对象的时候,请看以下例子

<div class="tutorial-exercise" data-label="sideEffect" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
median(y <- 1:10); y
median(x = 1:10); x
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

### 挑战时间！

请创建一个合规和不合规的对象：

<div class="tutorial-exercise" data-label="objectEg" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
# 一个合规对象

# 试着创建一个不合规的对象
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

> 萌萌：对象赋值是R语言最基本的操作。我习惯简单把这个动作理解成给箭头右边的对象（一条或一组数据、一个数据结果、一幅图等等）取个名字，嘿嘿😋

## 数据读取

### 内置数据


```r
data(mtcars)
#data(gapminder::gapminder)
```

### 可直接读取数据

可读取数据类型

- `.RDS` (单一对象)
- `.RData` (多个对象)
- `.txt` 
- `.csv`

语法： <名称>`<-` <读取函数>(<数据路径>)


```r
df_rds <- readRDS("aDataset.rds")
df_txt <- read.table("D:/aDataset.txt")
df_csv <- read.csv("./aDataset.csv")
```


### 调用包读取数据

通过`library`或者`require`调用数据包，然后使用其中的命令。



```r
# SPSS, Stata, SAS
library(haven)
df_spss <- read_spss("<FileName>.sav")
df_stata <- read_dta("<FileName>.dta")
df_sas <- read_sas("<FileName>.sas7bdat")  

# 表格的快速导入
library（reader）
df_csv <- read.csv("<FileName>.csv")
df_table <- read.table("<FileName>.csv/txt")

# Excel表格
library(readxl)
df_excel <- read_excel("<FileName>.xls")
df_excel2 <- read_excel("<FileName>.xlsx")

# JSON (JavaScript Object Notation)
library(rjson)
df_json <- fromJSON(file = "<FileName>.json" )

# XML/Html
library(xml)
df_xml <- xmlTreeParse("<url>")
df_html <- readHTMLTable(url, which=3)
```


## 数据分类

1. 向量 (vector)
2. 矩阵 (matrix)
3. 数据框 (data frame)
4. 列表 (list)
5. 阵列 (array)


### 向量

向量（vector）是R语言中最基本的数据类型，执行组合功能的函数`c()`可用来创建向量

+ 数字向量（numeric vector）

<div class="tutorial-exercise" data-label="numeric" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
vec_num1 <- c(1, 2, 3) #整数
vec_num2 <- c(1:5) #表示1-5 
vec_num3 <- c(1.5, -2.34, NA)

vec_num1; vec_num2; vec_num3

# c(1.5:3) 的结果是什么?
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

注意: 1. `NA`表示的是: not available
      2. 单个向量中的数据必须拥有相同的类型（数值型、字符型或逻辑型）

+ 字符向量（character vector）

<div class="tutorial-exercise" data-label="character" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
vec_chr <- c("R is hard.", "But I can nail it.")
vec_chr
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

+ 逻辑向量（logic vector）

<div class="tutorial-exercise" data-label="logic" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
vec_tf <- c(TRUE, TRUE, FALSE)
vec_tf
# c(TRUE, TRUE, FALSE) == c(1, 1, 0)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

+ 类别向量（factor vector）

<div class="tutorial-exercise" data-label="factor" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
vec_fac <- factor(c(1, 2, 2, 3), labels = c("Apple", "Pear", "Orange"))
vec_fac
levels(vec_fac)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

水平(Levels)和标签(Lables)

<div class="tutorial-exercise" data-label="level" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
vec_fac2 <- factor(c(1, 2, 2, 3), levels = c(3, 2, 1), labels = c("Apple", "Pear", "Orange"))
vec_fac2
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

> 萌萌：你可以通过`?factor`和[`forcats手册`](https://forcats.tidyverse.org/)了解更多关于类别变量的知识。

+ 时间向量（POSIXct/POSXlt vector）

`as.POSIXct` (numeric input), `as.POSIXlt` (character input)
其中POSIXct是整数存储、POSIXlt是列表存储

```r
Sys.time() # 获取当前时间
```

```
## [1] "2021-08-31 09:24:20 CST"
```

```r
today()   # 获取当日的 年月日
```

```
## [1] "2021-08-31"
```

```r
now()  # 获取当日的 年月日 时分秒  时区
```

```
## [1] "2021-08-31 09:24:20 CST"
```

```r
# CST为操作时电脑ip所在的时区

# The full pack
time1 <- Sys.time()
time2 <- as.POSIXlt(Sys.time())
time2$wday # week of the day
```

```
## [1] 2
```

```r
## 如果我只在乎日期呢？
```


```r
Sys.Date()
```

```
## [1] "2021-08-31"
```

```r
date1 <- as.Date("2019-01-02")
class(date1)  # 查看数据类型
```

```
## [1] "Date"
```

> 萌萌：我不会告诉你`lubridate`是专门用于处理时间的包。

+ 时间处理包`lubridate`
    1. 实时获取日期型数据和日期时间型数据
    2. 自定义生成公式化的日期数据
    3. 实现日期型数据和日期时间型数据的转化
    4. 列出提取Date类中的年月日时分秒等元素

### 矩阵

矩阵（matrix）是具有维度属性的向量，矩阵都是二维的，和向量类似，矩阵中也仅能包含一种数据类型

<img src="images/matrix.gif" width="60%" />

创建矩阵主要有三种方法：

+ 手动创建: `matrix`

```r
A <- matrix(1:20, ncol = 4) #创建一个数字1-20，5行4列的矩阵（col为列，row为行）
A
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    6   11   16
## [2,]    2    7   12   17
## [3,]    3    8   13   18
## [4,]    4    9   14   19
## [5,]    5   10   15   20
```

```r
A[2, 3]
```

```
## [1] 12
```

+ 矢量+维度: `dim()`

```r
M <- c(1:20)
dim(M) <- c(4,5) #4行5列       
M
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    5    9   13   17
## [2,]    2    6   10   14   18
## [3,]    3    7   11   15   19
## [4,]    4    8   12   16   20
```

+ 绑定行/列: `cbind()`和`rbind()`

```r
x <- 1:4
y <- 5:8
cbind (x, y)
```

```
##      x y
## [1,] 1 5
## [2,] 2 6
## [3,] 3 7
## [4,] 4 8
```

```r
rbind (x, y)
```

```
##   [,1] [,2] [,3] [,4]
## x    1    2    3    4
## y    5    6    7    8
```

### 阵列

阵列，顾名思义就是列的“阵”，可用于记录更高维度的数据，可通过`array`函数创建。


```r
# 创建两个长度不同的向量。
vector1 <- c(5,9,3)
vector2 <- c(10,11,12,13,14,15)

# 把这些向量输入到数组中。
result <- array(c(vector1,vector2),dim = c(3,3,2))
result
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    5   10   13
## [2,]    9   11   14
## [3,]    3   12   15
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    5   10   13
## [2,]    9   11   14
## [3,]    3   12   15
```

### 列表

列表（list）是一种可包含多种不同类型对象的向量，是一些对象（或成分，component）的有序集合，列表中既可以有向量也可以有矩阵等。


```r
ls_monks <- list(name = c("Wukong Sun", "Sanzang Tang", "Wuneng Zhu", "Wujing Sha"),
                 power = c(100, 20, 90, 40),
                 buddha = c(TRUE, TRUE, FALSE, FALSE))

ls_monks
```

```
## $name
## [1] "Wukong Sun"   "Sanzang Tang" "Wuneng Zhu"   "Wujing Sha"  
## 
## $power
## [1] 100  20  90  40
## 
## $buddha
## [1]  TRUE  TRUE FALSE FALSE
```

+ 数据框

数据框（Data Frame）是一种特殊的列表/矩阵，其中所用元素长度都相等，列表中的每个元素都可以看作一列，每个元素的长度可以看作行数。

在Excel中:

<img src="images/excel-r1.png" width="60%" />

在R中，使用`data.frame()`创建数据框


```r
df_toy <- data.frame(female = c(0,1,1,0),
           age = c(29, 39, 38, 12),
           name = c("Iron Man", "Black Widow", "Captain Marvel", "Captain America"))

df_toy
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["female"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["age"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["name"],"name":[3],"type":["chr"],"align":["left"]}],"data":[{"1":"0","2":"29","3":"Iron Man"},{"1":"1","2":"39","3":"Black Widow"},{"1":"1","2":"38","3":"Captain Marvel"},{"1":"0","2":"12","3":"Captain America"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

在Rstudio中:


```r
knitr::include_graphics("images/excel-r2.png")
```

<img src="images/excel-r2.png" width="565" />


## 合并数据

### 数据示例

我们采用瑞典学者Hans Rosling在[TED 演讲](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen?utm_campaign=tedspread--b&utm_medium=referral&utm_source=tedcomshare)中使用的人口数据作为案例来进行下面的讲述。
让我们首先来看看数据

<div class="tutorial-exercise" data-label="toy" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
library(gapminder)
gapminder
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

### 行合并

<img src="images/rowBind.png" width="95%" />

假设我们有亚洲和欧洲人口数据，如何把它们合并在一起呢？

<div class="tutorial-exercise" data-label="ex_append" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
gapminder_asia <- gapminder[gapminder$continent == "Asia", 1:2]
gapminder_europe <- gapminder[gapminder$continent == "Europe", 1:2]
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

<div class="tutorial-exercise-support" data-label="ex_append-solution" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
library(dplyr)

gapminder_eurasia <- bind_rows(gapminder_asia, gapminder_europe) #按行连接，不需要列名相同
```

</div>

### 列合并

如果我们有一系列的变量，都是来自同一组国家的，如何把他们整合在一起？

<img src="images/columnBind.png" width="95%" />

<div class="tutorial-exercise" data-label="ex_columnBind" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
gapminder_country <- gapminder$country
gapminder_year <- gapminder$year
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

<div class="tutorial-exercise-support" data-label="ex_columnBind-solution" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
bind_cols(gapminder_country, gapminder_year) #按列结合时需要行名相同
```

</div>

### 索引合并

`dplyr::*_joint`函数

<img src="images/join.png" width="95%" />

1. 左连接（left_jion): 保留x中的所有观测,如果x中的key变量,在y中有多个同样的key,那么所有的结合可能都会罗列出来。


```r
left_join(x, y, by = "key")
```

2. 右连接(right_jion): 保留 y 中的所有观测


```r
right_join(x, y, by = "key")
```

### 挑战时间

如果我们有两组数据分别来自不同的源头，又有不同的行数，该如何把它们准确的合并在一起呢？

<div class="tutorial-exercise" data-label="ex_join" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
gapminder_country <- select(gapminder, country, year)
gapminder_year <- select(gapminder, year, pop)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

<div class="tutorial-exercise-support" data-label="ex_join-solution" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
gapminder_countryYear<- left_join(gapminder_country, gapminder_year)
```

</div>

> 萌萌：在操作上，行合并的关键是每行都有相同的列，列合并则需要每列行数相同。索引合并时，一定要确定两个数据的索引内容是能很好对应的，否则后果惨烈……请不要问我是怎么知道的~

## 数据输出

语法：<函数>(<代存数据>，file = <存储路径>)

### 储存为R数据


```r
saveRDS(gapminder_country, file = "gapminder_country.rds")
save(gapminder_country, gapminder_year, file = "gapminder.rdata")
```


### 储存为csv文件


```r
write.csv(gapminder_country, file = "gapminder_country.csv")
```

提示: 如果你的数据是中文的，可能会出现存储csv乱码现象。
这个我们之后遇到时候再讲解。

当然了，你可以把数据以STATA, SPSS, Excel格式存储下来, 不过你真的想这样吗？

### 体面地储存数据

STATA (.dta, \<14): 3.16 G = R (.rds): 0.05 G

| **Method**       | **Average Time** | **Minimum** | **Maximum** |
|:-----------------|:----------------:|:-----------:|:-----------:|
| base::readRDS    |       19.65      |    18.64    |    21.01    |
| fst::read\_fst   |       1.39       |     0.56    |     3.41    |
| haven::read\_sav |      104.78      |    101.00   |    111.85   |
| qs::qread        |       3.33       |     3.00    |     4.24    |

: 四种在R中读取GSS数据的方式所用的平均时间（以秒计）

| **Method**      | **Average Time** | **Minimum** | **Maximum** | **File Size** |
|:----------------|:----------------:|:-----------:|:-----------:|:-------------:|
| base::saveRDS   |       98.36      |    93.09    |    103.24   |    30.9 MB    |
| fst::write\_fst |       2.70       |     1.86    |     4.05    |    122.1 MB   |
| qs::qsave       |       5.03       |     4.35    |     6.62    |    44.6 MB    |

: 在R中写入GSS数据（及文件大小）所用的平均时间


## 在R里做数学

<div class="tutorial-exercise" data-label="math" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
x <- y <- 42

# 基础数学
x + (1 - 2) * 3 / 4

# 高等数学
x^2;sqrt(x);log(x);exp(x)

# 矩阵运算
z <- matrix(1:4, ncol = 2)
z + z - z
z %*% z  # inner multiplication
z %o% z  # outter multiplication

# 布尔逻辑计算
x == y; x != y
x & y; x | y
x > y; x <= y
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4,"fig.retina":2,"fig.align":"default","fig.keep":"high","fig.show":"asis","out.width":624,"warning":true,"error":false,"message":true,"exercise.df_print":"paged","exercise.checker":"NULL"}</script></div>

在[这里](https://towardsdatascience.com/intro-to-r-linear-algebra-2a4de2506c93)查看更多线性代数在 R 中的应用。

## 总结

1. 输入
    + `readTYPE`
    + `read_type`
    + `read.type`
1. 保存
    + 向量
    + 矩阵/data.frame
    + 列表, 数组
1. 输出
    + `save`
    + `saveTYPE`

###

Dr.Hu和萌萌：今天就到这里啦!下次再见！

<i class="fa fa-envelope fa-lg"></i> <yuehu@tsinghua.edu.cn>

<i class="fa fa-globe fa-lg"></i> <https://sammo3182.github.io/>

<i class="fab fa-github fa-lg"></i> [sammo3182](https://github.com/sammo3182)
preservebe9ceb1efbabf307
preserve468c4b701e1ac150
preserve367c3e80b830f24c
preserve02a7973b121c659e
preserve21fb5fc8ac76aecd
preserve072631cdd5868fc1
preserve25346d94fab4f1ff
preserve43e83b367c387c81
preserve1d5002c133b3fbad
preservee3010aa3622e30d8
preserve5f18ee9a32be0f1c
preserve0233dacc3340a114
preserveca7c71c68eb50258
preserve217bf0e43bfd1734
preservec041c921522d00f3
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="dependencies">
{"type":"list","attributes":{},"value":[{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["header-attrs"]},{"type":"character","attributes":{},"value":["2.10"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/pandoc"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["header-attrs.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["jquery"]},{"type":"character","attributes":{},"value":["1.11.3"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/jquery"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["jquery.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["bootstrap"]},{"type":"character","attributes":{},"value":["3.3.5"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/bootstrap"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["viewport"]}},"value":[{"type":"character","attributes":{},"value":["width=device-width, initial-scale=1"]}]},{"type":"character","attributes":{},"value":["js/bootstrap.min.js","shim/html5shiv.min.js","shim/respond.min.js"]},{"type":"character","attributes":{},"value":["css/cerulean.min.css"]},{"type":"character","attributes":{},"value":["<style>h1 {font-size: 34px;}\n       h1.title {font-size: 38px;}\n       h2 {font-size: 30px;}\n       h3 {font-size: 24px;}\n       h4 {font-size: 18px;}\n       h5 {font-size: 16px;}\n       h6 {font-size: 12px;}\n       code {color: inherit; background-color: rgba(0, 0, 0, 0.04);}\n       pre:not([class]) { background-color: white }<\/style>"]},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["pagedtable"]},{"type":"character","attributes":{},"value":["1.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/pagedtable-1.1"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["js/pagedtable.js"]},{"type":"character","attributes":{},"value":["css/pagedtable.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["highlightjs"]},{"type":"character","attributes":{},"value":["9.12.0"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/highlightjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["highlight.js"]},{"type":"character","attributes":{},"value":["textmate.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial.js"]},{"type":"character","attributes":{},"value":["tutorial.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial-autocompletion"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial-autocompletion.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial-diagnostics"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial-diagnostics.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial-format"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmarkdown/templates/tutorial/resources"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial-format.js"]},{"type":"character","attributes":{},"value":["tutorial-format.css","rstudio-theme.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["jquery"]},{"type":"character","attributes":{},"value":["1.11.3"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/jquery"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["jquery.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["navigation"]},{"type":"character","attributes":{},"value":["1.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/navigation-1.1"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tabsets.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["highlightjs"]},{"type":"character","attributes":{},"value":["9.12.0"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/highlightjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["highlight.js"]},{"type":"character","attributes":{},"value":["default.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["jquery"]},{"type":"character","attributes":{},"value":["1.11.3"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/jquery"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["jquery.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["font-awesome"]},{"type":"character","attributes":{},"value":["5.1.0"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["rmd/h/fontawesome"]}]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["css/all.css","css/v4-shims.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["rmarkdown"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["2.10"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["bootbox"]},{"type":"character","attributes":{},"value":["4.4.0"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/bootbox"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["bootbox.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["idb-keyvalue"]},{"type":"character","attributes":{},"value":["3.2.0"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/idb-keyval"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["idb-keyval-iife-compat.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[false]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial.js"]},{"type":"character","attributes":{},"value":["tutorial.css"]},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial-autocompletion"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial-autocompletion.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["tutorial-diagnostics"]},{"type":"character","attributes":{},"value":["0.10.1"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/tutorial"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["tutorial-diagnostics.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["ace"]},{"type":"character","attributes":{},"value":["1.2.6"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/ace"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["ace.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["name","version","src","meta","script","stylesheet","head","attachment","package","all_files","pkgVersion"]},"class":{"type":"character","attributes":{},"value":["html_dependency"]}},"value":[{"type":"character","attributes":{},"value":["clipboardjs"]},{"type":"character","attributes":{},"value":["1.5.15"]},{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["file"]}},"value":[{"type":"character","attributes":{},"value":["lib/clipboardjs"]}]},{"type":"NULL"},{"type":"character","attributes":{},"value":["clipboard.min.js"]},{"type":"NULL"},{"type":"NULL"},{"type":"NULL"},{"type":"character","attributes":{},"value":["learnr"]},{"type":"logical","attributes":{},"value":[true]},{"type":"character","attributes":{},"value":["0.10.1"]}]}]}
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="execution_dependencies">
{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["packages"]}},"value":[{"type":"list","attributes":{"names":{"type":"character","attributes":{},"value":["packages","version"]},"class":{"type":"character","attributes":{},"value":["data.frame"]},"row.names":{"type":"integer","attributes":{},"value":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84]}},"value":[{"type":"character","attributes":{},"value":["assertthat","backports","base","broom","bslib","cellranger","cli","colorspace","compiler","crayon","datasets","DBI","dbplyr","digest","dplyr","ellipsis","evaluate","fansi","fastmap","forcats","fs","gapminder","generics","ggplot2","glue","graphics","grDevices","grid","gtable","haven","highr","hms","htmltools","htmlwidgets","httpuv","httr","jquerylib","jsonlite","knitr","later","learnr","lifecycle","lubridate","magrittr","markdown","methods","mime","modelr","munsell","pillar","pkgconfig","png","promises","purrr","R6","Rcpp","readr","readxl","reprex","rlang","rmarkdown","rprojroot","rstudioapi","rvest","sass","scales","shiny","stats","stringi","stringr","tibble","tidyr","tidyselect","tidyverse","tools","tzdb","utf8","utils","vctrs","withr","xfun","xml2","xtable","yaml"]},{"type":"character","attributes":{},"value":["0.2.1","1.2.1","4.1.1","0.7.9","0.2.5.1","1.1.0","3.0.1","2.0-2","4.1.1","1.4.1","4.1.1","1.1.1","2.1.1","0.6.27","1.0.7","0.3.2","0.14","0.5.0","1.1.0","0.5.1","1.5.0","0.3.0","0.1.0","3.3.5","1.4.2","4.1.1","4.1.1","4.1.1","0.3.0","2.4.3","0.9","1.1.0","0.5.1.1","1.5.3","1.6.2","1.4.2","0.1.4","1.7.2","1.33","1.3.0","0.10.1","1.0.0","1.7.10","2.0.1","1.1","4.1.1","0.11","0.1.8","0.5.0","1.6.2","2.0.3","0.1-7","1.2.0.1","0.3.4","2.5.0","1.0.7","2.0.1","1.3.1","2.0.1","0.4.11","2.10","2.0.2","0.13","1.0.1","0.4.0","1.1.1","1.6.0","4.1.1","1.7.3","1.4.0","3.1.3","1.1.3","1.1.1","1.3.1","4.1.1","0.1.2","1.2.2","4.1.1","0.3.8","2.4.2","0.25","1.3.2","1.8-4","2.2.1"]}]}]}
</script>
<!--/html_preserve-->
