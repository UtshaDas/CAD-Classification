rm(list=ls())
library(e1071)

library(pROC)
training<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Boruta/CAD Dataset Train70p.csv")
testing<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Boruta/CAD Dataset Test30p.csv")


nb_default <- naiveBayes(as.factor(Cath)~., data=training,laplace = 5)
default_pred <- predict(nb_default, testing[,-14], type="class")

cm=table(default_pred, testing$Cath,dnn=c("Prediction","Actual"))

acc=((sum(diag(cm))/sum(cm)))
tp<-cm[2,2]
tn<-cm[1,1]
fn<-cm[1,2]
fp<-cm[2,1]

sen=tp/(tp+fn)
spe=tn/(tn+fp)
mcc=((tp*tn) - (fp*fn))/(sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn)))
f1=2*tp/((2*tp)+fp+fn)

roc_obj<-roc(testing[,14],as.numeric(default_pred))
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
