********************************************************************************************************************************************************
*Solution WORKSHOP 1
********************************************************************************************************************************************************
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Workshop 1"

use "Living costs and food survey.dta", clear

/*
Locate the variable B228 (contribution to private pension)
Rename the variable B228 into ‘pension’ (use the Stata help function to find command)
*/

*Pensions
rename B228 pension

/*
Locate the variable EqIncOp (income)
Generate the variable income, which is equal to EqIncOp
*/

*Income
rename EqIncOp income

/*
Use the ‘tabstat’ command to display mean, median and standard deviation in columns for the variables income and pension
*/

tabstat pension income, s(mean median sd) columns(statistics)



/*
Define a dummy variable (labelled ‘working_age’) for households with all members below the age of 60 
(HINT: you need to use if commands and combine several conditions using logic (&))
*/

*Households - all members below 65
gen working_age=1 if A045==0 & A046==0 & A047==0
replace working_age=0 if working_age==.

/*
How many households in ‘working_age’ do not save for pension?
Can you confirm that more than 80% of households in ‘working_age’  do not contribute to a pension?
*/


*How many households in ‘working_age’ do not save for pension?
sum pension if working_age==1
sum pension if working_age==1 & pension==0

*Alternative way
count if working_age==1
count if working_age==1 & pension==0

*Or using egen command
egen count_all=count(pension) if working_age==1
egen count_no_pension=count(pension) if working_age==1 & pension==0
gen no_savers=count_no_pension/count_all
sum no_savers

/*
Use box-plots to compare the contribution to pension of households in ‘working_age’ with more than 3 children (age 5-18) and less then 3 children (age 5-18) 
HINT: create a dummy variable for more than 3 children (age 5-18) (value 1) and less then 3 children (age 5-18) (value 0)
HINT: restrict the dummy variable to households in ‘working_age’ using if commands
*/

*Use box-plots to compare the contribution to pension of households in ‘working_age’
*with more than 3 children and less then 3 children
gen more_child=1 if A042>3 & working_age==1
replace more_child=0 if more_child==.

graph box pension, by(more_child)














