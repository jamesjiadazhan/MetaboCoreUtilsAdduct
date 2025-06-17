#' @title Calculate mass-to-charge ratio from a monoisotopic mass
#'
#' @description
#'
#' `mass2mz` calculates the mass-to-charge ratio from a monoisotopic mass in the wide format.
#'
#' @param x A numeric vector of monoisotopic masses.
#' @param adduct A character string indicating the adduct. Default is "M+H". If multiple adducts are provided, they should be provided as a vector, like c("M+H", "M+Na").
#'
#' @return A data frame with the mass, adduct, and mz.
#' @export

mass2mz <- function(x, adduct = "M+H") {

    #  use the adduct definition in the package
    data(adduct_definition)
    adduct_definition = adduct_definition %>% 
        filter(name %in% adduct)

    # calculate the adduct mass in a wide format
    res <- outer(x, adduct_definition$mass_multi) +
        rep(adduct_definition$mass_add, each = length(x))

    # give the columns the name of the adduct
    colnames(res) <- adduct_definition$name

    # add the mass column
    res = cbind(mass = x, res) 

    res = as.data.frame(res) 

    res = res %>%
        select(mass, everything())

    # return the result
    return(res)
}
