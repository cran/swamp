\name{prince.var.plot}
\alias{prince.var.plot}
\title{ScreePlot of the data variation covered by the principal components
}
\description{To identify the number of top principal components with relevant variation,
this function plots the variation contained in the pc for both observed data
and reshuffled data.
}
\usage{
prince.var.plot(g, show.top = dim(g)[2], imputeknn = F, 
                center = T, npermute = 10)
}
\arguments{
  \item{g}{
  the input data in form of a matrix with features as rows and samples as columns.
}
  \item{show.top}{
  the number of top principal components to be shown in the
  plot (cannot exceed ncol(g) or nrow(g)).
}
  \item{imputeknn}{
  default=FALSE. missing values in the data matrix can be imputed by imputeknn=TRUE.
  The function knn.impute from the package impute is used with default settings. 
}
  \item{center}{
  default=TRUE. the features are mean-centered before singular value decompositon.
  this is a pre-requisite for principal component analysis, change only if you are
  really convinced that centering is not necessary. 
}
  \item{npermute}{
  the number of reshuffled datasets. default=10. A permuted data matrix is generated
  with the values for each feature shuffled. From the permutation sets the median
  percentage of variation for each principal component is taken.
}
}
\details{The function prcomp() is used to calculate the variation of the data
contained in the principal components.  As prcomp cannot handle missing values
they have to be imputed beforehands, using imputeknn=TRUE.}
\value{
a list with components
  \item{real.variation}{a vector containing the percentage of variation for
  each principal component in the observed data.
    }
  \item{permuted.variation}{a matrix containing the percentages of variation
  for each principal component in the reshuffled data sets.
    }
}
\author{Martin Lauss}
\note{requires the package impute}
\examples{
## data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
          paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 
     # the first 100 features show higher values in the samples 26:50

## to plot the variations
res2<-prince.var.plot(g,show.top=50,npermute=10)
str(res2)
}

\keyword{ cluster }
