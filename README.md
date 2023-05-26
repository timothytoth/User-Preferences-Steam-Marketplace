# _Exploring the Causal Relationship between Game Features and Positive User Feedback in the Steam Marketplace_
# Introduction
I embarked on a project that delves into the factors influencing positive ratings for video games within the Steam marketplace. As tech companies began their exploration of the video game industry, focusing on in-game economies and consumer behavior, I recognized an ideal opportunity to merge my passion for gaming with my expertise in data analysis.

Given the scarcity of publicly available resources, I strategically selected the Steam marketplace as my target for investigation. Being an avid video game enthusiast, I thoroughly enjoy immersing myself in various gaming experiences and engaging with friends- our primary criteria for evaluation revolve around two key aspects: the cumulative positive ratings garnered by the game and the visual depictions presented through images, which provide a glimpse into the game's aesthetic and overall user experience. Thus, it seemed only natural to undertake a study that sheds light on the determinants of positive ratings within this vibrant ecosystem.

# About the Data 
* One dataset: steam.csv was downloaded from kaggle
steam.csv has 27,076 Rows and 18 features. Which were relating to a video games individualistic game features and user playtime.

# What are video game features and why use them?
All video games in the steam marketplace are given game features to describe the overall game. Such as price, average playtime, devolopers, categories, total achievements, platforms its available on, release date, genres  

# Objective 
In this project, I want to specifically explore if the preseance of achievements affects the predicted value of positive ratings for a video game within the steam marketplace. Furthermore I will be putting to the test, if the presence of early access release games and free to play have a postive or negative effect as well. I want to explore the consumer behavor and preferences in the video game industry. To accomplish this, I will be running a weighted least squares regression

# Why use a weighted least squares regression?
The weighted least squares regression was used in order to analyze the factors influencing positive ratings for video games on the Steam Marketplace. The weighted least squares regression was chosen as a method to account for heteroscedasticity in the data, which means that the variability of the errors may not be constant across the range of predictor variables.

Heteroscedasticity can lead to biased and inefficient estimates in ordinary least squares (OLS) regression. By using a weighted least squares regression, the author was able to give more weight to observations with lower variability and less weight to observations with higher variability, thus addressing the issue of heteroscedasticity and improving the accuracy of the regression results.

# Seeing what genres is most positively rated within the consumers giving that video game above 90% rating
![Screenshot 2023-04-25 172937](https://github.com/timothytoth/steam_goated_dataset/assets/120987606/da5bee67-200f-4608-a6f2-81c737f13557)



