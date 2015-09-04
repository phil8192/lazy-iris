##' Check the iris data.
##'
##' Performs any necessary data cleaning.
##' 
##' @param iris.data The \code{\link{iris.data}}
##' @return Cleaned \code{\link{iris.data}}
##' @examples
##' 
##' iris.data <- checkData(iris.data)
##'
##' @export
##' @author phil
checkData <- function(iris.data) {

  # clean missing values (could also interpolate).
  if(any(is.na(iris.data))) {
    iris.data <- iris.data[!apply(iris.data, 1, function(v) any(is.na(v))), ]
    warning("removed rows with missing values.")
  }

  # remove duplicates (could also check for conflicting species.
  if(anyDuplicated(iris.data)) {
    iris.data <- unique(iris.data)
    warning("removed duplicated rows.")   
  }

  # remove strange measurements.
  if(any(iris.data[, 1:4] <= 0)) {
    irc.data <- iris.data[!apply(iris.data, 1, function(v) any(v <= 0)), ]
    warning("removed instances with width/length <= 0.") 
  }

  # check for anything odd. (could also check for outliers etc.)
  if(any(iris.data[, 1:4] > 100)) {
    warning("dataset contains gigantic iris plants.") 
  }

  cat("  cleaned data...\n")
  print(summary(iris.data))
    
  iris.data
}
