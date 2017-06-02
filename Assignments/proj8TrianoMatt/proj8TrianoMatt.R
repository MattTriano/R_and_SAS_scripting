setwd('C:/datasets')
library(help=datasets)
internet <- WWWusage
internet
plot(internet)

fr <- freeny
plot(fr[1])
plot(fr[,3])
ts(fr)

morl <- morley
morley
co2 <- co2
plot(co2)
st <- state.x77
st.name <- state.name
st.name

df <- cbind(c(st.name, st[,1], st[,2], st[,3], st[,4], st[,5]))
df
CO2 <- CO2
CO2
plot(CO2)
us <- USArrests
summary(us)
us
library(GISTools)
?GISTools
library(maptools)
library(USAboundaries)
??maptools
class(states)
sids <- readShapePoly(system.file("shapes/sids.shp", package="maptools")[1],
                      proj4string=CRS("+proj=longlat +ellps=clrk66"))
sids
states <- us_states(resolution='low')
states
plot(states)
states[1,1]

