install.packages("factoextra")
library(factoextra)

install.packages("pheatmap")
library(pheatmap)

install.packages("ggplotify")
library(ggplotify)

ogdata <- read.csv("week9\\wine.csv")

x <- ogdata$country

data <- scale(ogdata[, 3:6])

row.names(data) <- x

km <- kmeans(data, centers = 3, nstart = 5)

fviz_cluster(km, data = data)


numdata <- ogdata[, 3:6]

normalized_df <- as.data.frame(lapply(numdata, function(x) {
  (x - min(x)) / (max(x) - min(x))
}))

row.names(normalized_df) <- x

hm <- as.ggplot(pheatmap(normalized_df))

hm +
  labs(title = "Heatmap of Wine Data")




