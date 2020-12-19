args = c(rep(0,3))
args [1] = "data_train.txt"
args [2] = "data_test.txt"
args [3] = "0.0005"

library(MASS)
library(klaR)
library (mda)

options(stringsAsFactors = FALSE)

niv <- as.numeric (args[3])

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


#Perform main computations - train model (find features and apply lda to the selected feature set)
data [,1] <- factor (data [,1])
colnames (data) <- paste ("X_", colnames (data), sep="")
colnames (data) [1] = "class"
gw_obj <- greedy.wilks(class ~ ., data=data, niveau = niv)
tree.model <- do.call(lda, list(formula = formula(gw_obj),data = data))

#Apply classifier to the test set
colnames (testset) <- paste ("X_", colnames (testset), sep="")
prediction <- predict(tree.model, testset,type="class")
pr_res =  data.frame (prediction[1], check.names = FALSE)
rownames (pr_res) <- rownames (testset)
cat ("Sample\t", file="swLDA_prediction_test.txt",append=FALSE)
write.table(pr_res[1],"swLDA_prediction_test.txt", row.names=TRUE,col.names=TRUE,append=TRUE, quote=TRUE,sep="\t")


tab0=data.frame (tree.model[3], check.names = FALSE)
colnames (tab0) <- substring (colnames (tab0), 9)
colnames (tab0)<-  paste ("Mean.", colnames (tab0), sep="")
cat ("Class\t",file="swLDA_Features_means.txt",append=FALSE)
write.table(tab0,file="swLDA_Features_means.txt", row.names=TRUE,col.names=TRUE,sep="\t",append=TRUE)

#write.table(tree.model[1],"swLDA_result2.txt", row.names=TRUE,col.names=TRUE,sep="\t")
#write.table(tree.model[2],"swLDA_result3.txt", row.names=TRUE,col.names=TRUE,sep="\t")

tab=data.frame (tree.model[4], check.names = FALSE)
rownames (tab) <- substring (rownames (tab), 3)
cat ("Feature\t",file="swLDA_Features_coeffs.txt",append=FALSE)
write.table(tab,file="swLDA_Features_coeffs.txt", row.names=TRUE,col.names=TRUE,sep="\t",quote=TRUE)


#draw a plot
pdf ("swLDA_plot.pdf")
plot(tree.model, dimen=3)
temp <- dev.off ()

#prepare and output some statistics based on the traib set 
trainpred <- predict (tree.model, data [,-1])
conf_matr <- confusion (trainpred$class, data [, 1])

err_r <- attr (conf_matr, "error")
acc = 1.0 - err_r
cat ("Overall accuracy for the training set: ", file="swLDA_predict_stat.txt", append=FALSE)
cat (acc, file="swLDA_predict_stat.txt", append=TRUE)
cat ("\n\n\n\n", file="swLDA_predict_stat.txt", append=TRUE)

cat ("Confusion matrix:\n\n", file="swLDA_predict_stat.txt", append=TRUE)
capture.output (conf_matr, file = "swLDA_predict_stat.txt", append = TRUE)
cat ("\n", file="swLDA_predict_stat.txt", append=TRUE)

result = cbind(data[1],trainpred[1])
rownames (result) <- rownames (data)
colnames(result)[1]="TrueClass"
colnames(result)[2]="PredictedClass"
cat ("Sample\t", file="swLDA_prediction_train.txt",append=FALSE)
write.table (result,file="swLDA_prediction_train.txt", row.names=TRUE,col.names=TRUE,append=TRUE, quote=TRUE, sep="\t")

