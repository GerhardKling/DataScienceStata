********************************************************************************
*L3: Regression analysis
********************************************************************************

cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 3"

*Import data from csv file
insheet using "Repossession.csv", clear

*Use wildcard to drop unwanted columns
drop v*

*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Data exploration
*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Line chart
twoway (line repossession year, yaxis(1)) (line gdp_pc year, yaxis(2) color(red)), ///
title("Repossessions and GDP p.c.") legend(label(1 "Repossession") ///
label(2 "GDP per capita")) ///
xlabel(1987(3)2020) note("Source: World Bank, UK government report") 


*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Growth rates
*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Declare time dimension
tsset year

*Derive growth rates
gen rep_g = d.repossession/l.repossession
label var rep_g "Annual growth in repossessions"

gen gdp_g = d.gdp_pc/l.gdp_pc
label var gdp_g "Annual GDP p.c. growth"


*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Scatter plot
*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*COVID outlier
scatter rep_g gdp_g
scatter rep_g gdp_g if year!=2020


*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Correlation
*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
corr rep_g gdp_g


*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
*Regression
*========================================>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<=====
reg rep_g gdp_g

*Recession dummy
gen recession = (gdp_g < 0)

*COVID
gen COVID = (year == 2020)

*Adding dummy
reg rep_g gdp_g recession
reg rep_g gdp_g COVID

*Fitted values
predict fit

*Show fitted value
twoway (scatter rep_g gdp_g) (line fit gdp_g if year != 2020)














