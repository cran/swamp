\name{adjust.linearmodel}
\Rdversion{1.1}
\alias{adjust.linearmodel}
\title{Batch adjustment using a linear model
}
\description{
The function uses a linear model for each feature: with the feature as dependent variable and technical variables (batches) as regressors.
}
\usage{
adjust.linearmodel(g, o.batches, robust.lm = F, small.memory = F)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples as columns. NAs are allowed.
}
  \item{o.batches}{contains the batch variable(s). a numeric or factor vector, or a dataframe. 
}
  \item{robust.lm}{default=F, if set to true robust linear models are performed by rlm of package MASS.
     The calculations take longer than using lm because a loop is used.
}
  \item{small.memory}{default=F, if set to true robust a loop through the rows is used in the lm function.
     This reduces the risk of running out of memory, however computation time is longer.
}
}
\details{
For each feature a lm(feature~., batches) is performed. The residuals of the fitted model are returned.
(The means of the features of g are added to the residuals, as the residuals are centered,
which may not be desired.) 
Note the following possibilties of using a linear model for batch adjustment: 
1. Technical variables (Batches) can be numeric.
2. Numerical technical variables can be used in transformed forms (log, exp,...).
3. Several batch variables, be it numeric or factors, can be corrected at once, by just adding more regressors to the model.
By default the function performs lm. If robust.lm = T, robust linear models are performed
using the rlm funcion of MASS.
NAs are not allowed in g. Samples that contain NAs in o.batches are returned unadjusted. 

}
\value{
A numeric matrix which is the adjusted dataset.
}
\author{
Martin Lauss
}
\note{
robust linear models require the package MASS
}
\examples{
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
   paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factors but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50), Numeric2=colMeans(g),row.names=colnames(g))

##unadjusted.data
res1<-prince(g,o,top=10)
prince.plot(res1)

##batch adjustment
lin1<-adjust.linearmodel(g,o$Numeric2)
lin2<-adjust.linearmodel(g,o[,c("Numeric2","Factor2")]) # also correct for Factor2

##prince.plot
prince.plot(prince(lin1,o,top=10)) 
prince.plot(prince(lin2,o,top=10)) 


}

\keyword{ design}
