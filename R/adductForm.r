# Write a function to determine the adduct forms given the provided monoisotopic masses and m/z
adductForm = function(mass, mz, ion_mode="positive", mass_accuracy=10){
    data(adduct_definition)

    # if ion_mode is positive, filter the adduct_definition dataframe to only include positive adducts (positive == TRUE). Otherwise, filter the adduct_definition dataframe to only include negative adducts (positive == FALSE)
    if (ion_mode == "positive"){
        adduct_definition = adduct_definition[adduct_definition$positive == TRUE,]
    } else {
        adduct_definition = adduct_definition[adduct_definition$positive == FALSE,]
    }

    # create a data frame with the mass and mz columns
    mass_mz = data.frame(mass = mass, mz = mz)

    # pull a comprehensive list of adducts from adduct_definition
    adduct = adduct_definition$name

    # Cross join adducts with mass_mz to form a adduct list for each unique record
    mass_mz_adduct <- tidyr::crossing(mass_mz, adduct)

    # left join the mass_adduct dataframe with the adduct_definition dataframe
    mass_mz_adduct_2 = left_join(mass_mz_adduct, adduct_definition, by = c("adduct" = "name"))
    
    # calculate the mz value using each row's mass and adduct definition
    mass_mz_adduct_2$mz_calculation = (mass_mz_adduct_2$mass * mass_mz_adduct_2$mass_multi) + mass_mz_adduct_2$mass_add

    # calculate the ppm error between the calculated mz and the provided mz
    mass_mz_adduct_2$ppm_error = abs(((mass_mz_adduct_2$mz_calculation - mass_mz_adduct_2$mz) / mass_mz_adduct_2$mz) * 1e6)

    # filter only the rows where the ppm error is less than the mass_accuracy (ppm, default is 10)
    mass_mz_adduct_3 = mass_mz_adduct_2[mass_mz_adduct_2$ppm_error <= mass_accuracy,]

    # return the mass_mz_adduct_3 dataframe
    return(mass_mz_adduct_3)
}