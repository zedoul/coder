\name{Bind NULL list into data frame}
\alias{01_rbindnull}
\title{Use}
\description{
Add NULL row into data frame
}
\usage{
rbindnull(list_obj)
}
\arguments{
\item{list_obj}{\code{list}}
}
\value{
Output should be valid data frame without any error or warning
}
\examples{
# Test case 1/1:
# It should return "Hello, World!"
list_obj <- list(a = NULL)
helloworld(list_obj)
}
