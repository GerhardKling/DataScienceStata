*Exploration

cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Videos\Data Science using Stata\Data\Lecture 2\"

*Open data
use "Living costs and food survey.dta", clear

*Rename
lookfor size
rename A049 size

rename EqIncOp income

*Change order of variables
order size income

*Descriptive statistics
sum income size

sum income, detail

*Distribution
histogram income

kdensity income, normal

*Groups / types
rename A047 older

*Generate dummy variable
gen d_older = 1 if older >= 1
replace d_older = 0 if d_older == .

label var d_older "Dummy that takes value 1 if at least 1 person in HH is 70+"

*Compare income across groups
*Box-plot
graph box income, by(d_older)

*Winsorization
egen p5 = pctile(income), p(5)
egen p95 = pctile(income), p(95)


gen w_income = income if income > p5 & income < p95
replace w_income = p5 if income <= p5
replace w_income = p95 if income >= p95

*Twoway charts
twoway (kdensity income) (kdensity w_income)
twoway (histogram income) (histogram w_income)

*Transformations
gen ln_income = ln(income)

kdensity ln_income, normal

*Tables
tabstat income size, s(N mean sd)

estpost tabstat income size, s(N mean sd) columns(statistics)

esttab . using "my_table.rtf", cells("count mean(fmt(%9.2f)) sd(fmt(%9.2f))") ///
noobs title(Summary statistics) compress replace nogap
