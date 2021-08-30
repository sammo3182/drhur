fitPage <- function(ft, pgwidth = 6){
 
 ft_out <- ft %>% autofit()
 
 ft_out <- width(ft_out, width = dim(ft_out)$widths*pgwidth /(flextable_dim(ft_out)$widths))
 return(ft_out)
}