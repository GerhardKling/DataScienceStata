********************************************************************************
*Parameter stability
********************************************************************************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 7\"

use "US stocks.dta", clear

*Declare time series
tsset time

*Regression models
*General model: fix the sample
reg rm p_i u_ts u_rp u_i u_ip u_oil
predict r, res
gen sample = 1 if r!=.
estimates store A

*Check multicollinearity
*Critical value usually between 5 and 10
vif

*Try to test down
*We need to have the same number of observations
reg rm p_i u_rp u_i u_ip u_oil if sample == 1
estimates store B
lrtest A B

reg rm p_i u_rp u_ip u_oil if sample == 1
estimates store C
lrtest A C

reg rm u_rp u_ip u_oil if sample == 1
estimates store D
lrtest A D

reg rm u_ip u_oil if sample == 1
estimates store E
lrtest A E

*Compare models using information criteria
estimates table A B C D E, star b(%9.3f) stats(aic bic N)

********************************************************************************
*Explore parameter stability
********************************************************************************
*Rolling regressions

*How to get regression coefficients?
*NOTE: no need to keep sample restriction after establishing the best model
reg rm u_ip u_oil

*Get coefficient row vector
matrix b = get(_b)

*Focus on impact of oil price changes
matrix a = b[1,2]
 
*Convert into variable
svmat a, n(a)

*Remove all matrices
*Not really needed
matrix drop _all

*But careful with variables
drop a1

*Loop with overlapping windows 
gen oil = .

forvalues i=0/307 {
	qui: reg rm u_ip u_oil if time>=0+`i' & time<=30+`i'
	matrix b = get(_b)
	matrix a = b[1,2]
	svmat a, n(a)
	egen value = max(a1)
	drop a1
	replace oil = value if time == 15+`i'
	drop value
	}

*Plot coefficient over time
line oil time














