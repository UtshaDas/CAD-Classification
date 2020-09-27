rm(list=ls())
library(Boruta)
library(caret)
file_n<-paste0("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")
dataset <- read.csv(file_n, header = TRUE)

dataset[,67]<-as.factor(dataset$Cath)
set.seed(100)
rrfMod <- train(Cath ~ ., data=dataset, method="RRF")
#ada, AdaBag, AdaBoost.M1, adaboost, bagEarth, bagEarthGCV, bagFDA, bagFDAGCV, bartMachine, blasso, BstLm, bstSm, C5.0, C5.0Cost, C5.0Rules, C5.0Tree, cforest, chaid, ctree, ctree2, cubist, deepboost, earth, enet, evtree, extraTrees, fda, gamboost, gbm_h2o, gbm, gcvEarth, glmnet_h2o, glmnet, glmStepAIC, J48, JRip, lars, lars2, lasso, LMT, LogitBoost, M5, M5Rules, msaenet, nodeHarvest, OneR, ordinalNet, ORFlog, ORFpls, ORFridge, ORFsvm, pam, parRF, PART, penalized, PenalizedLDA, qrf, ranger, Rborist, relaxo, rf, rFerns, rfRules, rotationForest, rotationForestCp, rpart, rpart1SE, rpart2, rpartCost, rpartScore, rqlasso, rqnc, RRF, RRFglobal, sdwd, smda, sparseLDA, spikeslab, wsrf, xgbLinear, xgbTree
rrfImp <- varImp(rrfMod, scale=F)

print(rrfImp)
write.csv(rrfImp[["importance"]],"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset RRF-FS Results.csv")

plot(rrfImp, top = 21, main='Variable Importance')