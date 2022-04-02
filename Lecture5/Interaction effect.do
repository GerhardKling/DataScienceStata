********************************************************************************
*Interaction terms
********************************************************************************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 5"

use "UK_PANEL.dta", clear

*Firm size
gen size = ln(ta)

********************************************************************************
*Defining interaction terms
********************************************************************************
*Established companies
gen old = incorporation <= 1990

*Interaction term
gen oldXsize = old*size

*Shift in constant term
*What happens with fixed effects?
reg ROA old size r_d_ta WC_ta cover leverage

*Shift in constant term and slope coefficient
reg ROA old size oldXsize r_d_ta WC_ta cover leverage

*Joint hypothesis test
test old oldXsize




