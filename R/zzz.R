.onLoad <- function(libname, pkgname) {
    txts <- dir(system.file("substitutions", package = "MetaboCoreUtilsAdduct"),
                full.names = TRUE, pattern = "txt$")
    for (txt in txts) {
        substs <- utils::read.table(txt, sep = "\t", header = TRUE)
        assign(paste0(".", toupper(sub(".txt", "", basename(txt)))),
               substs, envir = asNamespace(pkgname))
    }

    # get mono isotopes for exact mass calculation
    assign(".ISOTOPES", .load_isotopes(), envir = asNamespace(pkgname))
}


.load_isotopes <- function() {
    iso <- utils::read.table(
        system.file(
            "isotopes", "isotope_definition.txt", package = "MetaboCoreUtilsAdduct"
        ),
        sep = "\t", header = TRUE
    )
    ## sort by rel_abundance
    iso <- iso[order(iso$element, -iso$rel_abundance),]
    ## swap numbers and elements names
    iso$isotope <- gsub("([A-z]+)([0-9]*)", "\\2\\1", iso$isotope)
    ## drop isotope number from most common isotope
    is_most_common <- !duplicated(iso$element)
    iso$isotope[is_most_common] <-
        gsub("^[0-9]+", "", iso$isotope[is_most_common])
    ## sort according to Hill notation
    org <- c("C", "H", "N", "O", "S", "P")
    iso$rank <- match(iso$element, org, nomatch = length(org) + 1L)
    ## reorder according to Hill notation and non-common isotopes first
    iso <- iso[order(iso$rank, iso$element, iso$isotope),]
    setNames(iso$exact_mass, iso$isotope)
}
