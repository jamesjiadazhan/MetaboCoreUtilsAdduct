mass2mz_df <- function(mass, adduct = "M+H") {
    data(adduct_definition)

    # create a dataframe with the mass and adduct columns
    mass_adduct = data.frame(mass=mass, adduct=adduct)

    # left join the mass_adduct dataframe with the adduct_definition dataframe
    mass_adduct_adduct_definition = left_join(mass_adduct, adduct_definition, by = c("adduct" = "name"))
    
    mass_adduct_adduct_definition$mz = (mass_adduct_adduct_definition$mass * mass_adduct_adduct_definition$mass_multi) + mass_adduct_adduct_definition$mass_add

    # select only the mass, adduct, and adduct_mass columns
    mass_adduct_adduct_definition = mass_adduct_adduct_definition[, c("mass", "adduct", "mz")]

    return(mass_adduct_adduct_definition)
}
