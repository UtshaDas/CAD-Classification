library(randomForest)
library(pROC)
trainDF<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Common4/CAD Dataset Train70p.csv")
testDF<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Common4/CAD Dataset Test30p.csv")

trainDF$Cath<-as.factor(trainDF$Cath)
testDF$Cath<-as.factor(testDF$Cath)

bestmtry<-tuneRF(trainDF,as.factor(trainDF$Cath),ntreeTry = 50,stepFactor =1.2,
                 improve = 0.01,trace = TRUE,plot = TRUE, doBest=TRUE)

modelRandom<-randomForest(Cath~.,data = trainDF,mtry=bestmtry$mtry,ntree=bestmtry$ntree) 
#print(importance(modelRandom))
#varImpPlot(modelRandom)
PredictionsWithClass<- predict(modelRandom, testDF[,1:13], type = 'class')
cm<-table(predictions=PredictionsWithClass, actual=testDF$Cath)

acc=((sum(diag(cm))/sum(cm)))
tp<-cm[2,2]
tn<-cm[1,1]
fn<-cm[1,2]
fp<-cm[2,1]

sen=tp/(tp+fn)
spe=tn/(tn+fp)
mcc=((tp*tn) - (fp*fn))/(sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn)))
f1=2*tp/((2*tp)+fp+fn)

roc_obj<-roc(testDF$Cath,as.numeric(PredictionsWithClass))
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