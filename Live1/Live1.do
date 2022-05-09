**************************============================**************
*ANALYSIS
**************************============================**************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Live 1\" 
use Macrodata.dta, clear

***************************
*Explorative data analysis*
***************************
*Labels
label var g "GDP growth (annual %)"
label var INF "Inflation, consumer prices (annual %)"
label var R "Lending interest rate (%)"
label var E "Official exchange rate (LCU per US$, period average)"
label var M "Broad money growth (annual %)"

*Check labels
des

*Panel data structure
tsset code year

*Descriptive statistics
tabstat g INF R E M, stats(N mean sd p25 median p75) c(s) format(%9.2f)

*Correlation matrix
corr g INF R E M

*Explore distributions
sum g, detail

sum INF, detail
kdensity INF

*Transformation used in Gillman et al. 2004
gen log_INF = ln(1 + INF)
kdensity log_INF

*Scatter plot and outliers
scatter g INF if INF<30

scatter g log_INF

***************************
*Regression*
***************************
*Base model
reg g log_INF
estimates store A

*With controls
reg g log_INF R E M
estimates store B

*Fixed-effects model: see Matyas and Sevestre (1996)
xtreg g log_INF R E M, fe
estimates store C
predict fit

estimates table A B C, star stats(r2_a aic bic N) b(%9.3f)

***************************
*Non-linear effects*
***************************
*Powers of fitted values
forvalues i=2/4 {
	gen fit_`i' = fit^`i'
	}

xtreg g log_INF R E M fit_2, fe

*Try higher orders
xtreg g log_INF R E M fit_2 fit_3, fe
test fit_2 fit_3


