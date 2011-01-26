\name{kill.pc}
\alias{kill.pc}
\title{Removes principal components from a data matrix
}
\description{
Does not destroy your personal computer. Really. (No warranty).
}
\usage{
kill.pc(g, pc, imputeknn = F, center = T)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples as columns.
}
  \item{pc}{the principal components to be removed in form of a numeric vector of length 1 or more. e.g. to remove pc1 and pc3 use pc=c(1,3), to remove only pc3 use pc=3.
}
  \item{imputeknn}{default=FALSE. missing values in the data matrix can be imputed by imputeknn=TRUE. The function knn.impute from the package impute is used with default settings. 
}
  \item{center}{
  default=TRUE. the features are mean-centered before singular value decompositon. this is a pre-requisite for principal component analysis, change only if you are really convinced that centering is not necessary. 
}
}
\details{A specific principal component might be associated with several interelated batch surrogate variables but free from biological associations. In such a case it may be useful to take out such a principal component from the data.
  The svd() function resolves the data matrix X into X = U*D*V. D is then set to zero for the unwanted principal components and the data X is recalculated. If you use the default center=TRUE make sure you also use prince() with the default center=TRUE. Using different settings for center for the two functions is not fully compatible.
}
\value{
a matrix which is the new data with the specified principal components removed.
}
\references{
}
\author{Martin Lauss
}
\note{requires the package impute.
}

\seealso{
}
\examples{
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factors but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))
  
## pca on unadjusted data
res1<-prince(g,o,top=10)
prince.plot(res1)

## take out pc1
gadj3<-kill.pc(g,pc=1)
prince.plot(prince(gadj3,o,top=10),breaks=seq(-20,0,length.out=100))  # to have the same breaks as in prince.plot of unudjusted data
}

\keyword{ design }
\keyword{ cluster }
