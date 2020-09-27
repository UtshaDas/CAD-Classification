library(GA)
library(caret)
trainData <- read.csv('F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv')
trainData$Cath<-as.numeric(trainData$Cath)

sa_ctrl <- safsControl(functions = caretSA,
                       method = "repeatedcv",
                       repeats = 3,
                       improve = 15) # n iterations without improvement before a reset

# Genetic Algorithm feature selection
set.seed(100)
sa_obj <- safs(x=trainData[,1:66], 
               y=trainData[, 67],
               safsControl = sa_ctrl)

print(sa_obj)
print(sa_obj$optVariables)
