\name{prince}
\alias{prince}
\title{
Linear models of prinicipal conponents dependent on sample annotations 
}
\description{
The function calculates the principal components of the data and finds associations
between the prinicpal
components and the sample annotations using linear regressions.
}
\usage{
prince(g, o, top = 25, imputeknn = F, center = T, permute = F)
}
\arguments{
  \item{g}{
  the input data in form of a matrix with features as rows and samples as columns.
}
  \item{o}{
  the corresponding sample annotations in the form of a data.frame. rownames (o) must be
  identical to colnames (g). 
  o can contain factors with 2 or more levels and numeric variables; no character variables
  are allowed. NAs are allowed (these samples are ommited in lm()). 
}
  \item{top}{
  the number of top principal components to be analyzed, default is set to 25.
}
  \item{imputeknn}{
  default=FALSE. missing values in the data matrix can be imputed by imputeknn=TRUE.
  The function knn.impute from the package impute is used with default settings. 
}
  \item{center}{
  default=TRUE. the features are mean-centered before singular value decompositon.
  this is a pre-requisite for principal component analysis, change only if you are really
  convinced that centering is not necessary. 
}
  \item{permute}{
  default=FALSE. if set to TRUE a permuted data matrix is generated with the values for
  each feature shuffled. The linear models are also calculated for this permuted dataset.
}
}
\details{
To calculate the principal components of a data matrix, the function prcomp is used.
The function prcomp uses singular value decomposition instead of eigen decomposition
of the covariance matrix, the actual principal component analysis. As prcomp cannot
handle missing values they have to be imputed beforehands, imputeknn=TRUE can be used
for k-nearest neighbor imputation from package impute, k is 10.
A linear model is perfomed to find associations of the principal components with a dataframe
of sample annotations. The f-statistics of lm(principal component i ~ sample annotation j)
is used to derive the p-value for these associations. The results can be plotted using
the prince.plot() function. If permute=TRUE the analysis will be repeated on permuted data,
in which for each feature the values have been randomly shuffled.
}
\value{
a list as a prince object with components
  \item{pr}{the output list of the prcomp function with the principal components
  contained in pr$x. 
    }
  \item{linp}{matrix containing the F-test p-values
  from lm(principal component~sample annotation).
    }
  \item{rsquared}{matrix containing the R-squared values
  from lm(principal component~sample annotation).
    }  
  \item{prop}{numeric vector containing the percentage of the overall variation for
  each principal component.
    }
  \item{o}{the input data.frame containing the patient annotations.
    }
  \item{pr.perm}{if permute=T it contains the outcome list from prcomp for the permuted data.
    }
  \item{linpperm}{if permute=T it contains the p-values for the permuted data.
    }
  \item{rsquaredperm}{if permute=T it contains the R-squared values for the permuted data.
    }   
  \item{propperm}{if permute=T it contains the percentages of variation for the permuted data.
    }
  \item{imputed}{if imputeknn=T it contains the data matrix with the imputed values.
    }
}
\author{Martin Lauss}
\note{requires the package impute}
\examples{
## data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
          paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show
# higher values in the samples 26:50
## patient annotations as a data.frame, annotations should be numbers and factor
# but not characters.
## rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))
              
## calculate principal components and use linear models to calculate 
## their dependence on sample annotations
res1<-prince(g,o,top=10,permute=TRUE)
str(res1)
res1$linp # to see the p values
}

\keyword{ cluster }
\keyword{ regression }
