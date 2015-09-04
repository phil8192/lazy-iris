##' Produce a visualisation of a k-nearest neighbours.
##'
##' Given a query, it's resulting neighbours and the original feature space,
##' this function will plot a visualisation of the position of the query in
##' relation to it's neighbours in the feature space.
##'
##' Colour code:
##' \itemize{
##'   \item{red}{iris setosa}
##'   \item{green}{iris versicolour}
##'   \item{blue}{iris virginica}
##'   \item{black}{query}
##' }
##'
##' The visualisation makes use of R's \code{\link{pairs}} plotting function,
##' more information on which can be viewed in the function's man page:
##' \code{help(pairs)}.
##'
##' @param feature.space The feature space.
##' @param class.name The class name. E.g., \emph{species}.
##' @param query The query (optional).
##' @param neighbours The resulting k-nearest neighbours (optional).
##' @param plot.hist If \code{TRUE} plot a feature distribution histogram.
##' @param plot.cor If \code{TRUE} plot feature correlation.
##' @param ... Additional arguments to \code{\link{pairs}} plotting function.
##' @examples
##'
##' # plot all the data.
##' visualise(iris.data, class.name="species", main="iris data", plot.hist=TRUE,
##'     plot.cor=TRUE)
##'
##' # do not plot the first 2 features and omit the histogram+correlation plots.
##' visualise(iris.data[, -(1:2)], class.name="species", main="iris data")
##'
##' #### visualise k-nearest neighbours.
##'
##' # form a query.
##' q <- list(
##'     sepal.length=5.84,
##'     sepal.width=3.05,
##'     petal.length=3.76,
##'     petal.width=1.20)
##'
##' # get the 10-nearest neighbours
##' top.10 <- knn(q, iris.data, 10)
##'
##' # visualise the neighbours and query point.
##' visualise(iris.data, class.name="species", query=q, neighbours=top.10,
##'     main="iris data neighbours", plot.hist=TRUE, plot.cor=FALSE)
##' 
##' @export
##' @author phil
visualise <- function(feature.space, class.name, query=NULL, neighbours=NULL,
                      plot.hist=F, plot.cor=F, ...) {

  # put histograms on the diagonal. see: help(pairs)  
  panel.hist <- if(plot.hist) function(x, col=NULL, ...) {
    usr <- par("usr"); on.exit(par(usr))
    par(usr=c(usr[1:2], 0, 1.5) )

    # do not include the query in the histogram.
    h <- hist(if(is.null(query)) x else head(x, -1), plot=F)

    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col="grey", ...)

    # indicate the position of the query on this histogram with a vertical,
    # dashed black line. 
    if(!is.null(query)) abline(v=tail(x, 1), col="black", lwd=2, lty=2)

  } else NULL

  # put correlations on lower panels. see: help(pairs)
  panel.cor <- if(plot.cor) function(x, y, digits=2, prefix="", ...) {
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))

    # do not include the query in the correlation.  
    r <- abs(if(is.null(query)) cor(x, y) else cor(head(x, -1), head(y, -1)))

    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste0(prefix, txt)
    cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex=cex.cor*r)
  } else NULL

  # feature names from query or all from feature space.  
  query.names <- if(is.null(query)) {
    q.names <- names(feature.space)
    q.names[q.names != class.name]
  } else names(query)

  # which features match the supplied neighbours.
  matches <- !is.na(match(rownames(feature.space), rownames(neighbours)))
  feature.cols <- unclass(feature.space[, class.name])

  # add the query as an instance to the end of the feature space so it is
  # included in the plots.  
  features <- feature.space[query.names]
  if(!is.null(query)) {
    features <- rbind(features, query)
    feature.cols <- c(feature.cols, 4)
    matches <- c(matches, T)  
  }

  # colours
  # red   = Iris-setosa
  # green = Iris-versicolor
  # blue  = Iris-virginica
  # black = query
  class.colours <- c("red", "green3", "blue", "black")    
    
  # plot
  pairs(x=features,
      pch=ifelse(matches, 21, 1),
      cex=ifelse(matches, 2, 1),
      bg=class.colours[feature.cols],
      col=class.colours[ifelse(matches, 4, feature.cols)],
      lower.panel=panel.cor,
      diag.panel=panel.hist,
      ...)
}
