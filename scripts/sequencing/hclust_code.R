args = c(rep(0,6))
args [1] = "hclust_input.txt"
args [2] = "TRUE" #transposing flage (TRUE - transposing required, FALSE - not required)
args [3] = "euclidean" #distance type (euclidean / manhattan / maximum / canberra / binary / minkowski)
args [4] = "average" #linkage type (single / complete / average / mean / centroid / ward.D / ward.D2
args [5] = 4 #number of clusters that is used for the selection of the cut-off level
args [6] = "hclust_output.txt" #base name for the output files

library(stats)
library(tools)

#args <- commandArgs(trailingOnly=TRUE)
file_name <- file_path_sans_ext(args[6])

#Read input data table
dat_s <- read.table(args [1], header=TRUE, row.names=1, check.names=FALSE)
if (as.logical (args[2]) == TRUE){
    dat_s <- t(dat_s)
}

#Perform clustering
cl <- hclust (dist (dat_s, method=args[3]), method=args[4])

#Output dendrogram
pdf(paste(file_name,"_","cRes_hclust",".pdf",sep = "")	)
descr1 <- paste ("Distance: ", args [3], sep="")
descr2 <- paste ("Linkage: ", args [4], sep="")
plot(cl, xlab=descr1, sub=descr2)
temp <- dev.off()

#Cut tree to get the required number of clusters and output cluster IDs for all the samples
clust_ids <- cutree (cl, k=args[5])

#output tables with cluster IDs 
txt_file_c <- paste(file_name, "_", "cRes_hclust.ClustersOnly", ".txt", sep="")
cat ("\"Object\"\t\"ClusterID\"\n", file=txt_file_c, append=FALSE)
write.table (clust_ids, file=txt_file_c, append=TRUE, sep="\t", col.names=FALSE, row.names=TRUE)

txt_file <- paste(file_name, "_", "cRes_hclust.FullTable", ".txt", sep="")	
out_table <- cbind (clust_ids, dat_s)
colnames (out_table) [1] <- "ClusterID"
cat ("\"Object\"\t", file=txt_file, append=FALSE)
write.table (out_table, file=txt_file, append=TRUE, sep="\t", col.names=TRUE, row.names=TRUE)

