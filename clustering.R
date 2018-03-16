library(cluster) 
# to perform different types of hierarchical clustering
# package functions used: daisy(), diana(), clusplot()
library(fpc)
# clustering and cluster validation
# package functions used: cluster.stats()

# variables for clustering
# chosen after several attemempts as the most variative
col.clean <- c("Origins","hyperhub", "sourced_by", "device_fo",
               "channelled_through", "interface", "ordering.from", 
               "cuisine_fo", "basket_cat", "first_budget", "free_delivery", 
               "daytime", "dow")

# pairwise distances for categorical data
# ?daisy

# Compared to dist() whose input must be numeric variables,
# the main feature of daisy is its ability to handle other variable
# types as well (e.g. nominal, ordinal, (a)symmetric binary) even
# when different types occur in the same data set.
# The handling of nominal, ordinal, and (a)symmetric binary data is achieved
# by using the general dissimilarity coefficient of Gower (1971).

col.clean.dist <- daisy(test.All.clust[ ,col.clean], metric = c("gower"))
#class(col.clean.dist) 
##distance matrix

#------------ DIVISIVE CLUSTERING ------------#
col.clean.divisive.clust <- diana(as.matrix(col.clean.dist), 
                                  diss = TRUE, keep.diss = TRUE)
plot(col.clean.divisive.clust)

# cluster validation stats
calc.cstats <- function(dist, tree, k)  {
  library(fpc)
  clust.metrics <- c("cluster.number","n","cluster.size","average.within","average.between",
                     "wb.ratio","dunn2","avg.silwidth")
  for (i in c(2:k))  {
      print(paste("Stats for ", as.character(i), " clusters: "))
      print(cluster.stats(d = dist, clustering = cutree(tree, k = i))[clust.metrics])
  }
} 
calc.cstats(col.clean.dist, col.clean.divisive.clust, 7)
#k = 4 makes most business sense in frame of the research

#------------ AGGLOMERATIVE CLUSTERING ------------#
col.clean.aggl.clust <- hclust(col.clean.dist, method = "complete")
plot(col.clean.aggl.clust)

calc.cstats(col.clean.dist, col.clean.aggl.clust, 7)


#------------ VISUALISING RESULT ------------#
# Adding cluster number column to the df
divisive.clust.4 <- cutree(col.clean.divisive.clust, k = 4) 
test.All.clust <- cbind(test.All.clust, divisive.clust.4)

clusplot(test.All.clust[ ,col.clean], divisive.clust.4, 
         color=TRUE, shade=TRUE, labels=0, lines=0, 
         main = "Clusters (4), divisive", 
         cex = 0.3)
