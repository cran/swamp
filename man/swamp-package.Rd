\name{swamp-package}
\alias{swamp-package}
\alias{swamp}
\docType{package}
\title{
\packageTitle{swamp}
}
\description{
The package contains functions to connect the structure of the data with sample information.
Three types of analyses are covered: 1. linear models of principal components. 2. hierarchical
clustering analysis. 
3. distribution of associations between individual features and sample annotations.
Additionally, the inter-relation between sample annotations can be analyzed. 
We include methods for batch adjustment by a. median-centering,
b. linear models and c. empirical bayes (combat).
A method to remove principal components from the data is also included. 
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{swamp}
\packageIndices{swamp}
This package aims to find the associations between a high-dimensional data matrix,
typically obtained form high-throughput analysis, to the sample annotations,
be they technical (e.g. batch surrogates) or biological information.
High-dimensional data usually has a much larger number of features than samples.
This requires specific analysis to see "how the data looks like" and in which
way the technical and biological information on the samples is reflected in the
dataset.
Sample annotations can be analyzed for their association to principal
componenents (prince(), prince.plot(), prince.var.plot()) as well as clusters
from HCA (hca.plot(), hca.test()).
The distribution of association of sample annotations to the features can be
plotted and analysed (feature.assoc(), dense.plot(), corrected.p()).
Batch surrogate variables might be associated with biological annotations,
hence making batch adjustment of the data problematic. The associations between
the sample annotations can be calculated and plotted (confounding()).
If unwanted batch effects have been identified in the previous steps, two
simple methods are provided to adjust the data (quickadjust.zero(),
quickadjust.ref()). Another batch adjustment uses linear models,
with the advantage to remove numerical variables and several variables at
once (adjust.linearmodel()). In addition, the popular ComBat batch adjustment
has been adopted for the package to combine batches of small sample
size (combat()). Principal components confounded by batch variables can be
reomved from the data (kill.pc()). 
To use the functions of this package, the data matrix has to be a numeric
matrix and the sample annotations have to be a data.frame with numeric or
factors with 2 or more levels. NAs are allowed in both the data matrix and
the annotation dataframe, except for the functions adjust.linearmodel()
and combat(). 
}
\author{
\packageAuthor{swamp}

Maintainer: \packageMaintainer{swamp}
}
\keyword{ package }
\examples{
##### first you need a dataset (matrix)
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
          paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1  ## lets put in some larger values
set.seed(200)
##### second you need sample annotations (data.frame)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))  
              # Level "B" of Factor 1 marks the samples with the larger values
              


##### perform the functions

## principal components
res1<-prince(g,o,top=10,permute=TRUE)
prince.plot(prince=res1) 
  # to plot p values of linear models: lm(principal components ~ sapmle annotations). 
  # to see if the variation in the data is associated with sample annotations.
res2<-prince.var.plot(g,show.top=50,npermute=10) 
  # to see how many principal components carry informative variation

## hierarchical clustering analysis
hca.plot(g,o) 
  # to show a dendrogram with sample annotations below
res3<-hca.test(g,o,dendcut=2,test="fisher") 
  # to test if the major clusters show differences in sample annotations

## feature associations
res4a<-feature.assoc(g,o$Factor1,method="correlation") 
  # to calculate correlation between one sample annotation and each feature
res4b<-feature.assoc(g,o$Factor1,method="t.test",g1=res4a$permuted.data) 
res4c<-feature.assoc(g,o$Factor1,method="AUC",g1=res4a$permuted.data)
dense.plot(res4a) 
  # to plot the distribution of correlations in the observed data 
  # in comparison to permuted data
dense.plot(res4b)
dense.plot(res4c)
res5<-corrected.p(res4a) 
  # to correct for multiple testing and find out how many features are 
  # significantly associated to the sample annotation
names(which(res5$padjust<0.05))
names(which(res5$adjust.permute<0.05))
names(which(res5$adjust.rank<0.05))

## associations between sample annotations
res4<-confounding(o,method="fisher") 
  # to see how biological and technical annotations are inter-related

## adjustment for batch effects
gadj1<-quickadjust.zero(g,o$Factor1) 
  # to adjust for batches (o$Factor1) 
  # using median centering of the features for each batch
prince.plot(prince(gadj1,o,top=10))

gadj2<-quickadjust.ref(g,o$Factor1,"B") 
  # to adjust for batches (o$Factor) 
  # by adjusting the median of the features to the median of a reference batch.
prince.plot(prince(gadj2$adjusted.data,o,top=10))

gadj3<-kill.pc(g,pc=1)  
  # to remove one or more principal components (here pc1) from the data
prince.plot(prince(gadj3,o,top=10))

lin1<-adjust.linearmodel(g,o$Numeric1)  
  # to adjust for numerical variables using a linear model
prince.plot(prince(lin1,o,top=10))

com1<-combat(g,o$Factor1,batchcolumn=1)  
  # to use the empirical Bayes framework of ComBat, popular for small-sample sizes
prince.plot(prince(com1,o,top=10))

} 