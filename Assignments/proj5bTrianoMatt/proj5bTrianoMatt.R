# Matt Triano's Assignment 5b
setwd('C:/datasets/states-files')

state_data_reader <- function(state_num) {
  filename <- paste0('state', state_num, '.txt')
  print(filename)
  state_name <- read.table(filename, nrows=1, sep=',', quote=NULL)
  city_data <- read.table(filename, skip=1, sep=',', col.names=c('rank','city_name','population','extra'),
                          fill=T, quote="", colClasses=c('character','character','integer','integer'))
  
  # This is the hack I made to deal with that nasty extra comma you put in the 
  # population value for Overland Park, KS (state16, city#2)
  if (!all(is.na(city_data$extra))) {
    x <- which(!is.na(city_data$extra))
    extra <- formatC(city_data$extra[x],width=3,flag=0)
    corrected_population <- as.integer(paste0(toString(city_data$population[x]),extra))
    city_data$population[x] <- corrected_population
  }
  city_data <- subset(city_data, select=-extra)
  return(list(state_name, city_data)) 
}

all_states_data_loader <- function() {
  states_data <- list()
  for(i in 1:50) {
    states_data[[i]] <- state_data_reader(i)
    print(states_data[[i]])
  }
  return(states_data)
}

state_data <- all_states_data_loader()
warnings()
