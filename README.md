# Metabolomics adduct mass (m/z) and monoisotopic mass calculator

`MetaboCoreUtilsAdduct` main functions:
- Calculate adduct m/z using monoisotopic mass and adduct type in a long or wide format.
- Calculate m/z to monoisotopic mass using m/z and adduct type.
- Calculate monoisotopic mass using chemical formula
- Calculate adduct chemical formula using adduct type and neutral chemical formula
- Infer adduct form  within the specified mass accuracy using monoisotopic mass and m/z

# Installation

The package can be installed with

```r
install.packages("devtools") #If you don't have "devtools" installed already
devtools::install_github("jamesjiadazhan/MetaboCoreUtilsAdduct") # Install the package from GitHub
```



## Currently supported adduct types:

### **Positive**
- #### Single charge (+1)
  - M+H-Hexose-H2O
  - M+H-CH2O2
  - M+H-CO2
  - M+H-2H2O
  - M+H-CH3OH
  - M+H-CO
  - M+H-H2O
  - M+H-NH3
  - M+H
  - 2M+H
  - 3M+H
  - M+Li
  - M+2Li-H
  - M+NH4
  - 2M+NH4
  - M+H+H2O
  - M+Na
  - 2M+Na
  - M+CH3OH+H
  - M+K
  - 2M+K
  - M+ACN+H
  - 2M+ACN+H
  - M+2Na-H
  - M+FA+H
  - M+IsoProp+H
  - M+ACN+Na
  - 2M+ACN+Na
  - M+2K-H
  - M+DMSO+H
  - M+2ACN+H
  - M+IsoProp+Na+H
- #### Double charge (+2)
  - M+2H    
  - M+H+NH4
  - M+H+Na
  - M+H+K
  - M+ACN+2H
  - M+2Na
  - M+2ACN+2H
  - M+3ACN+2H
- #### Triple charge (+3)
  - M+3H
  - M+2H+Na
  - M+H+2Na
  - M+3Na

### **Negative**
- #### Single charge (-1)
  - M-H-CH2O2
  - M-H-CO2
  - M-H-CH3OH
  - M-H-CO
  - M-H-H2O
  - M-H
  - 2M-H
  - 3M-H
  - M-H+H2O
  - M+Na-2H
  - M+Cl
  - M+K-2H
  - M+ACN-H
  - M+CHO2
  - 2M+CHO2
  - M+FA-H
  - 2M+FA-H
  - M+C2H3O2
  - 2M+C2H3O2
  - M+Hac-H
  - 2M+Hac-H
  - M-H+HCOONa
  - M+Br
  - M+TFA-H
- #### Double charge (-2)
  - M-2H
  - 2M-2H
- #### Triple charge (-3)
  - M-3H
  - 2M-3H

## Below are examples of the functions in the MetaboCoreUtilsAdduct package. Leucine and taurine are used in the examples
![image](https://github.com/jamesjiadazhan/MetaboCoreUtilsAdduct/assets/108076575/0cc99bee-8796-4361-8254-351648d2b72d)
![image](https://github.com/jamesjiadazhan/MetaboCoreUtilsAdduct/assets/108076575/8c15e33e-0bc3-41c0-94bc-8dd8bbf4d3a2)



### mass2mz_df(): this function calculates theoretical adduct m/z and return the result in the long format. 
- This means you have to provide pairs of mass and adduct at the same time. There is no combination calculation here. It works best for data frames

mass is the column name with all monoisotopic mass values.
Adduct is the column name with all adduct types

```r

r$> masses <- c(131.0946, 125.0147)
    adducts <- c("M+Na", "M+H")
    mass2mz_df(masses, adducts)
      mass adduct adduct_mass
1 131.0946   M+Na    154.0838
2 125.0147    M+H    126.0220

```

### mass2mz(): this function calculates theoretical adduct m/z and return the result in the wide format. 
- Thus, if each mass is provided, all theoretical adduct m/z for different adduct types will be produced. This means you can do combination calculations here. It works best for individual data.
```
r$> masses <- c(131.0946, 125.0147)
    adducts <- c("M+Na", "M+H", "M+2H", "M+H-H2O")
    mass2mz(x=masses, adduct=adducts, custom_adduct = NULL)
      mass     M+2H      M+H     M+Na  M+H-H2O
1 131.0946 66.55458 132.1019 154.0838 114.0913
2 125.0147 63.51463 126.0220 148.0039 108.0114
```

- Advanced: you can provide your own custom adduct in the following format and pass it to the custom_adduct parameter
```
r$> adduct_definition
             name mass_multi    mass_add formula_add formula_sub charge positive
1            M+3H  0.3333333    1.007276          H3          C0      3     TRUE
2         M+2H+Na  0.3333333    8.334591        H2Na          C0      3     TRUE
3         M+H+Na2  0.3333333   15.661905        HNa2          C0      3     TRUE
4           M+Na3  0.3333333   22.989220         Na3          C0      3     TRUE
5            M+2H  0.5000000    1.007276          H2          C0      2     TRUE
6         M+H+NH4  0.5000000    9.520553         NH5          C0      2     TRUE
7           M+H+K  0.5000000   19.985218          HK          C0      2     TRUE
8          M+H+Na  0.5000000   11.998248         HNa          C0      2     TRUE
9      M+C2H3N+2H  0.5000000   21.520551       C2H5N          C0      2     TRUE
10          M+2Na  0.5000000   22.989220         Na2          C0      2     TRUE
11    M+C4H6N2+2H  0.5000000   42.033826      C4H8N2          C0      2     TRUE
12    M+C6H9N3+2H  0.5000000   62.547101     C6H11N3          C0      2     TRUE
13            M+H  1.0000000    1.007276           H          C0      1     TRUE
```


### mz2mass(): this function calculates monoisotopic mass using m/z and adduct type
```
r$> mz <- c(132.1019, 126.0220)
    adducts <- c("M+H")
    mz2mass(mz, adducts)
          M+H
[1,] 131.0946
[2,] 125.0147
```

### calculateMass(): this function calculates monoisotopic mass using chemical formula
```
r$> formula_exp = c("C6H13NO2", "C2H7NO3S")
    calculateMass(formula_exp)
C6H13NO2 C2H7NO3S 
131.0946 125.0147 
```

### formula2mz(): this function calcualtes m/z using chemical formula and adduct type
```
r$> formula_exp = c("C6H13NO2", "C2H7NO3S")
    adducts <- c("M+H")
    formula2mz(formula_exp, adducts)
             mass      M+H
C6H13NO2 131.0946 132.1019
C2H7NO3S 125.0147 126.0219
```

### adductFormula(): this function gets the adduct chemical formula for a given adduct type and neutral chemical formula. This may help distinguish those neutral monoisotopic masses from those "adduct monoisotopic mass" (M+ vs. M+H)
```
r$> formula_exp = c("C6H13NO2", "C2H7NO3S")
    adducts <- c("M+H")
    adductFormula(formula_exp, adducts)
         1            
C6H13NO2 "[C6H14NO2]+"
C2H7NO3S "[C2H8NO3S]+"
```

### adductForm: determine the adduct forms given the provided monoisotopic masses and m/z. This is useful because some algorithms or papers have metabolite outputs with just m/z but it is time-consuming to map out their adduct forms manually.
```
r$> tail(metabolite_data_kegg)
# A tibble: 6 × 7
  Metabolite    Monoisotopic_mass    mz  time HMDBID      KEGGID Name                                          
  <chr>                     <dbl> <dbl> <dbl> <chr>       <chr>  <chr>                                         
1 metoprolol                 267.  268.  6.25 HMDB0001932 C07202 Metoprolol                                    
2 metronidazole              171.  172.  2.71 HMDB0015052 C07203 Metronidazole                                 
3 quinine                    324.  325.  6.44 HMDB0014611 C06526 Quinine; (-)-Quinine                          
4 warfarin                   308.  309.  1.82 HMDB0001935 C01541 Warfarin                                      
5 C34:1 DAG*                 595.  618.  1.69 HMDB0007102 C13861 1-Hexadecanoyl-2-(9Z-octadecenoyl)-sn-glycerol
6 C34:1 DAG                  595.  613.  1.69 HMDB0007102 C13861 1-Hexadecanoyl-2-(9Z-octadecenoyl)-sn-glycerol


# apply the adductForm function to the metabolite data with kegg information
metabolite_data_kegg_adduct = adductForm(metabolite_data_kegg$Monoisotopic_mass, metabolite_data_kegg$mz, ion_mode="positive", mass_accuracy=10)

# inner join metabolite_data_kegg and metabolite_data_kegg_adduct using `Monoisotopic Mass` == mass and `precursor_mz_query_spectrum` == mz
metabolite_data_kegg_2 = inner_join(metabolite_data_kegg, metabolite_data_kegg_adduct, by = c("Monoisotopic_mass" = "mass", "mz" = "mz"), relationship = "many-to-many")

r$> tail(metabolite_data_kegg_2)
# A tibble: 6 × 16
  Metabolite    Monoisotopic_mass    mz  time HMDBID      KEGGID Name                                           adduct mass_multi mass_add formula_add formula_sub charge positive mz_calculation ppm_error
  <chr>                     <dbl> <dbl> <dbl> <chr>       <chr>  <chr>                                          <chr>       <dbl>    <dbl> <chr>       <chr>        <dbl> <lgl>             <dbl>     <dbl>
1 metoprolol                 267.  268.  6.25 HMDB0001932 C07202 Metoprolol                                     M+H             1     1.01 H           C0               1 TRUE               268.      2.52
2 metronidazole              171.  172.  2.71 HMDB0015052 C07203 Metronidazole                                  M+H             1     1.01 H           C0               1 TRUE               172.      1.02
3 quinine                    324.  325.  6.44 HMDB0014611 C06526 Quinine; (-)-Quinine                           M+H             1     1.01 H           C0               1 TRUE               325.      2.08
4 warfarin                   308.  309.  1.82 HMDB0001935 C01541 Warfarin                                       M+H             1     1.01 H           C0               1 TRUE               309.      2.83
5 C34:1 DAG*                 595.  618.  1.69 HMDB0007102 C13861 1-Hexadecanoyl-2-(9Z-octadecenoyl)-sn-glycerol M+Na            1    23.0  Na          C0               1 TRUE               618.      2.40
6 C34:1 DAG                  595.  613.  1.69 HMDB0007102 C13861 1-Hexadecanoyl-2-(9Z-octadecenoyl)-sn-glycerol M+NH4           1    18.0  NH4         C0               1 TRUE               613.      2.01


```
References:
- https://fiehnlab.ucdavis.edu/staff/kind/metabolomics/ms-adduct-calculator/
- https://github.com/rformassspectrometry/MetaboCoreUtils
