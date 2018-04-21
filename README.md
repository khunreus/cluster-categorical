# Hierarchical clustering on categorical data
Originally done for the purpose of identifying customer groups with distinctive behavior. 
You might find it useful as one of the approaches to analyze survey results with Likert scale (and other types of categorical data).

The process behind the code is described in [this](https://medium.com/@anastasia.reusova/hierarchical-clustering-on-categorical-data-in-r-a27e578f2995) blogpost.

In brief, I followed the process below:

0. generating some dummy customer data;
1. calculating Gower distances for the dissimilarity matrix;
2. having a look at agglomerative and divisive clustering;
3. assessing clusters;
4. visualizing cluster data: suggesting some simple solutions to visualize 6 variables and 7 clusters.

