\name{quickadjust.zero}
\alias{quickadjust.zero}
\title{Batch adjustment by median-centering
}
\description{
The function centers the median of each feature in each batch to zero.
}
\usage{
quickadjust.zero(g, batches)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples
  as columns. NAs are allowed.
}
  \item{batches}{a factor with two or more levels and with same length as
  ncol(g), each level has to contain at least 2 samples. 
}
}
\details{The values of a feature are split up into batches and each part is
median-centered to zero, i.e. the batch median is subtracted from every value
in the batch. As a result the feature will have a median of zero in all batches.
NAs are removed for median() calculations.
    This is a quick and simple method of batch adjustment, that probably does
    not work for every batch effect, especially when sample numbers per batch
    are low. The efficiency of batch adjustment can be checked by
    prince.plot(prince(g,o)) or prince.plot(prince(g, data.frame(batch,batch))).
}
\value{
A numeric matrix which is the adjusted dataset.
}
\author{Martin Lauss
}
\examples{
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
          paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show
# higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factors
# but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))

##unadjusted.data
res1<-prince(g,o,top=10)
prince.plot(res1)

##batch adjustment
gadj1<-quickadjust.zero(g,o$Factor1)
##prince.plot
prince.plot(prince(gadj1,o,top=10)) 

}
\keyword{ design}
