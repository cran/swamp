\name{quickadjust.ref}
\alias{quickadjust.ref}
\title{
Batch adjustment by median-scaling to a reference batch
}
\description{
The function adjusts for batches by adjusting the median of the features to the median of a reference batch.
}
\usage{
quickadjust.ref(g, batches, refbatch)
}
\arguments{
  \item{g}{the input data in form of a matrix with features as rows and samples as columns. NAs are allowed.
}
  \item{batches}{a factor with two or more levels and with same length as ncol(g), each level has to contain at least 2 samples. 
}
  \item{refbatch}{a character that determines the reference batch. this character has to be a level of batches.
}
}
\details{The batches are adjusted to a reference batch. The values of the reference batch remain unchanged. For each feature the median of the batches is determined. NAs are removed for median() calculations. The median of the reference batch is divided by the median of the non-reference batch, which is the scaling factor. 
    All values in the non-reference batch are multiplied by the scaling factor. This way all batches will have the same median as the reference batch for each feature. Scaling factors get inflated when data was already feature-centered before. Hence, this method is only advisable for uncentered data.
     This is a quick and simple method of batch adjustment, that probably does not work for every batch effect, especially when sample numbers per batch are low. The efficiency of batch adjustment can be checked by prince.plot(prince(g,o)) or prince.plot(prince(g, data.frame(batch,batch))).
}
\value{
a list with components
  \item{adjusted.data}{A numeric matrix which is the adjusted dataset.
    }
  \item{scaling.factors}{A numeric matrix containing the scaling factors for each feature in each batch.
    }
}
\references{}
\author{Martin Lauss
}
\note{
}

\seealso{
}
\examples{
## The function is currently defined as
# data as a matrix
set.seed(100)
g<-matrix(nrow=1000,ncol=50,rnorm(1000*50),dimnames=list(paste("Feature",1:1000),paste("Sample",1:50)))
g[1:100,26:50]<-g[1:100,26:50]+1 # the first 100 features show higher values in the samples 26:50
# patient annotations as a data.frame, annotations should be numbers and factors but not characters.
# rownames have to be the same as colnames of the data matrix 
set.seed(200)
o<-data.frame(Factor1=factor(c(rep("A",25),rep("B",25))),Factor2=factor(rep(c("A","B"),25)),
              Numeric1=rnorm(50),row.names=colnames(g))

##unadjusted.data
res1<-prince(g,o,top=10)
prince.plot(res1)

##batch adjustment
gadj2<-quickadjust.ref(g,o$Factor1,"B")
str(gadj2)
##prince.plot
prince.plot(prince(gadj2$adjusted.data,o,top=10),breaks=seq(-20,0,length.out=100)) # to have the same breaks as in prince.plot of unudjusted data 
    # note the high number of variation covered by the first principal component. This is caused by infalted scaling factor as the features of the input matrix g are already centered around zero.
    # this adjustment method should be used only on uncentered data.
}
\keyword{ design }
