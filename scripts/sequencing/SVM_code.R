args = c(rep(0,5))
args [1] = "data_train.txt"
args [2] = "data_test.txt"
args [3] = "linear"
args [4] = 1
args [5] = "YES"

options(stringsAsFactors = FALSE)

library("e1071")
library("mda")

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

#assign class weights
classes <- unique (data[,1])
num_classes <- length (classes)
weights <- vector ()
for (i in 1:num_classes) {
    if (args[5] == "YES") {
        weights [i] <- 1.0 / length (which (data[,1] == classes [i]))
    } else {
        weights [i] <- 1.0
    }
} 
weights <- weights / mean (weights)
names (weights) <- classes

#Train SVM model
data [,1] <- factor (data [,1])
svm_model <- svm(class ~ ., data=data, type="C-classification", kernel=args[3], cost=as.numeric(args[4]), class.weights=weights)

#Get some statistic for the train set
pred_train <- predict(svm_model, data [,-1])
conf_matr <- confusion (pred_train, data [, 1])
err_r <- attr (conf_matr, "error")
acc = 1.0 - err_r
cat ("Overall accuracy for the training set: ", file="SVM_predict_stat.txt", append=FALSE)
cat (acc, file="SVM_predict_stat.txt", append=TRUE)
cat ("\n\n\n\n", file="SVM_predict_stat.txt", append=TRUE)
cat ("Confusion matrix:\n\n", file="SVM_predict_stat.txt", append=TRUE)
capture.output (conf_matr, file = "SVM_predict_stat.txt", append = TRUE)
cat ("\n", file="SVM_predict_stat.txt", append=TRUE)

#Apply SVM model to the test set
pred_test <- predict(svm_model, testset)
pred_test = data.frame (pred_test, check.names = FALSE)
rownames (pred_test) <- rownames (testset)
cat ("Sample\tPredictedClass\n", file="SVM_ResForTestSet.txt")
write.table(pred_test,"SVM_ResForTestSet.txt", row.names=TRUE,col.names=FALSE, sep="\t", quote=TRUE, append=TRUE)

