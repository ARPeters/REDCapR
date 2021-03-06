% Generated by roxygen2 (4.0.2): do not edit by hand
\name{redcap_write}
\alias{redcap_write}
\title{Write/Import records to a REDCap project.}
\usage{
redcap_write(ds_to_write, batch_size = 100L, interbatch_delay = 0.5,
  redcap_uri, token, verbose = TRUE, cert_location = NULL)
}
\arguments{
  \item{ds_to_write}{The \code{data.frame} to be imported
  into the REDCap project.  Required.}

  \item{batch_size}{The maximum number of subject records a
  single batch should contain.  The default is 100.}

  \item{interbatch_delay}{The number of seconds the
  function will wait before requesting a new subset from
  REDCap. The default is 0.5 seconds.}

  \item{redcap_uri}{The URI (uniform resource identifier)
  of the REDCap project.  Required.}

  \item{token}{The user-specific string that serves as the
  password for a project.  Required.}

  \item{verbose}{A boolean value indicating if
  \code{message}s should be printed to the R console during
  the operation.  Optional.}

  \item{cert_location}{If present, this string should point
  to the location of the cert files required for SSL
  verification.  If the value is missing or NULL, the
  server's identity will be verified using a recent CA
  bundle from the \href{http://curl.haxx.se}{cURL website}.
  See the details below. Optional.}
}
\value{
Currently, a list is returned with the following elements,
\enumerate{ \item \code{success}: A boolean value
indicating if the operation was apparently successful.
\item \code{status_code}: The
\href{http://en.wikipedia.org/wiki/List_of_HTTP_status_codes}{http
status code} of the operation.  \item
\code{outcome_message}: A human readable string indicating
the operation's outcome.  \item
\code{records_affected_count}: The number of records
inserted or updated.  \item \code{affected_ids}: The
subject IDs of the inserted or updated records.  \item
\code{elapsed_seconds}: The duration of the function. }
}
\description{
This function uses REDCap's
\href{https://iwg.devguard.com/trac/redcap/wiki/ApiExamples}{API}
to select and return data.
}
\details{
The `REDCapR' package includes a recent version of the
\href{http://curl.haxx.se/ca/cacert.pem}{Bundle of CA Root
Certificates} from the official
\href{http://curl.haxx.se}{cURL site}.  This version is
used by default, unless the `cert_location` parameter is
given another location.

Currently, the function doesn't modify any variable types
to conform to REDCap's supported variables.  See
\code{\link{validate_for_write}} for a helper function that
checks for some common important conflicts.
}
\author{
Will Beasley
}
\references{
The official documentation can be found on the `API
Examples' page on the REDCap wiki
(\url{https://iwg.devguard.com/trac/redcap/wiki/ApiExamples}).
A user account is required.

The official \href{http://curl.haxx.se}{cURL site}
discusses the process of using SSL to verify the server
being connected to.
}

