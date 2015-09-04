##' Majority voting.
##'
##' Predict a class given a list of neighbours obtained from k-nn using majority
##' voting.
##'
##' Todo: Distance weighted majority voting/distance kernel.
##'
##' @param cls A list of neighbour classes found with \code{\link{knn}}.
##' @param distance An equal length list of neighbour distances.
##' @return The majority prediction along with classification confidence.
##' @examples
##'
##' # form the query instance.
##' query <- list(
##'     sepal.length=5.84,
##'     sepal.width=3.05,
##'     petal.length=3.76,
##'     petal.width=1.20)
##'
##' # get the 10-nearest neighbours.
##' top.10 <- knn(query, iris.data, 10)
##'
##' # classify the instance.
##' prediction <- classifier(top.10$species, top.10$distance)
##'
##' # print the result.
##' print(paste("prediction =", prediction$pred,
##'             "confidence =", prediction$conf))
##' 
##' @export
##' @author phil
classifier <- function(cls, distance) {
  counts <- summary(cls)
  prediction <- which.max(counts)
  list(pred=names(prediction), conf=as.numeric(counts[prediction])/sum(counts))
}
