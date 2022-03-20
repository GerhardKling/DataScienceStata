********************************************************************************
*Fixed or random effects
********************************************************************************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 5"

use "UK_PANEL.dta", clear

*Firm size
gen size = ln(ta)

*Tell Stata that we work with panel data
tsset code year

*Panel regressions
qui: {
	reg ROA size r_d_ta WC_ta cover leverage
	estimates store A

	xtreg ROA size r_d_ta WC_ta cover leverage, fe
	estimates store B

	xtreg ROA size r_d_ta WC_ta cover leverage, re
	estimates store C
	}

estimates table A B C, star b(%9.3f) stats(N)



********************************************************************************
*Hausman test
********************************************************************************
*Step 1: Run fixed-effects model & store results
xtreg ROA size r_d_ta WC_ta cover leverage, fe
estimates store FE

*Step 2: Run random-effects model
xtreg ROA size r_d_ta WC_ta cover leverage, re

*Step 3: Hausman test
hausman FE ., sigmamore





