library(neuralnet)
library(pROC)
trainDF<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Lasso/CAD Dataset Train70p.csv")
testDF<-read.csv("F:/Thesis/DataMing+MachieLeaning/CAD/Lasso/CAD Dataset Test30p.csv")

#trainDF$Cath<-as.factor(trainDF$Cath)
#testDF$Cath<-as.factor(testDF$Cath)


allVars<-colnames(trainDF) 
predictorVars<-allVars[!allVars%in%"Cath"]
predictorVars<-paste(predictorVars,collapse = "+")
form=as.formula(paste("Cath~",predictorVars,collapse = "+")) 


#neuralModel<-neuralnet(formula =form,hidden = c(16,8,2),linear.output = T,data =trainDF)
neuralModel<-neuralnet(formula=form, data=trainDF, hidden = c(12,6,3), threshold = 0.001,
                       stepmax = 1e+05, rep = 1, startweights = NULL,
                       learningrate.limit = NULL, learningrate.factor = list(minus = 0.5,plus = 1.2),
                       learningrate = NULL, lifesign = "none",
                       lifesign.step = 1000, algorithm = "rprop+", err.fct = "sse",
                       act.fct = "logistic", linear.output = TRUE, exclude = NULL,
                       constant.weights = NULL, likelihood = FALSE)

PredictionsWithClass <- compute(neuralModel,testDF[,1:27]) 
PredictionsWithClass<-round(PredictionsWithClass$net.result*(max(testDF$Cath)-min(testDF$Cath))+
  min(testDF$Cath))

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

