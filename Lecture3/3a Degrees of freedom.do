********************************************************************************
*Illustration of degrees of freedom and adjusted R-squared
********************************************************************************

*Generate artificial data
clear
set obs 2

gen y = 1 in 1
replace y = 3 in 2

gen x = 2 in 1
replace x = 5 in 2

*Regression
reg y x
predict fit

*Plotting
twoway (scatter y x) (line fit x)
drop fit

*No degrees of freedom - two points in R^2 determie straight line uniquely


*==========>>>>>>>>>> Adding an observation <<<<<<<<<<<<<<<<====================
*Adding a third point
set obs 3
replace y = 2 in 3
replace x = 3 in 3

*Regression
reg y x
predict fit

*Plotting
twoway (scatter y x) (line fit x)
drop fit

*==========>>>>>>>>>> Adding a variable <<<<<<<<<<<<<<<<========================
*Add variable
gen z = 1 in 1
replace z = 3 in 2
replace z = 4 in 3

*Regression
reg y x z
predict fit


