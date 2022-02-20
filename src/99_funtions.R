# Page_name defines  path and filename from the hostname and the basename 
# (it chops out the path included between the host and the file)
page_name <- function(url, dest = "", filetype = ".html") {
  if (is.character(url)) {
    name <- stringr::str_extract(url, "[^https?://][^/]*")
    filename <- paste0("/",
                       name,
                       "_",
                       basename(url),
                       filetype)
    if (dest == "") { 
      #if the dest param is empty page_name define  path at the project's root
      if (name == basename(url)) {
      path <- paste0(here::here(),
                     basename(url),
                     filetype)
      } 
      else {
        path <- paste0(here::here(),
                       filename)
      } 
      return(path)
    } 
    else if (dest != ""){ 
      #if the dest param is NOT empty the function define 
      #the path to the project's subdirectory as in dest
      if (name == basename(url)) {
        path <- paste0(here::here(dest),
                       "/",
                       basename(url),
                       filetype)
      } 
      else {
        path <- paste0(here::here(dest),
                       filename)
      } 
      return(path)
    }
  } 
  else{
    cat("Not a string!")
   }
}


get_page <- function(url, dest = "", my_email = "", agent = F, filetype = ".html") { 
  # Donwload file from a list of URLs controlling for http status code. 
    stopifnot(is.logical(agent))
    UA <- ifelse(agent == FALSE, "", R.Version()$version.string)
    
    
    i <- 0
    for (i in 1:length(url)) {
      url_step <- url[i]
      httpReq <- httr::GET(url_step,
                     httr::add_headers(
                       From = my_email, 
                       `User-Agent` = UA
                       ))
      code <- httr::status_code(httpReq)
       
      
      # If status code is OK then:
      # download file with the filename and path as in page_name 
      if (code == 200) {
         bin <- httr::content(httpReq,
                        as = "raw")
         writeBin(object = bin,
                  con = page_name(url = url_step, dest, filetype))
      } else if (code == 404) { # If status code is Not Found
        cat("Bad luck. Error ",
            code,
            " Resource not found! :(",
            sep = "")
       } else { # For every other status code report a generic error.
         cat("Error ",
             code,
             ". Check your URL!",
             sep = "")
       }
      
      # Sleep every round!
      Sys.sleep(2) 
    }
}
