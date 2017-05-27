setwd('C:/datasets')
library(gmodels)

baylor_data <- read.fwf('baylor-religion-survey-data-2007.txt', widths=c(10,124,1,1,181,1,41,1,19,1), header=F,
                        col.names = c('id','trash1','bible_interp', 'god_belief', 'trash2', 'daterace', 'trash3',
                                      'gender','trash4','income'))

bib_interp_names <- c('Literal',
                      'Perfect but needs interpretation',
                      'Contains human error',
                      'Ancient book of legends',
                      'I Can\'t Interpret')

income_ranges <- c('$10,000 or less',
                   '$10,001 to $20,000',
                   '$20,001 to $35,000',
                   '$35,001 to $50,000',
                   '$50,001 to $100,000',
                   '$100,001 to $150,000',
                   '$150,001 or more')

god_belief_labels <- c('No Doubt God Exists',
                       'Some Doubt',
                       'I Sometimes Believe',
                       'Higher Power/Cosmic Force',
                       'Agnostic',
                       'Atheist',
                       'No Opinion')


# This produces the plow of Bible Interpretation split by Gender
counts_bib_int_gend <- table(baylor_data$gender, baylor_data$bible_interp)
barplot(counts_bib_int_gend, names.arg=bib_interp_names, main='Bible Interpretation by Gender', xlab = 'Bible Interpretation',
        col=c('darkblue','red'), legend = c('Male','Female'), beside=T)
chisq.test(counts_bib_int_gend)
CrossTable(counts_bib_int_gend)
axis(1, labels=names(baylor_data$bible_interp))

# This produces the plot of God Belief with respect to Income tranches
counts_belief_income <- table(baylor_data$god_belief, baylor_data$income)
barplot(counts_belief_income, names.arg=income_ranges, main='God Belief by Income', xlab = 'Income',
        col=heat.colors(7), legend = god_belief_labels, beside=T)
chisq.test(counts_belief_income)
CrossTable(counts_belief_income)

# This produces the plot of openness to heterogeneous racial dating with respect to belief in God.
counts_racedate_belief <- table(baylor_data$daterace, baylor_data$god_belief)
barplot(counts_racedate_belief, names.arg=god_belief_labels, main='Heterogeneous Racial Dating by God-Belief', xlab = 'God-Belied',
        col=heat.colors(2), legend = c('Open to Heterogeneous Racial Dating', 'Not Open to Heterogeneous Racial Dating'), beside=T)
chisq.test(counts_racedate_belief)
CrossTable(counts_racedate_belief)

