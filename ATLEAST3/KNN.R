rm(list=ls())
library(caret)
library(pROC)
training<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/ATLEAST3/CAD Dataset Train70p.csv")
testing<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/ATLEAST3/CAD Dataset Test30p.csv")
training$Cath<-as.factor(training$Cath)
testing$Cath<-as.factor(testing$Cath)
knnFit <- train(Cath ~ ., data = training, method = "knn",
                trControl = trainControl(method = "repeatedcv",
                                         repeats = 5))


print(knnFit)

predicted=predict(knnFit,newdata=testing[-20])

cm=table(predicted,testing[,20],dnn=c("Prediction","Actual"))
acc=((sum(diag(cm))/sum(cm)))
tp<-cm[2,2]
tn<-cm[1,1]
fn<-cm[1,2]
fp<-cm[2,1]

sen=tp/(tp+fn)
spe=tn/(tn+fp)
mcc=((tp*tn) - (fp*fn))/(sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn)))
f1=2*tp/((2*tp)+fp+fn)

roc_obj<-roc(testing[,20],as.numeric(predicted))
rocauc<-auc(roc_obj)

print('Accuracy')
print(acc)
print('sensitivity')
print(sen)
print('Specificity')
print(spe)
print('MCC')
print(mcc)
print('F1')
print(f1)
print('AUC')
print(rocauc)

