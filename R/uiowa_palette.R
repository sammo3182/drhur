# Refer to https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

uiowa_colors <- c(
    `golden`     = "#FFCD00",
    `orange`     = "#FF8200",
    `red`        = "#BD472A",
    `light green` = "#00AF66",
    `green`      = "#00664F",
    `light blue` = "#00A9E0",
    `blue`       = "#00558C",
    `light grey` = "#BBBCBC",
    `dark grey`  = "#63666A",
    `black`      = "#000000"
)


#' Function to extract uiowa colors as hex codes
#'
#' @param ... Character names of uiowa_colors
#'
uiowa_cols <- function(...) {
    cols <- c(...)
    
    if (is.null(cols))
        return (uiowa_colors)
    
    uiowa_colors[cols]
}

uiowa_palettes <- list(
    `tricol`  = uiowa_cols("golden", "dark grey", "black"),
    
    `main`  = uiowa_cols("golden", "black"),
    
    `digitMixed`   = uiowa_cols("golden", "red", "green", "blue", "dark grey", "black"),
    
    `printMixed` = uiowa_cols(
        "golden",
        "orange",
        "light green",
        "light blue",
        "light grey",
        "black"
    ),
    
    `full`  = uiowa_cols(
        "golden",
        "orange",
        "red",
        "light green",
        "green",
        "light blue",
        "blue",
        "light grey",
        "dark grey",
        "black"
    )
)

#' Return function to interpolate a uiowa color palette
#'
#' @param palette Character name of palette in uiowa_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
uiowa_pal <- function(palette = "main",
                      reverse = FALSE,
                      ...) {
    pal <- uiowa_palettes[[palette]]
    
    if (reverse)
        pal <- rev(pal)
    
    colorRampPalette(pal, ...)
}

#' Color scale constructor for uiowa colors
#'
#' @param palette Character name of palette in uiowa_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_uiowa <-
    function(palette = "main",
             discrete = TRUE,
             reverse = FALSE,
             ...) {
        pal <- uiowa_pal(palette = palette, reverse = reverse)
        
        if (discrete) {
            discrete_scale("colour", paste0("uiowa_", palette), palette = pal, ...)
        } else {
            scale_color_gradientn(colours = pal(256), ...)
        }
    }

#' Fill scale constructor for uiowa colors
#'
#' @param palette Character name of palette in uiowa_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_fill_uiowa <-
    function(palette = "main",
             discrete = TRUE,
             reverse = FALSE,
             ...) {
        pal <- uiowa_pal(palette = palette, reverse = reverse)
        
        if (discrete) {
            discrete_scale("fill", paste0("uiowa_", palette), palette = pal, ...)
        } else {
            scale_fill_gradientn(colours = pal(256), ...)
        }
    }
