#Now to perform clustering

#First, load the data
to_cluster <- read_csv("data/data_clean.csv")

# Set the seed to ensure replicable results
set.seed(12345)

#Now we plot the data to see how it looks
#Below I have used log-normalized values to aid in comparisons between species, because the values range quite a lot between taxa
pre_cluster <- to_cluster %>% 
  ggplot(aes(x = log(Tarsometatarsus), y = log(Humerus), color = Order, size = Extinct, shape = Flightless)) + 
  geom_point(alpha = 0.3) + theme_bw() +
  ggtitle("Distribution of Avian Log-Normalized Humerus and Tarsometatarsus Measurements")
pre_cluster

#As shown in the plot above, extinct birds to not necessarily cluster, neither do flightless birds, in bone measurements. But Orders seem to. 
#Now I will perform k-means clustering, varying the amount of k to minimize the total within sum of squares, or the variance within clusters.
#I will select the k-value based on the smallest amount of k with an effect on total within sum of squares.

#Make a data frame with only the values of interest
cluster <- to_cluster %>%
  select(Humerus, (Tarsometatarsus)) %>%
  mutate(Humerus = log(Humerus), Tarsometatarsus = log(Tarsometatarsus))

#Perform k-means clustering, using k-values from 1 to 10, and seeing which is the most informative
kclusts <- 
  tibble(k = 1:10) %>%
  mutate(
    kclust = map(k, ~kmeans(cluster, centers = .x)),
    per_cluster = map(kclust, broom::tidy),
    total_sum = map(kclust, broom::glance),
    per_point = map(kclust, broom::augment, cluster)
  )

# Now we separate different sets of the data based on how we use it

#Here we take data on each point on the clusters, to plot all the points in their clusters
per_point_df <-
  kclusts %>%
  unnest(cols = c(per_point)) %>%
  rename(cluster = .cluster)

#Here we take the cluster data itself, to see the coordinates of the cluster centers when we plot it
per_cluster_df <- 
  kclusts %>%
  unnest(cols = c(per_cluster))

#Here we get the kmeans summary for each value k; the statistics of the data
total_sum_df <-
  kclusts %>%
  unnest(cols = c(total_sum))

#The clustered plot
clustering_plot <-
  per_point_df %>%
  ggplot(aes(x = Tarsometatarsus, y = Humerus)) + geom_point(aes(color = cluster)) + facet_wrap(~k, nrow = 2) + theme_bw() + xlab("Log-Normalized Tarsometatarsus Measurements") + ylab("Log-Normalized Humerus Measurements")
clustering_plot

#The clustered plot with the k centers marked
clustering_plot_centered <-
  clustering_plot + geom_point(data = per_cluster_df, size = 5, shape = "o") + ggtitle("Data Clustering for Every Value of k")
clustering_plot_centered

#The Total Within Sum of Squares value for each value k. The red line marks where increasing k stops significantly decreasing tot.withinss.
tots_plot <- total_sum_df %>%
  ggplot(aes(x = k, y = tot.withinss)) + geom_point() + geom_line() + theme_bw() + geom_vline(xintercept = 7, color = "red") +
  ggtitle("Total within Sum of Squares Minimization by Increasing k")

#We have shown that 7 clusters has the most value of minimization
final_df <-
  to_cluster %>%
  mutate(Tarsometatarsus = log(Tarsometatarsus), Humerus = log(Humerus)) %>%
  full_join(per_point_df)

final_plot <- 
  final_df %>%
  filter(k == 7) %>%
  ggplot(aes(x = Tarsometatarsus, y = Humerus)) + geom_point(aes(color = Order, shape = Flightless, size = Extinct, alpha = 0.3)) + theme_bw() +
  stat_ellipse(aes(linetype = cluster), segments = 10) +
  xlab("Log-Normalized Tarsometatarsus Measurements") + ylab("Log-Normalized Humerus Measurements") +
  geom_text(data = filter(per_cluster_df, k ==7), label = 1:7, size = 5) + 
  ggtitle("Clustering Avian Bone Measurements with k of 7")
final_plot

ggsave(filename = "outputs/pre_cluster_plot.png", plot = pre_cluster, device ="png", scale = 4, units = "px", width = 1000, height = 648)
ggsave(filename = "outputs/centered_clusters.png", plot = clustering_plot_centered, device = "png", scale = 4, units = "px", width = 1000, height = 648)
ggsave(filename = "outputs/tot.withinss_minimization.png", plot = tots_plot, device = "png", scale = 4, units = "px", width = 1000, height = 648)
ggsave(filename = "outputs/final_clustered_plot.png", plot = final_plot, device = "png", scale = 4, units = "px", width = 1000, height = 648)