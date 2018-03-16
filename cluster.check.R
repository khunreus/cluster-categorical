#checking summary by columns - when calling summary on df, some of the columns will not be fully displayed

check.summary <- function(df, clust.col, clust.n, x) {
  column <- df[clust.col == clust.n, x]
  summary(column)
}
check.summary(df = test.All.clust, clust.col = divisive.clust.4, clust.n = 4, x = "basket_cat")