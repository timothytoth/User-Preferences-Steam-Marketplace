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

reg postive_ratings average_playtime price has_achievements lower_bound 

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound genreslbl // i want to try and see all genres listed in this regression giving values 0-10 for top highest rated pvaulues for the regressional analysis

 

corr positive_ratings genresmassivelymultiplayer genresadventure genresfreetoplay genressimulation genresearlyaccess genresrpg genresaction genresstrategy genrescasual genresindie genresrpg

// make a new variable 

label define genreslbl 0 "massivelymultiplayer" 1 "adventure" 2 "freetoplay" 3 "simulation" 4 "earlyaccess" 5 "rpg" 6 /// 
"action" 7 "strategy" 8 "casual" 9 "indie" 10 "rpg"
label values genres genreslbl 

reg positive_ratings average_playtime negative_ratings price has_achievements lower_bound genresearlyaccess genresfreetoplay i.num_platforms

reg lnpr average_playtime negative_ratings price has_achievements lower_bound genresearlyaccess genresfreetoplay i.num_platforms

vif












