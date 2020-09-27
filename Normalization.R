rm(list=ls())
library(data.table)
#library(mltools)
data<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset_After_One_hot_encode_Organized.csv")

for (i in 1:21){
  minimum=min(data[,i])
  maximum=max(data[,i])
  for(j in 1:303){
    x=data[j,i]
    data[j,i]=(x-minimum)/(maximum-minimum)
  }
}

write.csv(data,"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset_After_One_hot_encode_Organized_Normalized.csv")
