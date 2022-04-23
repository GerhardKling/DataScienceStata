********************************************************************************
*Mergers in the US
********************************************************************************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 6\" 

use "US_mergers.dta", clear


********************************************************************************
*Trends in M&A
********************************************************************************
*Table of M&A cases per year
tabstat merger, by(y) s(sum)

*No observations
drop if y==1979 | y==2004

*To plot figure, use collapse command
*Need to perserve data as data in memory is changed - different from DataFrames in Python
preserve

collapse (sum) merger, by(y) 
line merger y, xtitle("Year") ytitle("M&As")

restore


********************************************************************************
*Merger wave
********************************************************************************
sort y
by y: egen m_a = sum(merger)

*Sort by year and month
sort y m


********************************************************************************
*Predicting M&A
********************************************************************************
rename l_cap_1 log_cap
label var log_cap "Log market cap"

rename book_to_market_1 mb
label var mb "Market-to-book"

qui:{
	*Firm level factors
	logit merger log_cap
	estimates store A
	logit merger log_cap mb
	estimates store B
	predict prob_firm, pr

	*Dynamics
	logit merger log_cap mb m_a
	estimates store C
	predict prob_wave, pr
	}

estimates table A B C, star b(%9.3f) stats(aic bic)

*Plot predicted probability
preserve

collapse (mean) prob_firm prob_wave, by(y) 

twoway (line prob_firm y) ///
(line prob_wave y), xtitle("Year") ytitle("M&A probability")

restore
