args = c(rep(0,3))
args[1] = "data_train.txt"
args[2] = "data_test.txt"
args[3] = 100 #number_of_tree

library(randomForest)
options(stringsAsFactors = FALSE)
numtrees <- as.numeric(args[3])

#Prepare training table - autodetect rows/colums, etc.
data <- read.table(textConnection(gsub(",", "\t", readLines(args[1]))), header=FALSE, stringsAsFactors=FALSE)
if ((data [1,1] == "class") | (data [1,1] == "Class") | (data[1,1] == "CLASS")) {
    data [1,1] = "class"

    clen = length (data [-1,1])
    clen_u = length (unique (data [-1,1]))

    rlen = length (t(data [1,-1]))
    rlen_u = length (unique (t(data [1,-1])))

    if ((clen_u == clen) & (rlen_u == rlen)) {
        cat ("Error: number of classes equals number of samples\n")
        q ()
    }
    if ((clen_u < clen) & (rlen_u < rlen)) {
        cat ("Error: features with the same name present\n")
        q ()
    }
    if ((clen_u < clen) & (rlen_u == rlen)) {
        do_transpose = FALSE
        if ((data [1,2] == "id") | (data [1,2] == "Id") | (data [1,2] == "ID")) {
            data [1,2] = "Id"
            id_n = 2
        } else {
            id_n = -1
        }
    } else { # Here ((clen_u == clen) & (rlen_u < rlen))
        do_transpose = TRUE
        if ((data [2,1] == "id") | (data [2,1] == "Id") | (data [2,1] == "ID")) {
            data [2,1] = "Id"
            id_n = 2
        } else {
            id_n = -1
        }
    }
} else if ((data [1,2] == "class") | (data [1,2] == "Class") | (data[1,2] == "CLASS")) {
    do_transpose = FALSE
    data [1,2] = "class"
    if ((data [1,1] == "id") | (data [1,1] == "Id") | (data [1,1] == "ID")) {
        data [1,1] = "Id"
        id_n = 1
    } else {
        cat ("Error: Invalid header row\n")
        q ()
    }
} else if ((data [2,1] == "class") | (data [2,1] == "Class") | (data[2,1] == "CLASS")) {
    do_transpose = TRUE
    data [2,1] = "class"
    if ((data [1,1] == "id") | (data [1,1] == "Id") | (data [1,1] == "ID")) {
        data [1,1] = "Id"
        id_n = 1
    } else {
        cat ("Error: Invalid header row\n")
        q ()
    }
} else {
    cat ("Invalid format of training table\n")
    q ()
}

if (do_transpose == TRUE) {
    data = data.frame (t (data))
}
cnam <- t(data) [,1]
data <- data [-1,]
colnames (data) <- cnam

if (id_n > 0) {
    rnam <- data [,id_n]
    data <- data [,-id_n]
    rownames (data) <- rnam
} else {
    rnam <- c(1:(dim(data)[1]))
    rownames (data) <- rnam
}

data [,1]<- as.factor (data[,1])
len= dim (data)[2]
for (j in (2:len)){
   data [,j]<- as.numeric (data[,j])
}

#Prepare testing dataset - transpose if required, etc.
testset <- read.table(textConnection(gsub(",", "\t", readLines(args[2]))), header=FALSE, stringsAsFactors=FALSE)
if (do_transpose == TRUE) {
    testset = data.frame (t (testset))
}
cnam <- t(testset) [,1]
testset <- testset [-1,]
colnames (testset) <- cnam

c1=cnam [1]
if ((c1 == "id") | (c1 == "Id") | (c1 == "ID"))  {
    colnames(testset) [1] <- "Id"
    rnam <- testset [,1]
    testset <- testset [,-1]
    rownames (testset) <- rnam
} else {
    rnam <- c(1:(dim(testset)[1]))
    rownames (testset) <- rnam
}

len= dim (testset)[2]
for (j in (1:len)){
   testset [,j]<- as.numeric (testset[,j])
}


#Perform main computations - train classifiers
data [,1] <- factor (data [,1])
colnames (data) <- paste ("X_", colnames (data), sep="")
colnames (data) [1] = "class"
cat ("\t", file="RandomForest_ConfusionMatrix.txt")
rforest <- randomForest(class ~ ., data=data,  ntree=numtrees, importance=TRUE)

#Output some statistics
write.table(rforest$confusion, "RandomForest_ConfusionMatrix.txt", row.names=TRUE,col.names=TRUE, sep="\t", quote=TRUE, append=TRUE)

cat ("Feature\t", file="RandomForest_FeatureImportance.txt")
imp <- importance (rforest)
rownames (imp) <- substring (rownames (imp), 3)
write.table (imp[,c("MeanDecreaseAccuracy","MeanDecreaseGini")], "RandomForest_FeatureImportance.txt", col.names=TRUE, sep="\t", quote=TRUE, append=TRUE)

#Draw plots
pdf ("RandomForestPlots.pdf")
plot (rforest, main="Random forest plot")

rf_copy <- rforest
rownames (rf_copy$importance) <- substring (rownames (rf_copy$importance), 3)
varImpPlot (rf_copy, main="Random forest feature importance plot")
tmp <- dev.off ()

#Apply classifier to the test set
colnames (testset) <- paste ("X_", colnames (testset), sep="")
prediction <- predict(rforest, testset, type="response")
prediction = data.frame (prediction, check.names = FALSE)
rownames (prediction) <- rownames (testset)
cat ("Sample\tPredictedClass\n", file="RandomForest_ResForTestSet.txt")
write.table(prediction,"RandomForest_ResForTestSet.txt", row.names=TRUE,col.names=FALSE, sep="\t", quote=TRUE, append=TRUE)

