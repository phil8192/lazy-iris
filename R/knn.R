##' K-Nearest-Neighbors.
##'
##' Implementation of the
##' \href{https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm}{k-NN}
##' method.
##' 
##' @param query A list of labeled parameters to query for.
##' @param feature.space The feature space to query against.
##' @param k The \emph{k} nearest neighbours to return. Default: 1.
##' @param d.fun The distance function to use. Default: \code{\link{euclidean}}.
##' @return The top \emph{k} nearest neighours in the feature space with respect
##'     to the query.
##' @examples
##'
##' # form the query instance.
##' query <- list(
##'     sepal.length=5.84,
##'     sepal.width=3.05,
##'     petal.length=3.76,
##'     petal.width=1.20)
##'
##' # obtain the nearest-neighbour
##' top.1 <- knn(query, iris.data, 1)
##' print(top.1, row.names=FALSE)
##' 
##' @export
##' @author phil
knn <- function(query, feature.space, k=1, d.fun=euclidean) {
  query <- unlist(query)
  feature.names <- names(query)
  stopifnot(all(feature.names %in% names(feature.space)))
  stopifnot(k >= 1)
  d <- apply(feature.space[, feature.names, drop=F], 1, d.fun, query)
  d.order.asc <- head(order(d), k)
  cbind(feature.space[d.order.asc, ], distance=d[d.order.asc])
}
