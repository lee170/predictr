#' @include predictr.R
NULL

Linear <-
setClass("Linear",
  slots = list(
    name = "character",
    data = "numeric"
  ),
  validity = function(object) {
    if (length(object@name) != 1L)
      return("Name must be a scalar")

    if (any(is.na(object@data)))
      return("Linear can't have missing values")

    TRUE
  }
)

#' Returns a linear object
#'
#' \code{linear} returns an linear object.
#'
#'
#' @param x Name of object
#'
#' @param data vector (defaults to 0)
#'
#' @export
linear <- function(x, data = 0) {
  Linear(name = x, data = as.numeric(data))
}

as.function.Linear <- function(x, ...) {
  name <- x@name
  v <- x@data

  function(df) {
    .subset2(df, name) %*% t(v)
  }
}


#' A method to generate linear objects
#'
#' \code{as.linear_list} returns a list of linear objects.
#'
#' This method converts objects into a list of the linear terms
#' within the (model) object,
#' or an empty list if the supplied object has no corresponding
#' linear terms.
#'
#' @param x Object to be converted
#'
#' @param ... Additional options
#'
#' @export
as.linear_list <- function(x, ...)
  UseMethod("as.linear_list")

