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
