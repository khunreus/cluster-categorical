#----- Dissimilarity Matrix -----#
library(cluster) 
# to perform different types of hierarchical clustering
# package functions used: daisy(), diana(), clusplot()
gower.dist <- daisy(synthetic.customers[ ,2:7], metric = c("gower"))
# class(gower.dist) 
## dissimilarity , dist

#------------ DIVISIVE CLUSTERING ------------#
divisive.clust <- diana(as.matrix(gower.dist), 
                                  diss = TRUE, keep.diss = TRUE)
plot(divisive.clust,
     main = "Divisive")

# cluster validation stats
calc.cstats <- function(dist, tree, k)  {
  library(fpc)
  clust.metrics <- c("cluster.number","n","cluster.size","average.within","average.between",
                     "wb.ratio","dunn2","avg.silwidth")
  length(clust.metrics)
  
  for (i in c(2:k))  {
    print(paste("Stats for ", as.character(i), " clusters: "))
    print(cluster.stats(d = dist, clustering = cutree(tree, k = i))[clust.metrics])
  }
} 

calc.cstats(gower.dist, divisive.clust, 5)

#------------ AGGLOMERATIVE CLUSTERING ------------#
# I am looking for the most balanced approach
# Complete linkages is the approach that best fits this demand 

# complete
aggl.clust.c <- hclust(gower.dist, method = "complete")
plot(aggl.clust.c,
     main = "Agglomerative, complete linkages")

calc.cstats(gower.dist, aggl.clust.c, 5)

#average
aggl.clust.a <- hclust(gower.dist, method = "average")
plot(aggl.clust.a,
     main = "Agglomerative, average linkages")

#single
aggl.clust.s <- hclust(gower.dist, method = "single")
plot(aggl.clust.s,
     main = "Agglomerative, single linkages")

#centroid
aggl.clust.ce <- hclust(gower.dist, method = "centroid")
plot(aggl.clust.ce,
     main = "Agglomerative, centroid")

#centroid
aggl.clust.m <- hclust(gower.dist, method = "median")
plot(aggl.clust.m,
     main = "Agglomerative, median")
