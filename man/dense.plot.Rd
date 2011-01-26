\name{dense.plot}
\alias{dense.plot}
\title{Density plots of feature associations in observed and permuted data
}
\description{
The function plots the distribution of feature associations for a specified sample annotation for both observed and reshuffled data.
}
\usage{
dense.plot(feature.assoc, lty = 1:2, col = 1:2, lwd = c(2, 2), ylab = "", main = "", cex.main = 1, cex.lab = 1, cex.axis = 1)
}
\arguments{
  \item{feature.assoc}{A list of feature associations, typically created by the function feature.assoc(). (If not created by feature.assoc() the list has to contain the elements observed, permuted and method.)
}
  \item{lty}{a numeric vector containing the line types for the observed and permuted density lines. default=1:2.
}
  \item{col}{the colors for the observed and permuted density lines. default=1:2.
}
  \item{lwd}{the line widths. default=c(2,2).
}
  \item{ylab}{optional labeling of y-axis.
}
  \item{main}{optional titel.
}
  \item{cex.main}{optional titel font size.
}
  \item{cex.lab}{optional axis label font size.
}
  \item{cex.axis}{optional axis font size.
}
}
\details{The function plots the distribution of associations of features with a sample annotation calculated by feature.assoc(). The function uses plot.density() for the observed data and adds the permuted data using lines(density()).
      The x-axis is dependent on the method used to measure association, e.g. if the method was "correlation", then xlim is c(-1,1) and xlab="Corrlation".
}
\value{}
\references{}
\author{Martin Lauss}
\note{}

\seealso{}
\examples{
## data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show higher values in the samples 26:50
## patient annotations as a data.frame, annotations should be numbers and factor but not characters.
## rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))

# calculate the associations to Factor 1
res4a<-feature.assoc(g,o$Factor1,method="correlation")
res4b<-feature.assoc(g,o$Factor1,method="t.test",g1=res4a$permuted.data) # uses t.test instead, reuses the permuted data generated in res4a
res4c<-feature.assoc(g,o$Factor1,method="AUC",g1=res4a$permuted.data) # uses AUC instead, reuses the permuted data generated in res4a

# plot distribution of associations in observed and permuted data
dense.plot(res4a)
dense.plot(res4b)
dense.plot(res4c)
}
\keyword{ htest }
\keyword{ distribution }
