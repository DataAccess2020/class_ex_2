mare <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"

email <-  "test@test.com"
UA <-  R.Version()$version.string

site <- RCurl::getURL(mare, 
                      httpheader = c(From = email, `User-Agent` = UA))

site_parsed <- read_html(site)
