# rm(list=ls())

###################################################################
###################################################################
###################################################################
###################################################################

#C:\Rlanguedata\AnameCHANGE\GSE166190_Raw_counts

dir="C:\\1sci\\AnameCHANGE"
setwd(dir)



my_data <- read.csv("GSE188678.csv")

# # exp <- read.delim("TCGA-BRCA.htseq_counts.tsv",stringsAsFactors=FALSE) 
# data=data.frame(exp)
# 
# library(stringi)##加载包
# data$Ensembl_ID=stri_sub(data$Ensembl_ID,1,15)##保留前15位

library('tidyr')

# if (!require("BiocManager", quietly = TRUE))
#   
#   install.packages("BiocManager")
# 
# BiocManager::install("rtracklayer")

library('rtracklayer')

# R.utils::gunzip('Homo_sapiens.GRCh38.108.chr.gtf.gz')  解压缩命令

gtf1<- rtracklayer::import('Homo_sapiens.GRCh38.108.chr.gtf')

gtf_df<- as.data.frame(gtf1)

mRNA_exprSet<- gtf_df %>%
  
  dplyr::filter(type=="gene",gene_biotype=="protein_coding")%>%
  
  dplyr::select(c(gene_name,gene_id,gene_biotype)) %>%
  
  dplyr::inner_join(my_data, by = "gene_id")

# only select the protein coding genes.

mRNA_exprSet<- mRNA_exprSet[!duplicated(mRNA_exprSet$gene_name),]

write.csv(mRNA_exprSet, 'GSE188678_2.csv', quote = F, row.names = T)

###################################################################
###################################################################
###################################################################
###################################################################