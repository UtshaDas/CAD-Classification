library(relaimpo)
trainData <- read.csv('F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv')
trainData$Cath<-as.numeric(trainData$Cath)
# Build linear regression model
model_formula = Cath ~ .
lmMod <- lm(model_formula, data=trainData)

# calculate relative importance
relImportance <- calc.relimp(lmMod, type = "lmg", rela = F)  

# Sort
cat('Relative Importances: \n')
sort(round(relImportance$lmg, 3), decreasing=TRUE)