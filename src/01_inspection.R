#Inspect and download the robots.txt of the page

grillo <- 'https://beppegrillo.it/robots.txt'

get_page(grillo, 
         dest = "data", 
         my_email = "test@test.com",
         agent = T)