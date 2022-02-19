mare <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"

email <-  "test@test.com"
UA <-  R.Version()$version.string

site <- RCurl::getURL(mare, 
                      httpheader = c(From = email, `User-Agent` = UA))

site_parsed <- read_html(site)

extract_links <-  read_html(site) %>%
  html_elements(xpath = "//a/@href") %>%
  html_text()

df_links <-  tibble(
  link = ""
)

for(i in 1:length(extract_links)) {
  df_links <-  rbind(df_links, extract_links[i])
}

