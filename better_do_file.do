clear all
set more off 
cd "C:\Users\Tim\OneDrive\Desktop\main_eco_400"
use better_attempt, clear

 reg positive_ratings negative_ratings price i.num_platforms has_achievements genresmassivelymultiplayer genresadventure genresfreetoplay genressimulation genresearlyaccess genresrpg genresindie genrescasual genresstrategy genresaction

reg positive_ratings negative_ratings price i.num_platforms has_achievements categoriessteamtradingcards categoriescoop categoriessingleplayer categoriessteamleaderboards categoriesstats categoriesmultiplayer categoriesfullcontrollersupport categoriessteamachievements categoriessteamcloud categoriesonlinemultiplayer

reg positive_ratings negative_ratings  price i.num_platforms has_achievements lower_bound

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms 

//creating interactive term

gen lnpr = ln(positive_ratings)

gen lnrating = ln(rating)

reg lnpr average_playtime negative_ratings price has_achievements lower_bound i.num_platforms

corr rating average_playtime negative_ratings price has_achievements lower_bound 

corr rating average_playtime  price has_achievements lower_bound 

reg positive_ratings average_playtime price has_achievements lower_bound 

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound genreslbl // i want to try and see all genres listed in this regression giving values 0-10 for top highest rated pvaulues for the regressional analysis

 

corr positive_ratings genresmassivelymultiplayer genresadventure genresfreetoplay genressimulation genresearlyaccess genresrpg genresaction genresstrategy genrescasual genresindie genresrpg


reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms 
reg lnpr average_playtime negative_ratings price has_achievements lower_bound  i.num_platforms

vif



eststo clear
quietly eststo summstats: estpost summarize positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms
esttab using sumstats.rtf, cell("mean sd min max") mtitle("Summary Statistics")


eststo: quietly wls positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms, wvar(length) type(abse) noconst

eststo: reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound i.num_platforms 


rvpplot price, yline(0)


estat imtest, white

eststo: reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms, vce(robust)


/// WLS assuming heteroskaedastcitiy comes from
reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms 

predict fit

predict se, residuals

gen abse = abs(se)

regress abse fit

predict fit2

generate weight = (1/fit2)^2

estasto: reg positive_ratings average_playtime negative_ratings price has_achievements i.num_platforms [aweight = weight]

esttab using results01.rtf, replace title ("Effect of price on positive_ratings")




