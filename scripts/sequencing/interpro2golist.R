## R.3.4
## Convert the interproscan result (including IPS and GO terms) from .tabular results to .csv files
## Results includes two tables

dir_input = paste(dir,"/Input",sep="") #variable 'dir. is working directory
setwd(dir_input)
input_interpro = c(list.files(dir_input, pattern = ".tabular", recursive = TRUE))

library(data.table)
library(dplyr)
library(stringr)
library(stringi)
interpro = fread(input_interpro, sep = "\t", header = FALSE)
CDS = unique(interpro[,1])
n = nrow(CDS)

table_full = NULL
table_short = NULL

for (i in 1:n){
  name = as.character(CDS[i,1])
  id = interpro %>% filter(V1==name,grepl("Dbxref|Ontology_term|signature_desc",V9))
  
  if(nrow(id)>0) {
    ips = str_extract_all(string = id[,9], pattern = "IPR[0-9]+")
    go = str_extract_all(string = id[,9], pattern = "GO:[0-9]+")
    desc = tstrsplit(id[,9], "signature_desc=")
    if(length(as.matrix(desc))>1){
      desc = tstrsplit(desc[[2]], ";")[[1]]
    }else{
      desc = rep('NA',nrow(id))
    }
    annotation = as.data.frame(cbind(rep(name,ncol(id)),ips,go,desc))
    table_full = rbind(table_full,annotation)
    
    #Unlist all IPS/GO annotaion, remove duplicate
    ips_list = stri_paste(unlist(unique(ips)),collapse=",")
    go_list = stri_paste(unlist(unique(go)),collapse=",")
    table_short = rbind(table_short,as.data.frame(cbind(name,ips_list,go_list)))
  } else {
    table_full = rbind(table_full,rep('NA',3))
    ips_list = 'NA'
    go_list = 'NA'
    table_short = rbind(table_short,as.data.frame(cbind(name,ips_list,go_list)))
  }
}
if(nrow(table_short)==n){
  colnames(table_full) = c("ID","IPS","GO","Desc")
  colnames(table_short) = c("ID","IPS","GO")
} else {
  print("Something's wrong!!!")
}

file_name = paste("IPS_GO_Description",".csv",sep="")
write.csv(as.matrix(table_full), file_name, row.names=FALSE)
dir = "/home/idies/workspace/Storage/Sophie/persistent"
dir_input = paste(dir,"/Input",sep="")
setwd(dir_input)
input_interpro = c(list.files(dir_input, pattern = ".csv", recursive = TRUE))

library(data.table)
library(dplyr)
library(stringr)
library(stringi)
interpro = fread(input_interpro, sep = ",", header = FALSE)
CDS = unique(interpro[,1])
n = nrow(CDS)

table_full = NULL #Including description, IPS terms and GO terms
table_short = NULL #Including only IPS terms and GO terms

for (i in 1:n){
  name = as.character(CDS[i,1])
  id = interpro %>% filter(V1==name,grepl("Dbxref|Ontology_term|signature_desc",V9))
  
  if(nrow(id)>0) {
    ips = str_extract_all(string = id[,9], pattern = "IPR[0-9]+")
    go = str_extract_all(string = id[,9], pattern = "GO:[0-9]+")
    desc = tstrsplit(id[,9], "signature_desc=")
    if(length(as.matrix(desc))>1){
      desc = tstrsplit(desc[[2]], ";")[[1]]
    }else{
      desc = rep('NA',nrow(id))
    }
    annotation = as.data.frame(cbind(rep(name,ncol(id)),ips,go,desc))
    table_full = rbind(table_full,annotation)
    
    #Unlist all IPS/GO annotaion, remove duplicate
    ips_list = stri_paste(unlist(unique(ips)),collapse=",")
    go_list = stri_paste(unlist(unique(go)),collapse=",")
    table_short = rbind(table_short,as.data.frame(cbind(name,ips_list,go_list)))
  } else {
    table_full = rbind(table_full,rep('NA',3))
    ips_list = 'NA'
    go_list = 'NA'
    table_short = rbind(table_short,as.data.frame(cbind(name,ips_list,go_list)))
  }
}
if(nrow(table_short)==n){
  colnames(table_full) = c("ID","IPS","GO","Desc")
  colnames(table_short) = c("ID","IPS","GO")
} else {
  print("Something's wrong!!!")
}

file_name = paste("IPS_GO_Description",".csv",sep="")
write.csv(as.matrix(table_full), file_name, row.names=FALSE)
file_name = paste("IPS_GO",".csv",sep="")
write.csv(as.matrix(table_short), file_name, row.names=FALSE)
