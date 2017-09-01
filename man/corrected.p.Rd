\name{corrected.p}
\alias{corrected.p}
\title{Correction of p-values for associations between features and sample annotation
}
\description{
The function corrects for multiple testing of associations of features to sample annotation.
Adjustment is done by padjust() or by the p-values from permuted data.
}
\usage{
corrected.p(feature.assoc, correction = "fdr", adjust.permute = T, 
            adjust.rank = T, ties.method = "first")
}
\arguments{
  \item{feature.assoc}{a list with the p-values of feature associations,
  typically created by the function feature.assoc().
  (If not created by feature.assoc() the list has to contain the elements observed.p
  and permuted.p.)
}
  \item{correction}{adjustment method to use for padjust().
  default="fdr". must be one of "holm", "hochberg", "hommel", "bonferroni",
  "BH", "BY", "fdr" or "none".
}
  \item{adjust.permute}{if set to TRUE (default), the p-values will be adjusted
  by observed.p divided by permuted.p for each rank in observed.p and permuted.p.
}
  \item{adjust.rank}{if set to TRUE (default), the p-values will be adjusted
  by calculating for every observed p-value the proportion of smaller permuted.p
  values to smaller observed.p values.
}
  \item{ties.method}{if adjust.permute=TRUE or adjust.rank=TRUE the method for
  handling ties can be either "first" or "random". Tied p-values are likely
  when using "AUC" as method to measure feature associations. default="first". 
}
}
\details{As high-dimensional data contains many features, the p-values of
feature associations have to be corrected for multiple testing.
The number of features that are significantly associated with sample annotation can
show how strog the data is connected to the respective sample annotation.
      The p-values can be adjusted using the standard correction methods of padjust().
      Additionally two methods that use the p-values from permuted data are proposed.
      First, p-values are adjusted by observed.p divided by permuted.p for each rank in
      observed.p and permuted.p. For instance if the third lowest p-value in 
      the observed associations is 1e-9 and the third lowest p value in
      the permuted data is 1e-4, this p-value is correced by 1e-9 divided
      by 1e-4  which is 1e-5.
      Second, p-values are adjusted by calculating for every observed p-value the
      proportion of smaller permuted.
      p values to smaller observed.p values. For instance, we have a p-value
      of 1e-3 which is ranked as the 300-lowest p-value in the observed data.
      In the permuted data there are 3 p-values that are lower than 1e-3.
      In the 300 p-values we suspect 3 of them to occur by chance, hence the
      adjusted p-value is 3 divided by 300 which is 0.01. 
      This correction method can yield p-values of 0 and is less robust when
      only a few permuted.p are smaller than the observed.p. Both proposed
      correction methods may acutally show similar results
      to padjust(observed.p,method="fdr")  
}
\value{
a list with components
  \item{padjust}{a numeric vector containing the corrected p-values using padjust().
    }
  \item{adjust.permute}{a numeric vector containing the corrected p-values using
  observed.p divided by permuted.p at each rank
    }
  \item{adjust.rank}{a numeric vector containing the corrected p-values by
  calculating for every observed p-value the proportion of smaller permuted.p values
  to smaller observed.p values
    }

}
\author{Martin Lauss}
\examples{
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),
          paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show
# higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factor
# but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))
              

#calculate feature associations
res4a<-feature.assoc(g,o$Factor1,method="correlation")
#correct the p-values
res5<-corrected.p(res4a)
  names(which(res5$padjust<0.05))
  names(which(res5$adjust.permute<0.05))
  names(which(res5$adjust.rank<0.05))
}

\keyword{ htest }
