library(mRMRe)
file_n<-paste0("F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv")
df <- read.csv(file_n, header = TRUE)
for (i in 1:67){
  df[[i]] <- as.numeric(df[[i]])
}
f_data <- mRMR.data(data = data.frame(df))
results <- mRMR.classic("mRMRe.Filter", data = f_data, target_indices = 67,
                        feature_count = 21)
print(solutions(results))

print(results@scores)