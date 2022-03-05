********************************************************************************
*Endogeneity
********************************************************************************

cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 4"


use "Farm_yields.dta", clear

*=======================>>>>>>>>>>>>> Time dimension <<<<<<<<<<=================
tsset year

*Go into first differences
twoway (line d.oilseed year) (line d.barley year, color(red)) ///
(line d.wheat year, color(blue)) (line d.milk year, color(green)) 



*=======================>>>>>>>>>>>>> Regressions <<<<<<<<<<====================
qui: {
	*Equation (1)
	reg d.oilseed d.barley
	estimates store A

	reg d.oilseed d.barley d.wheat
	estimates store B

	reg d.oilseed d.barley d.wheat d.milk
	estimates store C
	}
	
estimates table A B C, star b(%9.3f) stats(N r2_a)


*=======================>>>>>>>>>>>>> Post estimation analysis <<<<<<<<<<=======
*Estimate auxiliary regression (2)
reg d.barley d.wheat d.milk
predict res, res

*Use residual in equation (1). Note that the residual of equation 2 is the unexplained component 
reg d.oilseed d.barley res
