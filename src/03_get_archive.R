css <- ".td_module_10"
css2 <- ".entry-title.td-module-title a"

i <- 1
archive <- "https://beppegrillo.it/category/archivio/2016/page/"
my_email <- "francesco.catalfamo@studenti.unimi.it"


link_list <- vector()  
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


#Download all 2016 post in a polite way and alongside scrape the text from the page 
get_page(url = link_list, 
         dest = "data",
         my_email = my_email,
         agent = T,
         scrapeText = T) 