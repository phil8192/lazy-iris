##' Load data.
##'
##' Loads the iris csv data from the inst/extdata directory.
##' 
##' @return Iris data as documented in \code{\link{iris.data}}
##' @examples
##' 
##' iris.data <- loadData()
##'
##' @export
##' @author phil
loadData <- function() {
  x <- c("sepal.length", "sepal.width", "petal.length", "petal.width", "species")
  csv.file <- system.file("extdata", "iris.csv", package="lazyIris")
  read.csv(csv.file, header=F, col.names=x)
}
