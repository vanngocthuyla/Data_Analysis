## R.3.4
## Use available R package named 'KEGGREST' to retrieve the KEGG pathway
## https://bioconductor.org/packages/release/bioc/vignettes/KEGGREST/inst/doc/KEGGREST-vignette.html

'''
## Input files

1. The genename file under .tabular or .csv format, including two columns which is gene_ID and KEGG_ID
|  gene_ID |   RefSeq   |
|----------|------------|
|Sequence_1|XP_021675086|
|Sequence_2|XP_021690815|

2. The list of DEGs (if neccesary)

## Output files: Table of 5 columns: Gene_ID, RefSeq, KEGGID, Functional Description, KEGG-pathway
'''

dir = "/home"
dir_input = paste(dir,"/Input",sep="")
setwd(dir_input)
input_list = c(list.files(dir_input, pattern = "List", recursive = FALSE))
input_refseq = c(list.files(dir_input, pattern = "RefSeq", recursive = TRUE))

library(data.table)
list = NULL
refseq = NULL
list = fread(input_list, header = TRUE) #list of DEGs that need to be annotated
refseq = fread(input_refseq, sep = ",", header = TRUE)

if((nrow(refseq)<nrow(list)) && (length(list)>0) && (length(refseq)>0)) {
  n_gene = nrow(list)
  output = cbind(list[,1],rep('NA',n_gene))
  count = 1
  for (i in 1:n_gene) {
    if((refseq[count,1]!=list[i,1]) || count>nrow(refseq)) {
      output[i,2]='NA'
    }
    else {
      output[i,2]=refseq[count,2]
      count = count + 1
    }
  }
}

library("KEGGREST")
library(stringr)
library(stringi)

output = cbind(output,rep('NA',n_gene),rep('NA',n_gene),rep('NA',n_gene))
start_time = Sys.time()

for(i in 1:n_gene){
  query = matrix(nrow=1, ncol=1)
  if(output[i,2]!='NA'){
    id = keggConv("T05150", paste("ncbi-proteinid:",output[i,2],sep=""))
    if(length(id)>0){
      output[i,3] = id
      query[1] = keggGet(output[i,3])
      output[i,4] = query[[1]]$DEFINITION
      
      #Find pathway
      path = keggLink("pathway",id)
      if(length(path)>0){
        list = strsplit(str_sub(path,6,13)," ")
        output[i,5] = stri_paste(list, collapse=',')
      }
    }
  }
}
colnames(output) = c("ID","RefSeq_ID","KEGG_ID","Description","Pathway_ID")
head(output)
end_time = Sys.time()
print(end_time - start_time)

file_name = paste("Output",".csv",sep="")
write.csv(output, file_name, row.names=FALSE)
