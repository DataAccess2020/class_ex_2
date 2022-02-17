page_name <- function(url, dest = "") {  #funtion for defining the path and filename from the hostname and the basename (it chops out the path included between the host and the file)
  if (is.character(url)) { 
    if (dest == "") { # if the dest param is empty the function define the path at the project's root
      path <- paste0(here(),
                     "/",
                     str_extract(url, "[^https?://][^/]*"),
                     "_",
                     basename(url))
      return(path)
    } else{ # if the dest param is NOT empty the function define the path to the project's subdirectory as in dest
      path <- paste0(here(dest),
                     "/",
                     str_extract(url, "[^https?://][^/]*"),
                     "_",
                     basename(url))
      return(path)
    }
  } else{
    cat("Not a string!")
   }
}

get_page <- function(url, dest = "", my_email = "", agent = F) { #function for donwload file from a list of URLs checking the http requesto status code. 
    stopifnot(is.logical(agent))
    UA <- ifelse(agent == FALSE, "", R.Version()$version.string)
    
    i <- 0
    for (i in 1:length(url)) {
      url_step <- url[i]
      httpReq <- GET(url_step,
                     add_headers(
                       From = my_email, 
                       `User-Agent` = UA
                       ))
      code <- status_code(httpReq)
       if (code == 200) { #if status code is OK 
         # download the file with the filename and path defined with page_name() funtion 
         bin <- content(httpReq,
                        as = "raw")
         writeBin(object = bin,
                  con = page_name(url = url_step, dest))
      } else if (code == 404) { #if status code is Not Found
        cat("Bad luck. Error ",
            code,
            " Resource not found! :(",
            sep = "")
       } else { #for every other status code report a generic error.
         cat("Error ",
             code,
             ". Check your URL!",
             sep = "")
       }
      Sys.sleep(2) #since the function can take list of URLs, sleep every index change for politeness
    }
}
