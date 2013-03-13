\name{hca.plot}
\alias{hca.plot}
\title{
Dendrogram with according sample annotations
}
\description{
The function plots the dendrogram from hierarchical cluster analysis with colorcoded sample annotations below.
}
\usage{
hca.plot(g, o, method = "correlation", link = "ward", colored = palette(), 
         border = NA, code = colnames(o), cex.code = 1, 
         breaks = round(nrow(oreihe)/4), 
         cutcolors = colorpanel(breaks, low = "green", mid = "black", high = "red"))
}
\arguments{
  \item{g}{ the input data in form of a matrix with features as rows and samples as columns.
}
  \item{o}{
  the corresponding sample annotations in the form of a data.frame. A single sample annotation variable as a vector is allowed and will be transformed to a data.frame.
   rownames (o) must be identical to colnames (g). o can contain factors and numeric variables. No character variables are allowed. NAs are allowed and blank spaces are plotted. 
}
  \item{method}{the distance method for the clustering. default="correlation". hcluster from the package amap is used and method must be one of "euclidean", "maximum", "manhattan", "canberra" "binary" "pearson", "correlation", "spearman" or "kendall".
}
  \item{link}{the agglomeration principle for the clustering. default="ward". hcluster from the package amap is used and link must be one of "ward", "single", "complete", "average", "mcquitty", "median" or "centroid".
}
  \item{colored}{a vector of colors in which factor variables of o will be colorcoded. default are the 8 colors of palette(). the first level is plotted in the first color, the second in the second color and so on. for annotation with more than 8 levels colors should be added here.
}
  \item{border}{a color for the borders in the annotation rectangels rect(). default=NA.
}
  \item{code}{vector containing names of the sample annotations. default=colnames(o).
}
  \item{cex.code}{font size of code.
}
  \item{breaks}{a number that determines in how many bins a numeric annotation is cut using the cut() function.
}
  \item{cutcolors}{a vector of color in which numeric variables will be colored. length(cutcolors) has to be the number of breaks. a colorpanel is default to plot the numeric values as a color gradient, with low values in green and high values in red.
}
}
\details{
The data is clustered using the amap package. The plot works for sample annotations as a data.frame or as a single vector. NAs are allowed in both data matrix and sample annotation data.frame.
If the annotation is a factor, the annotations come in the colororder specified by colored.
If the annotation is numeric, breaks and cutcolors is used which is currently set to be a colorpanel().
}
\author{Martin Lauss
}
\note{
requires the packages amap and gplots 
}
\examples{
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
   paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factor but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))

## hca plot
hca.plot(g,o) 
 
}
\keyword{ cluster }


