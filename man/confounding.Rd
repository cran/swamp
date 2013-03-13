\name{confounding}
\alias{confounding}
\title{Heatmap of interrelation of sample annotations
}
\description{The function tests the relationships of the sample annotations and plots the heatmap of the p-values.
}
\usage{
confounding(o, method = "chisq", workspace = 2e+07, smallest = -20, 
            diagonal.zero = F, label = colnames(o), note = T, notecol = "black", 
            notecex = 1, breaks = 50, col = c(heat.colors(48), "white"), key = T, 
            cexRow = 1, cexCol = 1, margins = c(7,7), colsep = NULL, 
            rowsep = NULL, sepcolor = "black", sepwidth = c(0.05,0.05))
}
\arguments{
  \item{o}{the sample annotations in the form of a data.frame, with the sample names as rownames(o). o can contain factors with 2 or more levels and numeric variables; no character variables are allowed. NAs are allowed and cases are removed at calculations. 
}
  \item{method}{statistical test to be used when two factors are tested, this can be either "fisher" or "chisq" to use fisher.test() or chisq.test(), respectively. 
              default = "chisq". fisher.test is however preferable as it is an exact test. Note that fisher.test() is computationally expensive and can cause R to crash.
}
  \item{workspace}{workspace to use if test="fisher".
}
  \item{smallest}{a numeric value. log10(p-values) less than smallest are set to smallest for plotting. default = -20.
                  e.g. a log10 p-value of -37 will be set to -20. Smallest has to be less than 0. 
}
  \item{diagonal.zero}{set to TRUE to force diagonal p-values to be 0. 
}
  \item{label}{vector containing names of the sample annotation. default=colnames(o)
}
  \item{note}{set to TRUE to print the p-values in the cells of the plot.
}
  \item{notecol}{to determine the color of the notes.
}
  \item{notecex}{to determine the font size of the notes.
}
  \item{breaks}{either a number (default=50) or a numeric vector (default would be seq(-20,0,length.out=50)) of breaks for the colors.
}
  \item{col}{a vector of colors with a length of breaks-1. default=c(heat.colors(48), "white")).
}
  \item{key}{whether the color key should be printed, default=TRUE.
}
  \item{cexRow}{font size of row label. default=1.
}
  \item{cexCol}{font size of column label. default=1.
}
  \item{margins}{a vector with the margins for columns and rows. default=c(7,7).
}
  \item{colsep}{same as in heatmap.2 function.
}
  \item{rowsep}{same as in heatmap.2 function.
}
  \item{sepcolor}{same as in heatmap.2 function.
}
  \item{sepwidth}{same as in heatmap.2 function.
}
}
\details{Technical and biological annotations are often interrelated, leading to confounding. This function tests the interelation of all sample annotations, be they technical batch surrogates or biological measures.
    Two sample annotations are compared at a time. If both are factors, fisher.test() or chisq() test can be used. Note that fisher.test() is computationally expensive and might cause R to crash at large sample numbers.
    If one sample annotation is numeric a linear modeal is used in the form of lm(numeric sample annotation~other sample annotation). The p-value is derived from the F-statistic of the linear model. The p-value from lm() is equivalent to the cor.test() p-value in the case of two numeric variables. NAs in the sample annotations are allowed and result in deletion of the NA case.
    It should be noted however, that different number of NAs in various sample annotations lead to different power of the comparisons. Matrices that specify for each comparison the test and sample number used are returned. With NAs in the data it is possible that a pair of sample annotations does not provide two different values each. In such a pair that does not show variance for both annotations the output is set to NA.
    The function uses heatmap.2() from the package gplots to plot the p-values.
}
\value{
a list with components
  \item{p.values}{a numeric square matrix that contains the p-values for associations between sample annotations.
    }
  \item{n}{a numeric square matrix that contains the number of samples at each test.
    }
  \item{test.function}{a character square matrix that contains the test function used at each test.
    }
  \item{classes}{a character vector that contains the classes of the variables in o.
    }
}
\author{Martin Lauss
}
\note{requires the package gplots
}
\examples{
# patient annotations as a data.frame, annotations should be numbers and factors but not characters.
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),
              Factor2=factor(rep(c("A","B"),25)),
              Factor3=factor(c(rep("X",15),rep("Y",20),rep("Z",15))),
              Numeric1=rnorm(50))
              
## calculate and plot interrelations
res4<-confounding(o,method="fisher")


}
\keyword{ htest }
