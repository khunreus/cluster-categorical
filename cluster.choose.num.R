# --------- Choosing the number of clusters ---------#

# Using "Elbow" and "Silhouette" methods to identify the best number of clusters

library(ggplot2)

# Elbow
# Divisive clustering
ggplot(data = data.frame(t(stats.df.divisive)), aes(x=cluster.number, y=within.cluster.ss)) + geom_point()+
  geom_line()+
  ggtitle("Divisive clustering") +
  labs(x = "Num.of clusters", y = "Within clusters sum of squares (SS)") +
  theme(plot.title = element_text(hjust = 0.5))


# Agglomerative clustering,provides a more ambiguous picture
ggplot(data = data.frame(t(stats.df.aggl)), aes(x=cluster.number, y=within.cluster.ss)) + geom_point()+
  geom_line()+
  ggtitle("Agglomerative clustering") +
  labs(x = "Num.of clusters", y = "Within clusters sum of squares (SS)") +
  theme(plot.title = element_text(hjust = 0.5))


# Silhouette
ggplot(data = data.frame(t(stats.df.divisive)), aes(x=cluster.number, y=avg.silwidth)) + geom_point()+
  geom_line()+
  ggtitle("Divisive clustering") +
  labs(x = "Num.of clusters", y = "Average silhouette width") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = data.frame(t(stats.df.aggl)), aes(x=cluster.number, y=avg.silwidth)) + geom_point()+
  geom_line()+
  ggtitle("Agglomerative clustering") +
  labs(x = "Num.of clusters", y = "Average silhouette width") +
  theme(plot.title = element_text(hjust = 0.5))


# Extending the silhouette plot, so we can see the graphs in perspective
ggplot(data = data.frame(t(cstats.table(gower.dist, aggl.clust.c, 30))), aes(x=cluster.number, y=avg.silwidth)) + geom_point()+
  geom_line()+
  ggtitle("Agglomerative clustering, k = 30") +
  labs(x = "Num.of clusters", y = "Average silhouette width") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = data.frame(t(cstats.table(gower.dist, divisive.clust, 30))), aes(x=cluster.number, y=avg.silwidth)) + geom_point()+
  geom_line()+
  ggtitle("Agglomerative clustering, k = 30") +
  labs(x = "Num.of clusters", y = "Divisive silhouette width, k = 30") +
  theme(plot.title = element_text(hjust = 0.5))

# Finally, assigning the cluster number to the observation

clust.num <- cutree(aggl.clust.c, k = 7) 
synthetic.customers.cl <- cbind(synthetic.customers, clust.num)

clusplot(synthetic.customers.cl[ ,2:7], clust.num, 
         color=TRUE, shade=TRUE, labels=0, lines=0, 
         main = "Customer clusters (k=7)", 
         cex = 0.3)
