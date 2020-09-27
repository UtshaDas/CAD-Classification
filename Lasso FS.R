library(glmnet)
trainData <- read.csv('F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Train70p.csv')

x <- as.matrix(trainData[,-67]) # all X vars
y <- as.double(as.matrix(ifelse(trainData[, 67]==0, 0, 1))) # Only Class

# Fit the LASSO model (Lasso: Alpha = 1)
set.seed(100)
cv.lasso <- cv.glmnet(x, y, family='binomial', alpha=1, parallel=TRUE, standardize=TRUE, type.measure='auc')

# Results
plot(cv.lasso)
# plot(cv.lasso$glmnet.fit, xvar="lambda", label=TRUE)
cat('Min Lambda: ', cv.lasso$lambda.min, '\n 1Sd Lambda: ', cv.lasso$lambda.1se)

df_coef <- round(as.matrix(coef(cv.lasso, s=cv.lasso$lambda.min)), 2)

# See all contributing variables
df_coef[df_coef[, 1] != 0, ]

write.csv(df_coef,"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Lass-FS Results.csv")
write.csv(df_coef[df_coef[, 1] != 0, ],"F:/Thesis/DataMing+MachieLeaning/CAD/CAD Dataset Lass-FS_Selected Results.csv")
