##################### Appply Joins in R #######################

mtcars
cars_4g <- mtcars[mtcars$gear == 4,]
cars_4g
cars_mpg_25 <-mtcars[mtcars$mpg >=25,]
cars_mpg_25
?merge
mergecar <- merge(cars_4g,cars_mpg_25)
merge(cars_mpg_25, cars_4g)
mergecar

# Full Join #########
merge(cars_4g, cars_mpg_25, all =TRUE)

# Left Outer Join #######
merge_right <- merge(cars_4g, cars_mpg_25, all.x= TRUE)
merge_right


# Right Outer Join #######
merge_right1 <- merge(cars_4g, cars_mpg_25, all.y = TRUE)
merge_right1

