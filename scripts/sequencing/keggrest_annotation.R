## R.3.4
## Use available R package named 'KEGGREST' to retrieve the KEGG annoation
## https://bioconductor.org/packages/release/bioc/vignettes/KEGGREST/inst/doc/KEGGREST-vignette.html

'''
## Input files
1. The genename file under .tabular or .csv format, including two columns which is gene_ID and KEGG_ID

|  gene_ID |   KEGG_ID   |
|----------|-------------|
|Sequence_1|hbr:110634890|
|Sequence_2|hbr:110643120|

2. The list of DEGs (if neccesary)

## Output files: Functional description of DEGs
'''

library(KEGGREST)
library(data.table)

dir = "/home"
dir_input = paste(dir,"/Input",sep="")
setwd(dir_input)
input_genename = c(list.files(dir_input, pattern = "Gene", recursive = TRUE)) #Result of blastx contains only the KEGG name of DEGs
input_list = c(list.files(dir_input, pattern = "List", recursive = FALSE)) #the list of DEGs that needs to be annotated instead of annotation all the DEGs

list = NULL
genename = fread(input_genename, sep = ",", header=TRUE)
list = fread(input_list, header = FALSE)

if(length(list)>0){
  n_CDS = nrow(list)
  id = matrix(nrow=n_CDS, ncol=1)
  attribute = matrix(nrow=n_CDS, ncol=1)
  query = matrix(nrow=1, ncol=1)
  
  for(i in 1:n_CDS){
    id[i] = genename[which(genename[,1]==as.character(list[i])),2]
    query[1] = keggGet(id[i])
    attribute[i] = query[[1]]$DEFINITION
  }
  table = cbind(list,attribute)
  colnames(table) = c("SeqID","Attribute")
  
  file_name = paste("KEGG_Annotation",".csv", sep="")
  write.csv(table, file_name, row.names=FALSE)
  
} else {
  
  head(genename)
  n_CDS = nrow(genename)
  attribute = matrix(nrow=n_CDS, ncol=1)
  query = matrix(nrow=1, ncol=1)
  
  for(i in 1:n_CDS){
    if(genename[i,2]!="None"){
      query[1] = keggGet(genename[i,2])
      attribute[i] = query[[1]]$DEFINITION
    }
  }
  attribute = cbind(genename,attribute)
  colnames(attribute) = c(colnames(genename),"Attribute")
  
  file_name = paste("KEGG_Annotation",".csv",sep="")
  write.csv(table, file_name, row.names=FALSE)
}
