# Variables preparation ---------------------------------------------------

mare <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"
email <-  "test@test.com"
UA <-  R.Version()$version.string

# Links scraping on the target page ---------------------------------------

#download site with specified headers
site <- RCurl::getURL(mare, 
                      httpheader = c(From = email, `User-Agent` = UA))

#extraction of all link in the webpage
extract_links  <- read_html(site) %>% 
  html_elements(xpath = "//a/@href") %>% 
  html_text()

#creating empty df_links
df_links <- tibble(
  link = ""
)

#for loop appending the chr vector of links to the df
for (i in 1:length(extract_links)) {
  df_links <- rbind(df_links, extract_links[i])
}
df_links <- df_links %>% 
  transmute(link = str_extract(df_links$link, pattern = "^https?://beppegrillo.it/.*")) %>% 
  filter(!is.na(link))

# Extra! Download all the links pointing to beppegrillo.it blog -----------

#preparing vector for get_page loop
url_links <- as.vector(df_links$link)

#getting all pages!
get_page(url = url_links,
         dest = "data",
         my_email = "nicola.casarin@studenti.unimi.it",
         agent = T,
         filetype = ".html")
