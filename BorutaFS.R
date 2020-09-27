library(Boruta)

file_n<-paste0("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")
data <- read.csv(file_n, header = TRUE)

set.seed(111)
FS <- Boruta(as.factor(data$Cath)~.,
                            data = data,
                            pValue = 0.01,
                            mcAdj = TRUE,
                            maxRuns = 1000,
                            doTrace = 3,
                            holdHistory = TRUE,
                            getImp = getImpRfZ,)

FS<-TentativeRoughFix(FS)
getSelectedAttributes(FS, withTentative = F)
print(FS)
FS_df <- attStats(FS)
print(FS_df)
write.csv(FS_df,"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Boruta Results.csv")

plot(FS, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(FS$ImpHistory),function(i)
  FS$ImpHistory[is.finite(FS$ImpHistory[,i]),i])
names(lz) <- colnames(FS$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(FS$ImpHistory), cex.axis = 0.7)
