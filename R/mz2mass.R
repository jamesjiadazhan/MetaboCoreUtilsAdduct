#' @title Calculate monoisotopic mass from a mass-to-charge ratio
#'
#' @description
#'
#' `mz2mass` calculates the monoisotopic mass from a mass-to-charge ratio in the wide format.
#'
#' @param x A numeric vector of mass-to-charge ratios.
#' @param adduct A character string indicating the adduct. Default is "M+H". If multiple adducts are provided, they should be provided as a vector, like c("M+H", "M+Na").
#'
#' @return A data frame with the mz, adduct, and adduct_mass.
#' @export

mz2mass <- function(x, adduct = "M+H") {

    # use the adduct definition in the package
    data(adduct_definition)
    adduct_definition = adduct_definition %>% 
        filter(name %in% adduct)


    # calculate the adduct mass in a wide format
    res <- outer(x, adduct_definition$mass_add, "-") / rep(adduct_definition$mass_multi, each = length(x))

    colnames(res) <- adduct_definition$name

    return(res)
}
