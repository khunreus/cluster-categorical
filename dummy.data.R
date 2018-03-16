library(dplyr)
set.seed(40)

# generating random variable set
# specifying ordered factors, strings will be converted to factors when using data.frame()

id.s <- c(1:200) %>%
        factor()

budget.s <- sample(c("small", "med", "large"), 200, replace = T) %>%
            factor(levels=c("small", "med", "large"), ordered = TRUE)
origins.s <- sample(c("x", "y", "z"), 200, replace = T, 
                    prob = c(0.7, 0.15, 0.15))
area.s <- sample(c("area1", "area2", "area3", "area4"), 200, replace = T,
                 prob = c(0.3, 0.1, 0.5, 0.2))
source.s <- sample(c("facebook", "email", "link", "app"), 200, replace = T,
                  prob = c(0.1,0.2, 0.3, 0.4))
dow.s <- sample(c("mon", "tue", "wed", "thu", "fri", "sat", "sun"), 200, replace = T,
                prob = c(0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2)) %>%
            factor(levels=c("mon", "tue", "wed", "thu", "fri", "sat", "sun"), ordered = TRUE)
dish.s <- sample(c("delicious", "the one you don't like", "pizza"), 200, replace = T)
            
# by default, data.frame() will convert all the strings to factors
synthetic.customers <- data.frame(id.s, budget.s, origins.s, area.s, source.s, dow.s, dish.s)

str(synthetic.customers)

