library(mRMRe)
library(Biocomb)
file_n<-paste0("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")
data <- read.csv(file_n, header = TRUE)

# class label must be factor
data[,67]<-as.factor(data$Cath)
disc<-"equal interval width"
#minimal description length (MDL), equal frequency and equal interval width
attrs.nominal=numeric()
out=select.inf.chi2(data,disc.method=disc,attrs.nominal=attrs.nominal)
write.csv(out,"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Chi Square Results Ranks.csv")
