****************************************************************************************************
*CFA ANALYSIS **************************************************************************************
****************************************************************************************************
*Change directory
cd "C:\Users\User\Documents\Gerhard\Aberdeen HOME\Yunikarn\Youtube\Projects\Data Science using Stata\Data\Lecture 8\"
use "Financial_inclusion.dta", clear

*Measurement model for ease
sem (EASE -> s_location s_min_c s_min_s s_min_c_m s_min_s_m s_docs_s s_docs_c s_location_l s_min_cl s_min_mo s_day_cl s_day_mo) ///
, method(ml) latent(EASE) standardized
estat gof, stats(all)
estat mindices

*Improving the model by adding covariances
sem (EASE -> s_location s_min_c s_min_s s_min_c_m s_min_s_m s_docs_s s_docs_c s_location_l s_min_cl s_min_mo s_day_cl s_day_mo) ///
, method(ml) latent(EASE) standardized cov(e.s_docs_s*e.s_docs_c) cov(e.s_min_c_m*e.s_min_cl)
estat gof, stats(all)
estat mindices





