\name{hca.test}
\alias{hca.test}
\title{
Tests for annotation differences among sample clusters
}
\description{
The main clusters of a dendrogram are tested for different patient annotations.
}
\usage{
hca.test(g, o, dendcut = 2, method = "correlation", link = "ward", test = "chisq", workspace = 2e+07)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples as columns.
}
  \item{o}{
  the corresponding sample annotations in the form of a data.frame. Sample annotation as a single vector is allowed and will be transformed to a data.frame.
   rownames (o) must be identical to colnames (g). o can contain factors and numeric variables. No character variables are allowed. NAs are allowed. 
}
  \item{dendcut}{
  the number of clusters to cut the dendrogram tree (using cutree()). default=2.
}
  \item{method}{the distance method for the clustering. default="correlation". hcluster from the package amap is used and method must be one of "euclidean", "maximum", "manhattan", "canberra" "binary" "pearson", "correlation", "spearman" or "kendall".
}
  \item{link}{the agglomeration principle for the clustering. default="ward". hcluster from the package amap is used and link must be one of "ward", "single", "complete", "average", "mcquitty", "median" or "centroid".
}
  \item{test}{the test to use for the annotations that are factors. this can be either "fisher" or "chisq" to use fisher.test() or chisq.test(), respectively. 
              default = "chisq". However fisher.test is preferable as it is an exact test. Note that fisher.test() is computationally expensive and can cause R to crash.
}
  \item{workspace}{workspace to use if test="fisher"
}
}
\details{
The function clusters the samples using amap and then cuts the dendrogram into a specified number of clusters. The obtained sample clusters are tested for differences in sample annotations.
fisher.test() or chisq.test() is used if the annotation is a factor, lm(annotation~clusters) is used for numeric annotations. The p-values for the dependence of sample annotation and sample clusters are returned.
}
\value{
a list with components
  \item{p.values}{a numeric vector containing the p.values for the annotation variable.
    }
  \item{classes}{the classes of the annotation variables in o.
    }
}
\references{
}
\author{Martin Lauss
}
\note{requires the package amap
}

\seealso{
}
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

# perform the test for the main 2 clusters
res3<-hca.test(g,o,dendcut=2,test="fisher") # use test="chisq" for large ncol(g) to avoid crash of R
res3$p.values
}
\keyword{ cluster }
\keyword{ htest}
