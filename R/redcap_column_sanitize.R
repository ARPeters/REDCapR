#' @name redcap_column_sanitize
#' @export redcap_column_sanitize
#' @title Sanitize to adhere to REDCap character encoding requirements.
#'  
#' @description Replace non-ASCII characters with legal characters that won't cause problems when writing to a REDCap project.
#' 
#' @param d The \code{data.frame} containing the dataset used to update the REDCap project.  Required.
#' @param column_names An array of \code{character} values indicating the names of the variables to sanitize.  Optional.
#' @param encoding_initial An array of \code{character} values indicating the names of the variables to sanitize.  Optional.
#' @param substitution_character The \code{character} value that replaces characters that were unable to be appropriatedly matched.
#' @return A \code{data.frame} with same columns, but whose character values have been sanitized.
#' @details 
#' Letters like an accented `A' are replaced with a plain `A'.  
#' 
#' This is a thin wrapper around \href{https://stat.ethz.ch/R-manual/R-devel/library/base/html/iconv.html}{\code{base::iconv()}}.
#' The \code{ASCII//TRANSLIT} option does the actual transliteration work.  As of \code{R 3.1.0}, the OSes use similar,
#' but different, versions to convert the characters.  Be aware of this in case you notice slight OS-dependent differences.
#'  
#' @author Will Beasley
#' 
#' @examples
#' # Examples are not shown because they require non-ASCII encoding, 
#' #   which makes the package documentation less portable.

redcap_column_sanitize <- function( 
  d, 
  column_names = colnames(d), 
  encoding_initial = "latin1", 
  substitution_character = "?" ) {

  for( column in column_names ) {
    d[, column] <- base::iconv(x = d[, column], 
                               from = encoding_initial, 
                               to = "ASCII//TRANSLIT", 
                               sub = substitution_character)
  }  
  return( d )
}
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/iconv.html

