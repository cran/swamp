\name{combat}
\Rdversion{1.1}
\alias{combat}
\title{
ComBat algorithm to combine batches.
}
\description{
Performs ComBat as described by Johnson et al.
}
\usage{
combat(g, o.withbatch, batchcolumn = NULL, par.prior = T, prior.plots = T)
}
\arguments{
  \item{g}{
the input data in form of a matrix with features as rows and samples as columns.
}
  \item{o.withbatch}{
   the batch annotation as a factor vector or within a dataframe that contains
   additional biological co-variates. make sure that the order of annotation is the same as in g. 
   rownames (o) must be identical to colnames (g). when submitting a data.frame o.withbatch it
   can contain only factors.
}
  \item{batchcolumn}{Required. Specify the batch column number of a dataframe ;
  set to 1 for a vector. All columns have to be factors, no NAs allowed.
}
  \item{par.prior}{if 'T' uses the parametric adjustments, if 'F' uses the
  nonparametric adjustments. if you are unsure what to use, try the parametric adjustments
  (they run faster) and check the plots to see if these priors are reasonable.
}
  \item{prior.plots}{ if 'T' will give prior plots with black as a kernal estimate
  of the empirical batch effect density and red as the parametric estimate. 
}
}
\details{
The R-code of the ComBat algorithm has been taken from the webpage jlab.byu.edu/ComBat
and input and output were adopted to the swamp package. ComBat uses parametric and non-parametric
empirical Bayes frameworks for adjusting data for batch effects. The method is robust to outliers
and performs particularly well with small sample sizes. ComBat can handle only categorical batch
variables in its current development stage. Biological covariates can be added to the model
(also categorical).
}
\value{
A numeric matrix which is the adjusted dataset.
}
\references{
Johnson WE, Li C, Rabinovic A. Adjusting batch effects in microarray
expression data using empirical Bayes methods. Biostatistics. 2007
Jan;8(1):118-27.
}
\author{
Martin Lauss 
}
\note{
R coded algorithm directly from Johnson WE
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
              Factor3=factor(c(rep("X",15),rep("Y",20),rep("Z",15))),
              Numeric1=rnorm(50),
              row.names=colnames(g))

##unadjusted.data
res1<-prince(g,o,top=10)
prince.plot(res1)

##batch adjustment for Factor 3
com1<-combat(g,o$Factor3,batchcolumn=1)
##batch adjustment for Factor 3; with covariate
com2<-combat(g,o[,c("Factor2","Factor3")],batchcolumn=2)

##prince.plot
prince.plot(prince(com1,o,top=10)) 
prince.plot(prince(com2,o,top=10)) 
}

\keyword{ design}