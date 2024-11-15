  
  library(tm)        
  library(tidytext)  
  library(dplyr)     
  library(igraph)    
  library(GGally)    
  library(stringr) 
  library(widyr)
  
  #get text col
  x <- data$Title
  
  #clean text col by using corpus methods
  corpus <- Corpus(VectorSource(x))
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removeWords, stopwords("english"))
  corpus <- tm_map(corpus, stemDocument)
  
  #return back to df for dplyr
  texts <- sapply(corpus, as.character)
  x <- data.frame(text = texts, stringsAsFactors = FALSE)
  
  #add document variable
  x <- x %>% mutate(document = row_number())
  
  #tokenize the text
  words <- x %>%
    unnest_tokens(word, text) 
  
  #find co-occurences
  co_occurrences <- words %>%
    pairwise_count(word, document, sort = TRUE, upper = FALSE)

  graphdata <- subset(co_occurrences, n >= 54)  
  graph <- graph_from_data_frame(graphdata, directed = FALSE)
  
  
  ggnet2(graph,
         color = "lightblue",  # Node color
         size = 10,  # Node size
         label = TRUE,  # Add node labels
         label.size = 3,  # Label size
         label.color = "black") +  # Label color
         ggtitle("Word Co-occurrence Network")
  
  
