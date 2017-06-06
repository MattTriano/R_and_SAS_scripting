

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

st      <- state.x77

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