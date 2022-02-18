********************************************************************************
*Heteroskedasticity
********************************************************************************

cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 4"


use "Farm_yields.dta", clear

*=======================>>>>>>>>>>>>> Time dimension <<<<<<<<<<=================
tsset year

*Go into first differences
twoway (line d.oilseed year) (line d.barley year, color(red))


*=======================>>>>>>>>>>>>> Regressions <<<<<<<<<<====================
qui: {
	reg d.oilseed l.d.barley
	estimates store A

	reg d.oilseed l.d.barley l.d.wheat
	estimates store B

	reg d.oilseed l.d.barley l.d.wheat l.d.milk
	estimates store C
	}
	
estimates table A B C, star b(%9.3f) stats(N r2_a)


*=======================>>>>>>>>>>>>> Post estimation analysis <<<<<<<<<<=======
reg d.oilseed l.d.barley l.d.wheat
predict r, res
line r year

gen r2 = r^2
line r2 year

*Formal test
hettest

*Robust estimation
reg d.oilseed l.d.barley l.d.wheat, robust
