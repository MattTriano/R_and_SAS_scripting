setwd('C:/datasets')


library(ggplot2)
library(corrplot)
library(choroplethr)
library(choroplethrMaps)
library(help=datasets)

build_states_df <- function() {
  st      <- state.x77
  #abbs   <- sapply(state.abb, tolower)
  region  <- sapply(state.name, tolower)
  region  <- data.frame(region, stringsAsFactors=F)
  st.name <- data.frame(state.name, stringsAsFactors=F)
  st.abb  <- data.frame(state.abb, stringsAsFactors=F)
  df <- cbind(st.abb, st.name, region, st)
  return(df)
}

make_choropleth <- function(df, values, pleth_title, pleth_legend) {
  region   <- df$region
  value    <- values
  choro_df <- data.frame(region, value)
  st.pleth <- state_choropleth(choro_df, title=pleth_title, legend=pleth_legend, num_colors = 8)
  plot(st.pleth)
  return(st.pleth)
}

state_data_description <- function(col_name) {
  if (col_name == 'Population') {
    return('Estimated Population on July 1, 1975')
  } else if (col_name == 'Income') {
    return('Per Capita Income in 1974 (in 1974 Dollars)')
  } else if (col_name == 'Illiteracy') {
    return('Illiteracy Rate in 1970 (% of Population)')
  } else if (col_name == 'Life Exp') {
    return('Life Expectancy in 1969-71 (in years)')
  } else if (col_name == 'Murder') {
    return('Murder and Non-Negligent Manslaughter Rate per 100,000 Population in 1976')
  } else if (col_name == 'HS Grad') {
    return('High School Graduation Rate in 1970 (% of Population)')
  } else if (col_name == 'Frost') {
    return('Avg. Annual # of Days with Min. Temp. Below Freezing Between 1931 and 1960')
  } else if (col_name == 'Area') {
    return('Land Area (in square miles)')
  } else {
    return('Not a plottable column')
  }
}

choropleth_legend_lookup <- function(col_name) {
  if (col_name == 'Population') {
    return('Population (in thousands)')
  } else if (col_name == 'Income') {
    return('1974 Dollars')
  } else if (col_name == 'Illiteracy') {
    return('Illiterate % of Pop.')
  } else if (col_name == 'Life Exp') {
    return('Life Expectancy in Years')
  } else if (col_name == 'Murder') {
    return('Homicides per 100,000 Pop.')
  } else if (col_name == 'HS Grad') {
    return('High School Grad % of Pop.')
  } else if (col_name == 'Frost') {
    return('Avg. Annual # of Freezing Days')
  } else if (col_name == 'Area') {
    return('Land Area in Square Miles')
  } else {
    return('Not a plottable column')
  }
}

get_plottable_colnames <- function(df) {
  is_plottable <- sapply(df, is.numeric)
  df_colnames <- data.frame(colnames(df), stringsAsFactors=F)
  return(df_colnames[is_plottable,])
}

state_choropleth_maker <- function(df) {
  plottable_cols <- get_plottable_colnames(df)
  for (col_name in plottable_cols) {
    col_title  <- state_data_description(col_name)
    col_legend <- choropleth_legend_lookup(col_name)
    values     <- df[, col_name]
    make_choropleth(df, values, col_title, col_legend)
    invisible(readline(prompt="Press [enter] to display the next Choropleth Map"))
  }
}

get_top_5 <- function(df, col_name) {
  top5_df    <- df[order(df[,col_name], decreasing=T)[1:5],]
  col_data   <- data.frame(top5_df[,col_name])
  state_name <- top5_df$state.name
  return(cbind(col_data, state_name))
}

top5_barplotter <- function(df, col_name) {
  top5_df   <- get_top_5(df, col_name)
  print(top5_df)
  col_title <- paste0(state_data_description(col_name), ': Top 5 States')
  y_label   <- choropleth_legend_lookup(col_name)
  barplot(height=top5_df[,1], names.arg=top5_df[,2], ylim=c(0,upper_ylim(max(top5_df[,1]))),
          main=col_title, xlab='State', ylab=y_label)
}

state_top5_barplot_maker <- function(df) {
  plottable_cols <- get_plottable_colnames(df)
  for (col_name in plottable_cols) {
    top5_barplotter(df, col_name)
    invisible(readline(prompt="Press [enter] to display the next barplot"))
  }
}

state_top5_barplot_maker(df) 

upper_ylim <- function(x) {
  limit <- 10^ceiling(log10(x))
  increment <- 10^ceiling(log10(x)-1)
  while (limit > x) {
    limit <- limit - increment
  }
  return(limit + increment)
}

state_scatter_matrix <- function(df) {
  plottable <- get_plottable_colnames(df)
  plot(df[,plottable], main='Pairwise Scatterplot Matrix for the Built-In State Dataset')  
}

state_corrplot <- function(df, corr_type){
  plottable <- get_plottable_colnames(df)
  corr_data <- cor(df[,plottable])
  corrplot(corr_data, method=corr_type)
}
state_corrplot(df, 'ellipse')
state_corrplot(df, 'number')

final_proj <- function() {
  df <- build_states_df()
  #state_choropleth_maker(df)
  state_top5_barplot_maker(df) 
  #state_scatter_matrix(df)
  #state_corrplot(df, 'shade')
  #state_corrplot(df, 'ellipse')
  #state_corrplot(df, 'number')
}

state_top5_barplot_maker(df) 

state_top5_barplot_maker(df) 

top5_barplotter(df, 'Income')
state_choropleth_maker(df)
df <- build_states_df()
plotz <- get_plottable_colnames(df)


df
state_scatter_matrix(df)

df$'Income'
state_data_description('Income')
temp_pleth <- make_choropleth(df, df$Income, "Income", "the income")
plot(temp_pleth, main='Income for YOu!')
namz <- colnames(df)



