css <- ".td_module_10"
css2 <- ".entry-title.td-module-title a"

i <- 1
archive <- "https://beppegrillo.it/category/archivio/2016/page/"
my_email <- "francesco.catalfamo@studenti.unimi.it"


link_list <- ""
for (i in 1:47) {
  step <- paste0(archive, i)
  page <- httr::GET(url = step, 
            add_headers(
              From = my_email, 
              `User-Agent` = R.Version()$version.string
            ))
 links <-  content(page) %>%
    html_elements(css) %>%
    html_elements(css2) %>%
    html_attr(name = "href") 
 link_list <- append(x = link_list, values = links)
 Sys.sleep(2)
}

