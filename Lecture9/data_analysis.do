*==============================================================================*
*UK House Prices
*==============================================================================*

clear all
set more off

* Set your working directory
cd "C:\Users\Yunikarn LTD\Documents\Aberdeen\TEACHING\AI Lectures\UK house prices"

*------------------------------------------------------------
* 1. Import and prepare real house prices
*------------------------------------------------------------
import delimited "real_house_prices.csv", clear varnames(1) case(preserve)

* Convert DD/MM/YYYY string to quarterly date
gen quarter = qofd(daily(trim(Date), "DMY"))
format quarter %tq

drop if missing(quarter)
keep quarter Prices

* Check that each quarter appears only once
isid quarter

tempfile houseprices
save `houseprices'

*------------------------------------------------------------
* 2. Import and prepare interest rates
*------------------------------------------------------------
import delimited "rates.csv", clear varnames(1) case(preserve)

gen quarter = qofd(daily(trim(Date), "DMY"))
format quarter %tq

drop if missing(quarter)
keep quarter Rate

isid quarter

*------------------------------------------------------------
* 3. Merge by quarter and remove missing observations
*------------------------------------------------------------
merge 1:1 quarter using `houseprices', keep(match) nogen

drop if missing(Prices, Rate)

* Declare quarterly time series
sort quarter
tsset quarter

*------------------------------------------------------------
* 4. Plot both series using separate y-axes
*------------------------------------------------------------
twoway ///
    (line Prices quarter, yaxis(1) lcolor(navy)) ///
    (line Rate quarter, yaxis(2) lcolor(maroon)), ///
    title("Real house prices and interest rates") ///
    xtitle("Quarter") ///
    ytitle("Real house prices", axis(1)) ///
    ytitle("Interest rate (%)", axis(2)) ///
    ylabel(, axis(1)) ///
    ylabel(, axis(2)) ///
    legend(order(1 "Real house prices" 2 "Interest rate")) ///
    graphregion(color(white))


*------------------------------------------------------------
* 5. Descriptive analysis
*------------------------------------------------------------
* Quarterly real house price growth: 100 × ln(Prices_t / Prices_t-1)
gen log_Prices = ln(Prices) if Prices > 0
gen Growth = 100 * D.log_Prices
label variable Growth "Quarterly real house price growth (%)"

* Descriptive statistics for price levels and interest rates
tabstat Growth Rate, statistics(mean median sd n) columns(statistics)

* Build a matrix for Excel export
matrix descriptive = J(2, 4, .)
matrix rownames descriptive = Growth Rate
matrix colnames descriptive = Mean Median SD N

local row = 1
foreach var in Growth Rate {
    quietly summarize `var', detail
    matrix descriptive[`row', 1] = r(mean)
    matrix descriptive[`row', 2] = r(p50)
    matrix descriptive[`row', 3] = r(sd)
    matrix descriptive[`row', 4] = r(N)
    local row = `row' + 1
}

* Export to Excel in the working directory
putexcel set "Descriptive_statistics.xlsx", replace
putexcel A1 = matrix(descriptive), names
putexcel B2:D3, nformat("0.000")
putexcel E2:E3, nformat("0")
putexcel A1:E1, bold	
	
*------------------------------------------------------------
* 6. ARIMA models
*------------------------------------------------------------	
* Autocorrelation function (ACF)
ac Growth, lags(20) ///
    title("ACF of house price growth") ///
    name(acf_growth, replace)

* Partial autocorrelation function (PACF)
pac Growth, lags(20) ///
    title("PACF of house price growth") ///
    name(pacf_growth, replace)

* Display side by side
graph combine acf_growth pacf_growth, cols(2)

/*
ACF significant up to lag 4 then drops.
PACF oscillates with some significant lags up to 14.
MA(4) might be a good sarting point
*/

* Estimate MA(4) for quarterly growth
arima Growth, arima(0,0,4)
estimates store MA4

* Inspect residual autocorrelation
predict double resid_ma4 if e(sample), residuals
ac resid_ma4, lags(20)

* Portmanteau test: H0 is no autocorrelation through lag 12
wntestq resid_ma4, lags(12)

/*
Null hypothesis rejected not all dynamics covered.
Add AR components.
*/

* Fit candidate models
quietly arima Growth, arima(1,0,4)
estimates store ARMA14

quietly arima Growth, arima(1,0,1)
estimates store ARMA11

quietly arima Growth, arima(2,0,1)
estimates store ARMA21

quietly arima Growth, arima(2,0,2)
estimates store ARMA22

* Compare with the previously stored MA(4)
estimates stats MA4 ARMA14 ARMA11 ARMA21 ARMA22

/*
ARMA14 shows low AIC and BIC
Check residuals
*/

estimates restore ARMA14

predict double resid_arma14 if e(sample), residuals

ac resid_arma14, lags(20) name(ac_resid, replace)
pac resid_arma14, lags(20) name(pac_resid, replace)
graph combine ac_resid pac_resid, cols(2)

wntestq resid_arma14, lags(12)

/*
Remaining correlation at short lags suggests additional AR or MA dynamics.
Peaks at lags 4, 8, and 12 suggest quarterly seasonality.
Persistent, slowly declining correlation warrants checking stationarity or structural breaks.
*/

*------------------------------------------------------------
* 7. Seasonal adjustment
*------------------------------------------------------------	
* Identify quarter of the year: 1, 2, 3, or 4
gen byte season = quarter(dofq(quarter))

* Estimate fixed quarterly seasonal effects
regress Growth i.season

* Joint test for seasonality
testparm i.season

* Remove seasonal effects and preserve the original mean
quietly summarize Growth if e(sample), meanonly
scalar growth_mean = r(mean)

* Calculate residuals and seasonally adjusted growth
capture drop growth_resid Growth_SA
predict double growth_resid if e(sample), residuals

gen double Growth_SA = growth_resid + scalar(growth_mean)
label variable Growth_SA "Seasonally adjusted quarterly growth"

* Compare original and adjusted growth
twoway ///
    (line Growth quarter, lcolor(gs10)) ///
    (line Growth_SA quarter, lcolor(navy)), ///
    legend(order(1 "Original growth" 2 "Seasonally adjusted growth")) ///
    xtitle("Quarter") ytitle("Log growth (%)") ///
    title("Real house price growth")

* Re-examine serial correlation
ac Growth_SA, lags(20) name(ac_sa, replace)
pac Growth_SA, lags(20) name(pac_sa, replace)
graph combine ac_sa pac_sa, cols(2)


