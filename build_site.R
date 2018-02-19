#Set our working directory. 
#This helps avoid confusion if our working directory is 
#not our site because of other projects we were 
#working on at the time. 
setwd("/home/dj-ubuntu/Documents/Webpage/personal_webpage")

#render your sweet site. 
rmarkdown::render_site()

#cerulean - blue, cosmo - black, flatly - dark gray, journal - white, readable - white with blue menu text, spacelab - grey banner, united - red
# yet - nice black, sandstone - also nice, simplex - nice white, lumen - greyish