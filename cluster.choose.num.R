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
