setwd('C:/datasets')

# load_plotly <- function() {
#   If (!require(plotly)) {
#     response <- readline("The plotly package is required to generate the maps (choropleth plots,\n
#                        and it is not installed on your machine.  Enter 'y' if you want to install \n
#                        the plotly package: ")
#     if (tolower(response) == 'y') {
#       install.packages('plotly')
#       return(T)
#     }
#   } else {
#     library(plotly)
#   }
# }
library(plotly)
library(ggplot2)
library(choroplethr)
library(choroplethrMaps)
library(help=datasets)

st      <- state.x77


abbs <- sapply(state.abb, tolower)
region  <- sapply(state.name, tolower)
region  <- data.frame(region, stringsAsFactors=F)
st.name <- data.frame(state.name, stringsAsFactors=F)
st.abb  <- data.frame(state.abb, stringsAsFactors=F)

df <- cbind(st.abb, region, st)
df

summary(df)

make_choropleth <- function(df, values) {
  region   <- df$region
  value    <- values
  choro_df <- data.frame(region, value)
  st.pleth <- state_choropleth(choro_df)
  return(st.pleth)
}
df$'Income'
temp_pleth <- make_choropleth(df, df$Income)
plot(temp_pleth)

st$state.name[1]
df$hover <- with(df, paste(df$state.name, '<br>', 'Population', df$Population,'Income', df$Income,
                           '<br>', 'Illiteracy', df$Illiteracy, 'HS Grad Rate', df$`HS Grad`,
                           '<br>', 'Life Expectancy', df$`Life Exp`, 'Murder', df$Murder,
                           '<br>', 'Area', df$Area, 'Frost', df$f))
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)


p <- plot_geo(df, locationmode = 'USA-states') %>%
  add_trace(
    z = ~Population, text = ~hover, locations = ~state.abb,
    color = ~Population, colors = 'Purples'
  ) %>%
  colorbar(title = "Millions USD") %>%
  layout(
    title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)',
    geo = g
  )

chart_link = plotly_POST(p, filename="choropleth/ag")








?plotly
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

