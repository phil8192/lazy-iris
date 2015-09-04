##' Euclidean distance metric.
##'
##' Euclidean distance between two vectors.
##'
##' Note: There is also a \code{\link{dist}} function in R with the options for
##' euclidian, maximum, manhatten, canberra, binary and minkowski metrics.
##' 
##' @param v1 Source vector.
##' @param v2 Target vector.
##' @return Euclidean distance.
##' @examples
##' 
##' # (3,4) with (9,12)
##' euclidean(c(3, 4), c(9, 12))
##'
##' # (3,4) with (44,66)
##' euclidean(c(3, 4), c(44, 66))
##'
##' # (3,4) with (9,12) and (44,66)
##' m <- matrix(c(9, 12, 44, 66), ncol=2, byrow=TRUE)
##' apply(m, 1, euclidean, c(3, 4))
##' 
##' @export
##' @author phil
euclidean <- function(v1, v2) sqrt(sum((v1-v2)^2))
