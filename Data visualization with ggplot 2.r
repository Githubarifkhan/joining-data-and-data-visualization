# Introduction to ggplot.

# Gramamr of graphics introduced to R is through the ggplot2 package
# 7 layers to the graph:
# Data, Aesthetics, Geometry, Facets, Statistics, Coordinates and Themes.
# The first three are mandatory and must be there inorder to create a graph.
# ggplot: It is a data visualization package for R.


# 1. Data
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tibble")

hdi <- read.csv("hdi-cpi.csv", stringsAsFactors = FALSE)
hdi <- as.tibble(hdi)plyr

hdi

# 2. Aesthetics
# Aesthetics is the layer where we define the aesthetic mapping.

sc <- ggplot(hdi)
sc

# Nothings comes in the plots tab
# because we need all 3 initial layers to produce a graph.

# Since we are creating a scatter plot, we will be mapping country's
# HDI scores of 2015 in the y - axis and CPI score in the x - axis.
# The aesthetics call goes to the initial ggplot command 2

sc <- ggplot(hdi, aes(CPI.2015, HDI.2015))
sc
# Still no graph showing

# 3.Geometry: This is where we decide the shape we want our data points to take.

# For scatter plot,

sc + geom_point()

# There are tonnes of geoms we can use.
# Download ggplot2 Data visualisation cheat sheet to find many other ways

# We can start building up this image by the optional layers, Facets, Stats and coordinates.
# Themes has got nothing to do with the data and concerns only the appearance.

# 4. Facets: is where we can decide whether we want to break a plot into subplots based on a discrete variable.
# Here Region is such variable 

sc + geom_point() + facet_grid(Region ~.)

# Now we have 6 plots seperated by Region. This makes it eassier to spot trends in the data.


# 5. Statistics: enables us to do different transformation on data and summarizes in numerous ways.

sc + geom_point(aes(color = Region), size = 3) + facet_grid(Region ~.) + stat_smooth()

# 6. Co-ordinates: This is where we can specify the dimensions of a graph (zooming in or out)
# If we only want to see countries in the upper quartile of the CPI index,
# we can define the co-ordinates as follows.

sc + geom_point(aes(color = Region), size = 3) + facet_grid(Region ~.) +
  stat_smooth() + coord_cartesian(xlim = c(0.75,1))

# 7. Theme: Makes the graph styled and publication worthy

sc + geom_point(aes(color = Region), size = 3) + stat_smooth() + theme_minimal()

# qplot

qplot(CPI.2015, HDI.2015, data = hdi, facets = Region ~.)

# It's a convenient wrapper for creating a number of different types of plots using a consistent calling scheme.
# It's great for allowing you to produce plots quickly,
# but ggplot() is highly recommended as it makes it easier to create complex graphics.

