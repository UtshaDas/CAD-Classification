library(randomForest)
library(DALEX)

# Load data
inputData <- read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")

# Train random forest model
rf_mod <- randomForest(factor(Cath) ~ ., data=inputData, ntree=14)
print(rf_mod)

# Variable importance with DALEX
explained_rf <- explain(rf_mod, data=inputData, y=inputData$Cath)

# Get the variable importances
varimps = variable_importance(explained_rf, type='raw')

print(varimps)
plot(varimps)
