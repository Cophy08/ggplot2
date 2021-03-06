#' Position scale, date & date times
#'
#' Use \code{scale_*_date} with \code{Date} variables, and
#' \code{scale_*_datetime} with \code{POSIXct} variables.
#'
#' @name scale_date
#' @inheritParams continuous_scale
#' @param date_breaks A string giving the distance between breaks like "2
#'   weeks", or "10 years". If both \code{breaks} and \code{date_breaks} are
#'   specified, \code{date_breaks} wins.
#' @param date_minor_breaks A string giving the distance between minor breaks
#'   like "2 weeks", or "10 years". If both \code{minor_breaks} and
#'   \code{date_minor_breaks} are specified, \code{date_minor_breaks} wins.
#' @param date_labels A string giving the formatting specification for the
#'   labels. Codes are defined in \code{\link{strftime}}. If both \code{labels}
#'   and \code{date_labels} are specified, \code{date_labels} wins.
#' @seealso \code{\link{scale_continuous}} for continuous position scales.
#' @examples
#' last_month <- Sys.Date() - 0:29
#' df <- data.frame(
#'   date = last_month,
#'   price = runif(30)
#' )
#' base <- ggplot(df, aes(date, price)) +
#'   geom_line()
#'
#' # The date scale will attempt to pick sensible defaults for
#' # major and minor tick marks. Override with date_breaks, date_labels
#' # date_minor_breaks arguments.
#' base + scale_x_date(date_labels = "%b %d")
#' base + scale_x_date(date_breaks = "1 week", date_labels = "%W")
#' base + scale_x_date(date_minor_breaks = "1 day")
#'
#' # Set limits
#' base + scale_x_date(limits = c(Sys.Date() - 7, NA))
NULL

#' @rdname scale_date
#' @export
scale_x_date <- function(name = waiver(),
                         breaks = waiver(), date_breaks = waiver(),
                         labels = waiver(), date_labels = waiver(),
                         minor_breaks = waiver(), date_minor_breaks = waiver(),
                         limits = NULL, expand = waiver()) {

  scale_datetime(c("x", "xmin", "xmax", "xend"), "date",
    name = name,
    breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels,
    minor_breaks = minor_breaks, date_minor_breaks = date_minor_breaks,
    limits = limits, expand = expand
  )
}

#' @rdname scale_date
#' @export
scale_y_date <- function(name = waiver(),
                         breaks = waiver(), date_breaks = waiver(),
                         labels = waiver(), date_labels = waiver(),
                         minor_breaks = waiver(), date_minor_breaks = waiver(),
                         limits = NULL, expand = waiver()) {

  scale_datetime(c("y", "ymin", "ymax", "yend"), "date",
    name = name,
    breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels,
    minor_breaks = minor_breaks, date_minor_breaks = date_minor_breaks,
    limits = limits, expand = expand
  )
}


#' @export
#' @rdname scale_date
scale_x_datetime <- function(name = waiver(),
                             breaks = waiver(), date_breaks = waiver(),
                             labels = waiver(), date_labels = waiver(),
                             minor_breaks = waiver(), date_minor_breaks = waiver(),
                             limits = NULL, expand = waiver()) {

  scale_datetime(c("x", "xmin", "xmax", "xend"), "time",
    name = name,
    breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels,
    minor_breaks = minor_breaks, date_minor_breaks = date_minor_breaks,
    limits = limits, expand = expand
  )
}


#' @rdname scale_date
#' @export
scale_y_datetime <- function(name = waiver(),
                             breaks = waiver(), date_breaks = waiver(),
                             labels = waiver(), date_labels = waiver(),
                             minor_breaks = waiver(), date_minor_breaks = waiver(),
                             limits = NULL, expand = waiver()) {

  scale_datetime(c("y", "ymin", "ymax", "yend"), "time",
    name = name,
    breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels,
    minor_breaks = minor_breaks, date_minor_breaks = date_minor_breaks,
    limits = limits, expand = expand
  )
}

scale_datetime <- function(aesthetics, trans,
                           breaks = pretty_breaks(), minor_breaks = waiver(),
                           labels = waiver(), date_breaks = waiver(),
                           date_labels = waiver(),
                           date_minor_breaks = waiver(),
                           ...) {

  name <- switch(trans, date = "date", time = "datetime")

  # Backward compatibility
  if (is.character(breaks)) breaks <- date_breaks(breaks)
  if (is.character(minor_breaks)) minor_breaks <- date_breaks(minor_breaks)

  if (!is.waive(date_breaks)) {
    breaks <- date_breaks(date_breaks)
  }
  if (!is.waive(date_minor_breaks)) {
    minor_breaks <- date_breaks(date_minor_breaks)
  }
  if (!is.waive(date_labels)) {
    labels <- date_format(date_labels)
  }

  continuous_scale(aesthetics, name, identity,
    breaks = breaks, minor_breaks = minor_breaks, labels = labels,
    guide = "none", trans = trans, ...)
}

#' @export
scale_map.datetime <- function(scale, x, limits = scale_limits(scale)) {
  scale$oob(x, limits)
}

#' @export
scale_map.date <- function(scale, x, limits = scale_limits(scale)) {
  scale$oob(x, limits)
}

