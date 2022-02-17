page_name <- function(url, dest = "") {
  if (is.character(url)) {
    if (dest == "") {
      path <- paste0(here(),
                     "/",
                     str_extract(url, "[^https?://][^/]*"),
                     "_",
                     basename(url))
      return(path)
    } else{
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

get_page <- function(url, dest = "") {
    i <- 0
    for (i in 1:length(url)) {
      url_step <- url[i]
      httpReq <- GET(url_step)
      code <- status_code(httpReq)
       if (code == 200) {
         download.file(url = url_step,
                       destfile = page_name(url_step,
                                            dest))
      } else if (code == 404) {
        cat("Bad luck. Error ",
            code,
            " Resource not avaible :(",
            sep = "")
       } else {
         cat("Error ",
             code,
             ". Check your URL!",
             sep = "")
       }
      Sys.sleep(2)
    }
}
