# nstall.packages("ggdendro")
# install.packages("reshape2")
# install.packages("grid")
# install.packages("dendextend")

library("ggplot2")
library("reshape2")
library("purrr")
library("dplyr")
library("dendextend")

dendro <- as.dendrogram(aggl.clust.c)

dendro.col <- dendro %>%
  set("branches_k_color", k = 7, 
      value = c("darkslategray","darkslategray4","darkslategray3","gold3", "darkcyan", "cyan3", "gold3")) %>%
  set("branches_lwd", 0.6) %>%
  set("labels_colors", 
      value = c("darkslategray")) %>% 
  set("labels_cex", 0.5) 


ggd1 <- as.ggdend(dendro.col)
ggplot(ggd1, theme = theme_minimal()) +
  labs(x = "Num. observations", y = "Height", title = "Dendrogram, k = 7")


# Create a radial plot
ggplot(ggd1, labels = T) + 
  scale_y_reverse(expand = c(0.2, 0)) +
  coord_polar(theta="x")

# cust.order <- order.dendrogram(dendro)
# synthetic.customers.cl.ord <- synthetic.customers.cl[cust.order, ]

# 1 variable per row
# factors have to be converted to characters in order not to be dropped

cust.long <- melt(data.frame(lapply(synthetic.customers.cl, as.character), stringsAsFactors=FALSE), 
                  id = c("id.s", "clust.num"), factorsAsStrings=T)

cust.long.q <- cust.long %>%
  group_by(clust.num, variable, value) %>%
  mutate(count = n_distinct(id.s)) %>%
  distinct(clust.num, variable, value, count)

# in case you want to go for absolute counts - but it doesn't tell much, to my taste  
heatmap.c <- ggplot(cust.long.q, aes(x = clust.num, y = factor(value, levels = c("x","y","z",
                                                                    "mon", "tue", "wed", "thu", "fri","sat","sun",
                                                                    "delicious", "the one you don't like", "pizza",
                                                                    "facebook", "email", "link", "app",
                                                                    "area1", "area2", "area3", "area4",
                                                                    "small", "med", "large"), 
                                                  ordered = T))) +
  geom_tile(aes(fill = count))+
  scale_fill_gradient2(low = "darkslategray1", mid = "yellow", high = "turquoise4")

cust.long.p <- cust.long.q %>%
  group_by(clust.num, variable) %>%
  mutate(perc = count / sum(count)) %>%
  arrange(clust.num)

heatmap.p <- ggplot(cust.long.p, aes(x = clust.num, y = factor(value, levels = c("x","y","z",
                                                                    "mon", "tue", "wed", "thu", "fri","sat","sun",
                                                                    "delicious", "the one you don't like", "pizza",
                                                                    "facebook", "email", "link", "app",
                                                                    "area1", "area2", "area3", "area4",
                                                                    "small", "med", "large"), 
                                                  ordered = T))) +
  geom_tile(aes(fill = perc), alpha = 0.85)+
  labs(title = "Distribution of characteristics across clusters", x = "Cluster number", y = NULL) +
  geom_hline(yintercept = 3.5) + 
  geom_hline(yintercept = 10.5) + 
  geom_hline(yintercept = 13.5) + 
  geom_hline(yintercept = 17.5) + 
  geom_hline(yintercept = 21.5) + 
  scale_fill_gradient2(low = "darkslategray1", mid = "yellow", high = "turquoise4")

heatmap.p
  