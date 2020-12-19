#args [1] - input table
#args [2] - transposing flage (TRUE - transposing required, FALSE - not required)
#args [3] - number of clusters (k)
#args [4] - max number of iterations
#args [5] - base name for the output files

#options(echo=TRUE)

library(stats)
library(tools)

#args <- commandArgs(trailingOnly = TRUE)
args = c(rep(0,5))
args [1] = "kmeans_input.txt"
args [2] = "TRUE"
args [3] = 4
args [4] = 100
args [5] = "kmeans_input.txt"
file_name = file_path_sans_ext(args[5])


#Read input data table
dat_s <- read.table(args [1], header=TRUE, row.names=1, check.names=FALSE)
if(as.logical (args[2]) == TRUE){
    dat_s <- t(dat_s)
}

#Perform clustering
k <- as.numeric (args[3])
imax <- as.numeric (args[4])
num_obj <- dim (dat_s) [1]
if (num_obj > 15 * k) {
    N <- 10
} else {
    N <- as.integer ((num_obj * 2) / (k * 3))
}
cl <- kmeans(dat_s, centers=k, iter.max=imax, nstart=N)


#output tables with cluster IDs 
clust_ids <- cl$cluster

txt_file_c <- paste(file_name, "_", "cRes_kmeans.ClustersOnly", ".txt", sep="")
cat ("\"Object\"\t\"ClusterID\"\n", file=txt_file_c, append=FALSE)
write.table (clust_ids, file=txt_file_c, append=TRUE, sep="\t", col.names=FALSE, row.names=TRUE)

txt_file <- paste(file_name, "_", "cRes_kmeans.FullTable", ".txt", sep="")	
out_table <- cbind (clust_ids, dat_s)
colnames (out_table) [1] <- "ClusterID"
cat ("\"Object\"\t", file=txt_file, append=FALSE)
write.table (out_table, file=txt_file, append=TRUE, sep="\t", col.names=TRUE, row.names=TRUE)

