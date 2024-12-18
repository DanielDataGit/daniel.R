install.packages("factoextra")
library(factoextra)

install.packages("pheatmap")
library(pheatmap)

install.packages("ggplotify")
library(ggplotify)


ogdata <- read.csv("week9\\wine.csv")

#prep data for kmeans vis
x <- ogdata$country
data <- scale(ogdata[, 3:6])
row.names(data) <- x

#plot raw data
pairs(data)

#calculate kmeans
km <- kmeans(data, centers = 3, nstart = 5)

#plot cluster vis
fviz_cluster(km, data = data)

#prep data for heatmap
numdata <- ogdata[, 3:6]
normalized_df <- as.data.frame(lapply(numdata, function(x) {
  (x - min(x)) / (max(x) - min(x))
}))
row.names(normalized_df) <- x

#plot clustered heatmap
hm <- as.ggplot(pheatmap(normalized_df))

hm +
  labs(title = "Heatmap of Wine Data")

