#### Function .unlist
.unlist <- function (x){
  ## do.call(c, ...) coerces factor to integer, which is undesired
  x1 <- x[[1L]]
  if (is.factor(x1)){
    structure(unlist(x), class = "factor", levels = levels(x1))
  } else {
    do.call(c, x)
  }
}

#### Function count_by_size 
count_by_size <- function(bam_df, start = 36, end = 600) {
  chr = c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10",
          "chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20",
          "chr21","chr22","chrX","chrY")
  num = c(1:22,"X","Y")
  table = matrix(c(rep(0,24*(end-start+1))), nrow = 24, ncol = end-start+1)
  colnames(table)=c(start:end)
  rownames(table)=chr
  
  for (i in 1:24)
  {
    message(chr[i])
    mat = bam_df[which(bam_df$rname==chr[i]),]
    if(nrow(mat)==0)
    {
      mat = bam_df[which(bam_df$rname==num[i]),]
    }
    mat = as.matrix(table(mat$isize))
    
    if(length(mat)==1)
    {
      message("Can not count by size.")
      break()
    }
    
    nrow_mat=rownames(mat)
    while(sum(which(nrow_mat==start))==0){
      start = start + 1
      if (start > end){
        break
      }
    }
    if (start > end){
      break
    }
    mat = mat[which(nrow_mat==start):length(nrow_mat),]
    nrow_mat = nrow_mat[which(nrow_mat==start):length(nrow_mat)]
    
    count = 1
    for(k in 1:ncol(table))
    {
      if(nrow_mat[count]==colnames(table)[k])
      {
        table[i,k]=mat[count]
        count = count + 1
      }
    }
  }
  return(table)
}

#### Count_by_size for multiple samples 
multi_bam_by_size <- function(bamFile, start=36, end=600) {
  chr = c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10",
          "chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20",
          "chr21","chr22","chrX","chrY")
  matrix = cbind(rep(chr, each = end-start+1), rep(c(start:end),length(chr)))
  colnames(matrix) = c("Chr","Size")
  
  for (j in 1:length(bamFile))
  {
    ptm <- proc.time()
    message("Count reads by size in ", bamFile[j])
    bam <- scanBam(bamFile[j])
    
    bam_field <- names(bam[[1]])
    list <- lapply(bam_field, function(y) .unlist(lapply(bam, "[[", y)))
    bam_df <- do.call("DataFrame", list)
    names(bam_df) <- bam_field
    
    table = count_by_size(bam_df, start = start, end = end)
    #output.file = paste(bamFile[j],'.csv', sep = '')
    #write.csv(table, file = output.file)
    
    elapsed <- (proc.time() - ptm)["elapsed"]
    message("Time used: ", round(elapsed/60,2))
    
    matrix=cbind(matrix, as.vector(table))
    colnames(matrix)[j+2] = bamFile[j]
  }
  return(matrix)
}

#### Calculate zscore from two datasets ref and test uing NCV method
delta_F_ncv <- function(input, flag = NULL) {
  eup = fread(input, sep = ',', colClasses=list(character=1), header=TRUE)
  eup = as.data.frame(eup)
  sampleIDs = colnames(eup[3:length(eup)])
  
  if (!is.null(flag)) {
    ref = eup
    ref_150 = ref[which(ref[,2]<=150),]
    
    if (flag=="T13"){
      fetal = eup[which(eup[,1] %in% c("chr13")),]
      fetal_150 = fetal[which(fetal[,2]<=150),]
      ref = eup[which(eup[,1] %in% c("chr4","chr5")),]
      ref_150 = ref[which(ref[,2]<=150),]
    }
    else if (flag=="T18"){
      fetal = eup[which(eup[,1] %in% c("chr18")),]
      fetal_150 = fetal[which(fetal[,2]<=150),]
      ref = eup[which(eup[,1] %in% c("chr8")),]
      ref_150 = ref[which(ref[,2]<=150),]
    }
    else if (flag=="T21"){
      fetal = eup[which(eup[,1] %in% c("chr21")),]
      fetal_150 = fetal[which(fetal[,2]<=150),]
      ref = eup[-which(eup[,1] %in% c("chr13","chr18","chr21","chrX","chrY")),]
      ref_150 = ref[which(ref[,2]<=150),]
    }
    else if (flag=="chrX"){
      fetal = eup[which(eup[,1] %in% c(flag)),]
      fetal_150 = fetal[which(fetal[,2]<=150),]
      ref = eup[which(eup[,1] %in% c("chr3","chr4")),]
      ref_150 = ref[which(ref[,2]<=150),]
    }
    else {
      fetal = eup[which(eup[,1] %in% c(flag)),]
      fetal_150 = fetal[which(fetal[,2]<=150),]
      ref = eup[-which(eup[,1] %in% c("chr13","chr18","chr21","chrX","chrY")),]
      ref_150 = ref[which(ref[,2]<=150),]
    }
    
    ref = ref[,-c(1,2)]
    ref_150 = ref_150[,-c(1,2)]
    fetal = fetal[,-c(1,2)]
    fetal_150 = fetal_150[,-c(1,2)]
    
    if( !is.null(nrow(ref)) ) {
      p_fetal = colSums(fetal_150)/colSums(fetal)
      p_ref = colSums(ref_150)/colSums(ref)
    } else {
      p_fetal = sum(fetal_150)/sum(fetal)
      p_ref = sum(ref_150)/sum(ref)
    }
    return(p_fetal - p_ref)
  }
}
ncv = function(input_ref, input_test){
  #Ref
  ref_13 = delta_F_ncv(input_ref, flag="T13")
  ref_18 = delta_F_ncv(input_ref, flag="T18")
  ref_21 = delta_F_ncv(input_ref, flag="T21")
  ref = cbind(ref_13,ref_18,ref_21)
  mean_ref = colMeans(ref)
  sd_ref = apply(ref,2,sd)
  
  #Test
  test_13 = delta_F_ncv(input_test, flag="T13")
  test_18 = delta_F_ncv(input_test, flag="T18")
  test_21 = delta_F_ncv(input_test, flag="T21")
  test=cbind(test_13,test_18,test_21)
  n_samples = length(test_13)
  
  z = matrix(0,n_samples,ncol=3) #zscore
  for (j in 1:n_samples){
    z[j,1] = (test[j,1] - mean_ref[1]) / sd_ref[1]
    z[j,2] = (test[j,2] - mean_ref[2]) / sd_ref[2]
    z[j,3] = (test[j,3] - mean_ref[3]) / sd_ref[3]
  }
  rownames(z) = rownames(test)
  colnames(z) = c("T13","T18","T21")
  
  return(z)
}

#### Plot
plotPoint = function(zscore, cutoff = 3) {
  x = rep(c("T13", "T18", "T21"), nrow(zscore))
  y = as.vector(t(zscore))
  df = data.frame(x,y) 
  ggplot(df, aes(x, y)) +
    geom_point(aes(colour = factor(x)), size = 1) +
    geom_hline(yintercept = cutoff, linetype = "dashed", color = "red", size = 0.5) +
    ggtitle("Plot of size-based zscore \n by Trisomy") +
    xlab("Trisomy") + ylab("Size-based zscore") +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(colour = "black"),
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"), 
          axis.title.x = element_text(size = 12), 
          axis.title.y = element_text(size = 12))
}

library(Rsamtools)
dir_ref = "/home/reference"
dir_test = "/test"
dir_result = "/home/Result"

#### Build the matrix of reads by size 
setwd(dir_ref)
bamFile = c(list.files(dir_ref, pattern = ".bam",recursive = TRUE))
matrix = multi_bam_by_size(bamFile, start = 36, end = 600)
setwd(dir_result)
write.csv(matrix,"ref.csv",row.names = FALSE)

setwd(dir_test)
bamFile = c(list.files(dir_test, pattern = ".bam",recursive = TRUE))
matrix = multi_bam_by_size(bamFile, start = 36, end = 600)
setwd(dir_result)
write.csv(matrix,"test.csv",row.names = FALSE)

#### Load the matrix and call NIPT
library(data.table)
library(ggplot2)

setwd(dir_result)
input = c(list.files(dir_result, pattern = ".csv", recursive = TRUE))
(z = ncv(input[33],input[34]))
(z > 3)
pdf("NCV.pdf", width=10, height=5)
plotPoint(z)
dev.off()
write.csv(z,"NCV.csv")
