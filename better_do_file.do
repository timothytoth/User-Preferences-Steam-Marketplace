clear all
set more off 
cd "C:\Users\Tim\OneDrive\Desktop\main_eco_400"
use better_attempt, clear


/// EDA on Steam Games kaggle dataset 27075 rows and 18 columns uncleaned 
 reg positive_ratings negative_ratings price i.num_platforms has_achievements genresmassivelymultiplayer genresadventure genresfreetoplay genressimulation genresearlyaccess genresrpg genresindie genrescasual genresstrategy genresaction

reg positive_ratings negative_ratings price i.num_platforms has_achievements categoriessteamtradingcards categoriescoop categoriessingleplayer categoriessteamleaderboards categoriesstats categoriesmultiplayer categoriesfullcontrollersupport categoriessteamachievements categoriessteamcloud categoriesonlinemultiplayer

reg positive_ratings negative_ratings  price i.num_platforms has_achievements lower_bound

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms 

//creating interactive term

//gen lnpr = ln(positive_ratings)

//gen lnrating = ln(rating)

reg lnpr average_playtime negative_ratings price has_achievements lower_bound i.num_platforms

corr rating average_playtime negative_ratings price has_achievements lower_bound 

corr rating average_playtime  price has_achievements lower_bound 

reg positive_ratings average_playtime price has_achievements lower_bound 

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound  // i want to try and see all genres listed in this regression giving values 0-10 for top highest rated pvaulues for the regressional analysis

 

corr positive_ratings genresmassivelymultiplayer genresadventure genresfreetoplay genressimulation genresearlyaccess genresrpg genresaction genresstrategy genrescasual genresindie genresrpg


reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms 
reg lnpr average_playtime negative_ratings price has_achievements lower_bound  i.num_platforms

vif


//fix; completed

eststo clear
quietly eststo summstats: estpost summarize positive_ratings average_playtime negative_ratings price has_achievements lower_bound 
esttab using sumstats.rtf, cell("mean sd min max") mtitle("Summary Statistics")


eststo: quietly wls0 positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms, wvar(length) type(abse) noconst

eststo: reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms 


rvpplot price, yline(0)


estat imtest, white

eststo: reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms, vce(robust)


/// WLS assuming heteroskaedastcitiy comes from
reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms [aweight=weight]

predict fit

predict se, residuals

gen abse = abs(se)

regress abse fit

predict fit2

generate weight = (1/fit2)^2

ereg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms [aweight = weight]

esttab using results01.rtf, replace title ("Effect on positive_ratings")


 reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms, vce(robust)


hettest

ssc install estout

eststo clear
quietly eststo summstats: estpost summarize positive_ratings average_playtime negative_ratings price has_achievements lower_bound num_platforms  genresfreetoplay genresearlyaccess 
esttab using sumstats.rtf, cell("mean sd min max") mtitle("Table 1: Summary Statistics Table")


corr positive_ratings achievements average_playtime negative_ratings price 
reg positive_ratings achievements average_playtime negative_ratings price i.num_platforms 

reg lnpr achievements average_playtime negative_ratings price i.num_platforms 


eststo clear
/*3 OLS regressions*/ 
eststo: quietly reg positive_ratings achievements
eststo: quietly reg positive_ratings achievements, vce(cluster negative_ratings)
eststo: quietly reg positive_ratings achievements average_playtime negative_ratings price i.num_platforms 
/*1 wls regression*/
eststo: quietly wls0 positive_ratings achievements average_playtime negative_ratings price num_platforms, wvar(achievements) type(abse) noconst 

esttab using results_cs.rtf, replace n se r2 ar2 star(* 0.10 ** 0.05 *** 0.01) ///
mlabel("OLS" "OLS w/ RSE" "OLS" "WLS")
