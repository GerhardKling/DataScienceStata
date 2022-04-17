***********************************
*Predicting default risk
***********************************
use "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 6\Default_risk_data.dta", clear
tsset code year

*****************
*Data management*
*****************
label var date "date of gazette announcement"

***************
*New variables*
***************
gen EBIT=rev-cogs-sga
label var EBIT "earnings before interest and taxes"
gen cover=EBIT/rD
label var cover "interest coverage defined as EBIT/interest expense"
gen leverage=(lt+st)/e
label var leverage "financial leverage defined as short and long-term debt over equity"
gen wc=ca-cl
label var wc "net working capital"

*Definition of variables
*Define cost-income ratios k
gen k=(cogs+sga)/rev
label var k "cost-income ratio"
*Define capital turnover T
gen T=rev/ta
label var T "capital turnover"
*Define invested capital IC
gen IC=fa+wc
label var IC "invested capital defined as fixed assets plus net working capital"
*Define growth g
gen g_rep=ln(rev)-ln(l.rev)
label var g_rep "reported growth"
*Organic growth
gen rev_org=rev if acq==.
replace rev_org=rev-acq*l.T if acq!=.
label var rev_org "oragnic turnover"
gen g=ln(rev_org)-ln(l.rev_org)
label var g "organic growth"

***********************
*Definition of default*
***********************
*Definition of default
*COMMENT: might need to be refined!
gen default=1 if status>2 & status!=11 & year==event_time
*Disolved cases are not clear
*If equity is negative then default
replace default=1 if default==. & status==11 & year==event_time & e<=0
replace default=0 if default==.

****************
*Altman Z-score*
****************
*Traditional definition for private companies
gen z=0.012*(ca-cl)/ta+0.014*re/ta+0.033*EBIT/ta+0.006*e/ta+0.999*rev/ta
gen safe=1 if z>2.9
replace safe=0 if safe==.
gen grey=1 if z>1.23 & z<=2.9
replace grey=0 if grey==.
gen distress=1 if z<=1.23
replace distress=0 if distress==.
label var z "original Alman's z-score"

*Adjusted Altman Z-score based on MDA
*Define components Tj
gen F1=(ca-cl)/ta
gen F2=e/ta
gen F3=EBIT/ta
gen F4=re/ta
gen F5=rev/ta

*Firm size
gen size=ln(ta)

*****************************************************
*MODELS
*****************************************************
*Standard logit (old command)
logit default F1 F2 F3 F4 F5

*New command with odds ratios
logistic default F1 F2 F3 F4 F5

*Odds ratio with firm size
logistic default F1 F2 F3 F4 F5 size

*Predicted probabilities
logit default F1 F2 F3 F4 F5 size
predict prob, pr

*Scatter plot
scatter pr size

*Postestimation
estat class, cutoff(0.025)
lsens

