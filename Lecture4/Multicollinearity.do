********************************************************************************
*4a Multicollinearity
********************************************************************************
*Adjust for your path
cd "C:\"

use "Commodity_prices.dta", clear

*Regressions with two explanatory variables
reg price_s production_s production_g

*Correlation
corr production_g production_s

*Variance inflation factors
vif

*Regressions eliminating one of the two explanatory variables
reg price_s production_s
reg price_s production_g
