# lazyIris
[![Build Status](https://travis-ci.org/phil8192/lazy-iris.svg?branch=master)](https://travis-ci.org/phil8192/lazy-iris) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)

!["iris versicolor"](https://raw.githubusercontent.com/phil8192/lazy-iris/master/versicolor.png "iris versicolor")

K-Nearest neighbours implementation. (Experimenting with R packaging.)

## Installation

```R
# install.packages("devtools")
devtools::install_github("phil8192/lazy-iris")
```

## Documentation

Example use documentation has been created in R Markdown (see vignettes) 
directory. [knitr](https://github.com/yihui/knitr) is used to generate 
vignettes. [roxygen2](https://github.com/klutometis/roxygen) is used to 
generate the pdf manual from code comments.

### Example use of lazyIris package (html) 
http://parasec.net/transmission/lazy-iris/example.html

### Example use (pdf)
http://parasec.net/transmission/lazy-iris/example.pdf

### Manual 
http://parasec.net/transmission/lazy-iris/lazyIris-manual.pdf

## Development notes

### Generating pdf+html vignettes:

```bash
R -e 'rmarkdown::render("lazy-iris/vignettes/example.Rmd","all",output_dir="/tmp")'
```

### Building and checking src
```bash
cd lazy-iris
R -e 'devtools::document()' # roxygen2
cd ..
R CMD build lazy-iris
R CMD check --as-cran lazyIris_0.1.0.tar.gz 
```

