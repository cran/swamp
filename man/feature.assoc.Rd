\name{feature.assoc}
\alias{feature.assoc}
\title{Associations of the features to a sample annotation in observed and reshuffled data.
}
\description{
This function calculates the associations of each feature of the data matrix to a specified
sample annotation. Either Pearson correlation, t-test statistic,
Area Under Curve or R squared is used as measure of association. 
In parallel, the features in permuted data are tested for comparison.
}
\usage{
feature.assoc(g, y, method = "correlation", g1 = NULL, exact = 1)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples as columns.
  Missing values are allowed.
}
  \item{y}{a factor or numeric vector which contains the sample information.
  Typically a variable of the data.frame o used in the remaining functions of this package.
  y can be a factor with 2 or more levels or a numeric vector. y cannot be a character vecor.
  y has to be of the same length as ncol (g). Missing values are allowed and those cases are
  removed from the calculations.
}
  \item{method}{if y is a factor with two levels, this method is used for calculation of the
  association. The method can be one of "correlation", "t.test", or "AUC". If y is a factor
  with >2 levels lm() is used automatically, if y is numeric cor() is used automatically to
  determine the associations.  
}
  \item{g1}{As there are different ways to generate a randomized dataset, a pre-calculated
  permutation set can be specified here. Else the permutation data is generated within the
  function by reshuffling the values for each feature. g1 has to be a matrix with the same
  dimensions as g. 
}
  \item{exact}{if method="AUC", exact determines how wilcox.test() treats ties.
}
}
\details{For each feature the association to the sample annotation is calculated. If the
sample annotaion is a factor with 2 levels, it can be chosen whether Pearson correlation,
t.test statistic or Area Under Curve (AUC) is used as measure of association. The
uncorrected p-values for the strength of associations are calculated by cor.test(),
t.test() and wilcox.test() respectively.
        The distribution of these associations can be seen using dense.plot() function.
        For instance this can reveal a group of positively associated features. The order
        of the levels in levels(y) is decisive, e.g. for correlation the factors are
        transformed by as.numeric(), whereby the first level becomes 1 and the second level
        becomes 2. Hence, a positive association means higher values in samples with
        level 2 and a negative assocation means higher values in level 1. This should also
        be true for t.test and AUC, but please re-check.
        If the annotation is a factor with more than 2 levels, lm() is automatically used
        with R squared as the measure of association and the p-value as obtained from the
        F statistic. If the annotation is a numeric vector, correlation
        is used (with cor.test() for p-value). NAs are allowed in both the data matrix
        and the annotation vector and is treated by case-wise deletion for the calculations.
        To see the relelvance of the associations, the calculations are repeated with permuted
        data, which can be either pre-entered as g1 or otherwise is calculated within the
        function by reshuffling the values for each feature.
}
\value{
a list with components
  \item{observed}{a numeric vector containing the association of features to sample
  annotation in the observed data.
    }
  \item{permuted}{a numeric vector containing the association of features to sample
  annotation in the permuted data.
    }
  \item{observed.p}{a numeric vector containing the p-values for association of features
  to sample annotation in the observed data.
    }
  \item{permuted.p}{a numeric vector containing the p-values for association of features
  to sample annotation in the permuted data.
    }
  \item{method}{the method used as measure of association, which can be one of "correlation",
   "t.test", "AUC" or "linear.model".
    }
  \item{class.of.y}{a character that states the class of y.
    } 
  \item{permuted.data}{the matrix of the permuted data.
    }
}
\author{Martin Lauss}
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

# calculate the associations to Factor 1
res4a<-feature.assoc(g,o$Factor1,method="correlation")
res4b<-feature.assoc(g,o$Factor1,method="t.test",g1=res4a$permuted.data) 
    # uses t.test instead, reuses the permuted data generated in res4a
res4c<-feature.assoc(g,o$Factor1,method="AUC",g1=res4a$permuted.data) 
    # uses AUC instead, reuses the permuted data generated in res4a
str(res4a)
 
}

\keyword{ htest }
