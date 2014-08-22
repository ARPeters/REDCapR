##' @name redcap_project
##' @export redcap_project
##' @exportClass redcap_project
##' 
##' @title A \code{Reference Class} to make later calls to REDCap more convenient.
##' 
##' @docType class
##' 
##' @description This \code{Reference Class} represents a REDCap project. 
##' Once some values are set that are specific to a REDCap project (such as the URI and token), 
##' later calls are less verbose (such as reading and writing data).  The functionality 
##' 
##' @field redcap_uri The URI (uniform resource identifier) of the REDCap project.  Required.
##' @field token token The user-specific string that serves as the password for a project.  Required.
##' 
##' @examples
##' library(REDCapR) #Load the package into the current R session.
##' uri <- "https://bbmc.ouhsc.edu/redcap/api/"
##' token <- "9A81268476645C4E5F03428B8AC3AA7B"
##' project <- redcap_project$new(redcap_uri=uri, token=token)
##' dsAll <- project$read()
##' 
##' #Demonstrate how repeated calls are more concise when the token and url aren't always passed.
##' dsThreeColumns <- project$read(fields=c("record_id", "sex", "age"))$data
##' 
##' idsOfMales <- dsThreeColumns[dsThreeColumns$sex==1, "record_id"]
##' idsOfMinors <- dsThreeColumns[dsThreeColumns$age < 18, "record_id"]
##' 
##' dsMales <- project$read(records=idsOfMales, batch_size=2)$data
##' dsMinors <- project$read(records=idsOfMinors)$data

redcap_project <- setRefClass(
  Class = "redcap_project",
  
  fields = list(
    redcap_uri = "character",
    token = "character"
    # batch_size_default 
  ),
  
  methods = list(
    
    read = function( 
      batch_size = 100L, interbatch_delay = 0,
      records = NULL, records_collapsed = NULL, 
      fields = NULL, fields_collapsed = NULL, 
      export_data_access_groups = FALSE,
      raw_or_label = 'raw',
      verbose = TRUE, cert_location = NULL) {
      
      "Reads records in a REDCap project."
      
      return( REDCapR::redcap_read( 
        batch_size = batch_size, interbatch_delay = interbatch_delay,
        redcap_uri = redcap_uri, token = token, 
        records = records, records_collapsed = records_collapsed, 
        fields = fields, fields_collapsed = fields_collapsed, 
        export_data_access_groups = export_data_access_groups,
        raw_or_label = raw_or_label,
        verbose = verbose, cert_location=cert_location 
      ))
      
    }
  )
)
# http://adv-r.had.co.nz/OO-essentials.html

# http://stackoverflow.com/questions/21875596/mapping-a-c-sharp-class-definition-to-an-r-reference-class-definition

# REDCapR::redcap_project$new()
# # library(REDCapR) #Load the package into the current R session.
# uri <- "https://bbmc.ouhsc.edu/redcap/api/"
# token <- "9A81268476645C4E5F03428B8AC3AA7B"
# 
# # uri <- "https://redcap.vanderbilt.edu/api/"
# # token <- "8E66DB6844D58E990075AFB51658A002"
# 
# require(RCurl)
# cert_location <- file.path(devtools::inst("REDCapR"), "ssl_certs", "mozilla_2014_04_22.crt")
# curl_options <- RCurl::curlOptions(cainfo = cert_location)
# # tt <- RCurl::getURL(url=uri, .opts=curl_options)
# # tt
# 
# project <- redcap_project$new(redcap_uri=uri, token=token)
# dsThreeColumns <- project$read(fields=c("record_id", "sex", "age"))$data
# 
# idsOfMales <- dsThreeColumns[dsThreeColumns$sex==1, "record_id"]
# idsOfMinors <- dsThreeColumns[dsThreeColumns$age < 18, "record_id"]
# 
# dsMales <- project$read(records=idsOfMales, batch_size=2)$data
# dsMinors <- project$read(records=idsOfMinors)$data