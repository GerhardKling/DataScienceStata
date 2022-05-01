********************************************************************************
*Model specification
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
