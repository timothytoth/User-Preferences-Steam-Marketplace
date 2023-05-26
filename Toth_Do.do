clear all
set more off 
cd "C:\Users\Tim\OneDrive\Desktop\main_eco_400"
use better_attempt, clear

reg positive_ratings has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess

reg positive_ratings has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess

predict fit

predict se, residuals 

gen abse = abs(se)

regress abse fit

predict fit2

generate weight = [1/fit2]^2

reg positive_ratings has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess [aweight=weight]

reg lnpr has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess

scatter positive_ratings price 

scatter positive_ratings num_platforms

scatter positive_ratings has_achievements

scatter positive_ratings average_playtime

histogram positive_ratings

eststo clear

quietly eststo sumstats: estpost summarize positive_ratings has_achievements rating average_playtime price num_platforms genresfreetoplay genresearlyaccess
esttab using sumstats.rtf, cell("mean sd min max") mtitle("Table 1: Summary Statistics")


eststo clear

eststo: quietly reg positive_ratings has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess

eststo: quietly reg positive_ratings has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess [aweight=weight]

eststo: quietly reg lnpr has_achievements rating average_playtime price i.num_platforms genresfreetoplay genresearlyaccess 

esttab using my_results.rtf, replace n se r2 ar2 star(* 0.10 ** 0.05 *** 0.01)
mlabel("OLS" "WLS" "Log")



eststo clear
quietly eststo summstats: estpost summarize positive_ratings average_playtime negative_ratings price has_achievements lower_bound num_platforms  genresfreetoplay genresearlyaccess 
esttab using sumstats.rtf, cell("mean sd min max") mtitle("Table 1: Summary Statistics Table")


eststo clear
/*3 OLS regressions*/ 
eststo: quietly reg positive_ratings achievements
eststo: quietly reg positive_ratings achievements, vce(cluster negative_ratings)
eststo: quietly reg positive_ratings achievements average_playtime negative_ratings price i.num_platforms 
/*1 wls regression*/
eststo: quietly wls0 positive_ratings achievements average_playtime negative_ratings price num_platforms, wvar(achievements) type(abse) noconst 

esttab using results_cs.rtf, replace n se r2 ar2 star(* 0.10 ** 0.05 *** 0.01) ///
mlabel("OLS" "OLS w/ RSE" "OLS" "WLS")
