PRODUCTS <- c('Nintendo Switch', 'Playstation 4', 'Xbox One')
PRICES <- c(300, 400, 370)
SALES_AVERAGE <- 100

STORES <- sprintf('Store %02d', 1:10)

generate_data <- function(store, save = FALSE) {
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
  
  folder_path <- file.path('data', 'simple_data')
  store_path <- file.path(folder_path, sprintf('%s.csv', store))
  
  if(save) {
    if(dir.exists(store_path)) {
      unlink(store_path)
    }
    write.csv(sales, store_path, row.names = FALSE, na = '')
  }
  
  return(sales)
}

sales_list <- lapply(STORES, generate_data, save = TRUE)
