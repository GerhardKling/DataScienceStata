********************************************************************************
*Omitted variable bias
********************************************************************************
*Open data
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 4"

*Subsample of UK living costs and food survey
use "Single_person_HH.dta", clear

*Transformation - see video
gen ln_income = ln(income)

*Regression model
reg ln_income age

*Ramsey RESET test
ovtest
ovtest, rhs

*Add higher powers of age
forvalues i = 2/3 {
	gen age_`i' = age^`i'
	}
	
reg ln_income age age_2
ovtest
predict fit2

reg ln_income age age_2 age_3
ovtest
predict fit3

*Plot outcome
collapse (mean) ln_income fit2 fit3, by(age) 

twoway (line ln_income age, lp(dash)) (line fit3 age) (line fit2 age, color(red))
