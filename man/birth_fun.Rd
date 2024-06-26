% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/birth_fun.R
\name{birth_fun}
\alias{birth_fun}
\title{Function that performs a birth step}
\usage{
birth_fun(k, k_new, a, sig2, x, X, kmax)
}
\arguments{
\item{k}{: int}

\item{k_new}{: int}

\item{a}{vec}

\item{sig2}{: number}

\item{x}{:vector}

\item{X}{: matrix}

\item{kmax}{:int}
}
\value{
a list with updated a and k values
}
\description{
Function that performs a birth step
}
\examples{
x = c(4.8407828, 3.1495432, 1.0391882, -0.5670270, -1.2837761, -0.4528256,
 -1.1621543, -1.8725529, -2.7431505, -3.6796526)
k = 3
k_new = 4 
kmax = 8       
sig2 = 1
a = c(0,0,0,0,0,0,0,0,0,0)
X = matrix(data = c(1.7612631, 2.402950, 1.037612, 2.258141, 0.7919269,
 -0.4510330, -0.1845782, -0.9725866, 0.1359826, 1.761263, 2.402950,
  1.037612, 2.2581412,  0.7919269, -0.4510330, -0.1845782),
   nrow = 2, ncol = 8,byrow = TRUE)
}
