library(GA)
library(caret)
trainData <- read.csv('F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv')
trainData$Cath<-as.numeric(trainData$Cath)
ga_ctrl <- gafsControl(functions = caretGA,  # another option is `rfGA`.
                       method = "cv",
                       repeats = 3)

# Genetic Algorithm feature selection
set.seed(100)
ga_obj <- gafs(x=trainData[, 1:66], 
               y=trainData[, 67], 
               iters = 150,   # normally much higher (100+)
               gafsControl = ga_ctrl)

print(ga_obj)
print(ga_obj$optVariables)