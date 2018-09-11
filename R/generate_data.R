products <- c('Nintendo Switch', 'Playstation 4', 'Xbox One')
prices <- c(300, 400, 370)

stores <- sprintf('Store %s', 1:10)

n_sales <- rpois(1, 100)
product_index <- sample(1:3, n_sales, replace = TRUE)
product <- products[product_index]
price <- prices[product_index]
quantity <- rpois(n_sales, 1) + 1
amount <- quantity*price

sales <- data.frame(
  product,
  price,
  quantity,
  amount
)

