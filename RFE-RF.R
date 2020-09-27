rm(list=ls())
data<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")

library(caret)


# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="LOOCV")
# run the RFE algorithm
system.time(results <- rfe(data[,1:66], as.factor(data[,67]),sizes =c(1:21), rfeControl=control))
# summarize the results
print(results)
# list the chosen features
rfeRanked = predictors(results)
# plot the results

write.csv(results[["variables"]],"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset RFE-RF Results Ranks.csv")

plot(results, type=c("g", "o"))