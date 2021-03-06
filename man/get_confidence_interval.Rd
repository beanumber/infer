% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_confidence_interval.R
\name{get_confidence_interval}
\alias{get_confidence_interval}
\alias{get_ci}
\title{Compute confidence interval}
\usage{
get_confidence_interval(x, level = 0.95, type = "percentile",
  point_estimate = NULL)

get_ci(x, level = 0.95, type = "percentile", point_estimate = NULL)
}
\arguments{
\item{x}{Data frame of calculated statistics or containing attributes of
theoretical distribution values. Currently, dependent on statistics being
stored in \code{stat} column as created in \code{\link[=calculate]{calculate()}} function.}

\item{level}{A numerical value between 0 and 1 giving the confidence level.
Default value is 0.95.}

\item{type}{A string giving which method should be used for creating the
confidence interval. The default is \code{"percentile"} with \code{"se"}
corresponding to (multiplier * standard error) as the other option.}

\item{point_estimate}{A numeric value or a 1x1 data frame set to \code{NULL} by
default. Needed to be provided if \code{type = "se"}.}
}
\value{
A 1 x 2 tibble with values corresponding to lower and upper values in
the confidence interval.
}
\description{
Only simulation-based methods are (currently only) supported.
}
\section{Aliases}{

\code{get_ci()} is an alias of \code{get_confidence_interval()}.
\code{conf_int()} is a deprecated alias of \code{get_confidence_interval()}.
}

\examples{
# Prepare the dataset
mtcars_df <- mtcars \%>\%
  dplyr::mutate(am = factor(am))

# Calculate the difference in means in the dataset
d_hat <- mtcars_df \%>\%
  specify(mpg ~ am) \%>\%
  calculate(stat = "diff in means", order = c("1", "0"))

# Same calculation on 100 bootstrap replicates
bootstrap_distn <- mtcars_df \%>\%
  specify(mpg ~ am) \%>\%
  generate(reps = 100, type = "bootstrap") \%>\%
  calculate(stat = "diff in means", order = c("1", "0"))

# Use level to set the confidence level
bootstrap_distn \%>\%
  get_confidence_interval(level = 0.9)

# To calculate std error, set the type and point estimate
bootstrap_distn \%>\%
  get_confidence_interval(type = "se", point_estimate = d_hat)
}
