## ----setup, include=FALSE-----------------------------------------------------
library(kableExtra)

## ---- results='asis', echo=FALSE----------------------------------------------
txt <- data.frame(
  Function = 
    c('<a href="#playing">playing</a>',
      '<a href="#munging">munging</a>',
      '<a href="#analyzing">analyzing</a>',
      '<a href="#visualizing">visualizing</a>&nbsp;&nbsp;'),
  Description = 
    c('**Playing around with R:** Intro to basic data structure in R; inputting, outputting, and creating data.',
      paste('**Data munging: ** Generalizing (such as sorting and summarizing) and extracting (selecting or adjusting certain columns or rows) data frames.'),
      paste('**Data analyzing:** Analyze data with descriptive and multivariate tools and diagnoses.'),
      paste("**Data presenting:** Present descriptive and analytic results with 'ggplot2'")),
  Usage = 
    c('`drhur(playing)`',
      paste('`drhur(munging)`'),
      paste('`drhur(analyzing)`'),
      paste('`drhur(visualizing)`'))
  )

kable(txt, format = "html", escape = FALSE, align = c('l', 'l')) %>%
  kable_styling(full_width = FALSE, position = "left") %>%
  column_spec(1, bold = TRUE, monospace = TRUE, border_right = TRUE) %>%
  column_spec(2, width = "28em") %>%
  column_spec(3, width = "28em")

