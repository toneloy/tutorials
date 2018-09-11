PRODUCTS <- c('Nintendo Switch', 'Playstation 4', 'Xbox One')
PRICES <- c(300, 400, 370)
SALES_AVERAGE <- 100
DATES <- sprintf('2018-%02d-01', 1:12)
STORES <- sprintf('Store %02d', 1:10)

FOLDER_PATH <- file.path('data', 'complex_data')


generate_data <- function(date, store, save = FALSE) {
  n_products <- length(PRODUCTS)
  
  n_sales <- rpois(1, SALES_AVERAGE)
  product_index <- sample(1:n_products, n_sales, replace = TRUE)
  product <- PRODUCTS[product_index]
  price <- PRICES[product_index]
  quantity <- rpois(n_sales, 1)
  quantity <- ifelse(quantity == 0, 1, quantity)
  
  amount <- quantity*price
  
  sales <- data.frame(
    product,
    price,
    quantity,
    amount
  )
  
  
  store_path <- file.path(FOLDER_PATH, store)
  file_path = file.path(store_path, sprintf('%s.csv', date))
  
  if(save) {
    if(dir.exists(file_path)) {
      unlink(file_path)
    }
    write.csv(sales, file_path, row.names = FALSE, na = '')
  }
  
  return(sales)
}


generate_stores <- function(store, save = FALSE) {
  store_path <- file.path(FOLDER_PATH, store)
  
  if(save) {
    if(dir.exists(store_path)) {
      unlink(store_path, recursive = TRUE, force = TRUE)
    }
    dir.create(store_path)
    
    data_list <- lapply(DATES, generate_data, store = store, save = save)
  }
}



sales_list <- lapply(STORES, generate_stores, save = TRUE)
