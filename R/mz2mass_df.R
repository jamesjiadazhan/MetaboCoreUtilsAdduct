#' @title Calculate monoisotopic mass from a mass-to-charge ratio
#'
#' @description
#'
#' `mz2mass_df` calculates the monoisotopic mass from a mass-to-charge ratio in the long format.
#'
#' @param x A numeric vector of mass-to-charge ratios.
#' @param adduct A character string indicating the adduct. Default is "M+H". If multiple adducts are provided, they should be provided as a vector, like c("M+H", "M+Na").
#'
#' @return A data frame with the mz, adduct, and adduct_mass.
#' @export

mz2mass_df <- function(x, adduct = "M+H") {
    # use the adduct definition in the package
    data(adduct_definition)
    adduct_definition <- adduct_definition %>%
      filter(name %in% adduct)
    
    # Expand grid to get all combinations of x and adducts
    comb <- expand.grid(x = x, name = adduct_definition$name, stringsAsFactors = FALSE)
    # Merge with adduct_definition to get mass_add and mass_multi for each combination
    comb <- merge(comb, adduct_definition, by = "name")
    # Calculate adduct mass
    comb$adduct_mass <- (comb$x - comb$mass_add) / comb$mass_multi
    
    # Arrange columns for clarity
    comb <- comb[, c("x", "name", "adduct_mass")]
    names(comb) <- c("mz", "adduct", "adduct_mass")
    return(comb)
}
