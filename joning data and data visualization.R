# Dplyr is the package used for data cleaning and transformation.
# It has func like Summarise, Aggregate, Join, Mutate, Select, Filter, etc


# ******************************  Mutating joins ****************************************************

# mutate() adds new variables that are functions of existing variables.
# This func match observations from one dataset to obs in another dataset,
# even if the obs appear in different order.
# It returns a copy of the primary dataset that has one or more column added to it from the secondary dataset.
# They differ from each other w.r.t. which values and rows they want to return.


# A join combines 2 datasets by adding the columns of 1 dataset along side the
# colums of the other.

# Data can be joined by identifying a pair of keys that connect tables.
# The job is to find that 1 common column. Also known as Primary key.
# Basic join func in dplyr is the left join

# Let's create a df to work on.

names <- data.frame(name = c("Mick", "John", "Paul"), band = c("Stones", "Beatles", "Beatles"))
names

plays <- data.frame(name = c("John", "Paul", "Keith"), plays = c("Guitar", "Bass", "Guitar"))
plays


names2 <- data.frame(name = c("John", "John", "Paul"), surname = c("Coltrane", "Lennon", "McCartney"),
                     band = c("NA", "Beatles", "Beatles"))
names2

plays2 <- data.frame(name = c("John", "Paul", "Keith"), surname = c("Lennon", "McCartney", "Richards"),
                     plays = c("Guitar", "Bass", "Guitar"))
plays2
install.packages("dplyr")
library(dplyr)

#***********************************

# left_join() returns from 1st dataset with any rows that match from the 2nd dataset.


left_join(names, plays, by = "name")
# names = table to augment, plays = table to augment with, "name" = key column.

left_join(names2, plays2, by = c("name", "surname"))
# Here there is a vector of key names, 
# John appears twice, in such case, we will also consider the surname as a key column.

#***********************************

# Right join : does the exact opposite of left join
# right_join() returns from 2nd dataset with any rows that match from the 1st dataset.

right_join(names, plays, by = "name")
right_join(names2,plays2 , by ="name")
# Returns all the rows of the 2nd dataset.
# Keith is returned because he is in the 2nd dataset, unlike Mike.

#************************************

# inner_join() returns only the rows from the 1st dataset that have a match in the 2nd dataset.
# Every row must appear in both the datasets.

inner_join(names, plays, by = "name")
inner_join(names2, plays2, by = "name")

#************************************

# full_join() does the exact opposite.
# Most inclusive join, it retains all the info in the table

full_join(names, plays, by = "name")
full_join(names2, plays2, by = "name")
names
plays

#A semi join creates a new table where it will return all rows from the first table where there
#is a corresponding matching value in second,but instead of the new table combining both the first 
#and second tables, it only contains data from the first table.

semi_join(names, plays, by = "name")
semi_join(names2, plays2, by = "name")
names2
plays2

#An anti join will return all of the rows from the first table where there are not matching values from the second. 

anti_join(names, plays, by = "name")
anti_join(names2, plays2, by = "name")

# Mutating joins:
# left join = 1st dataset
# right join = 2nd dataset
# inner join = rows in both dataset
# ****************************  Advanced joining  ****************************************************
# full join = every rows in any dataset



# ****************************  Filtering joins and set operations ***********************************

# filter() picks cases based on their values. It extracts rows from combinations of datasets
# Filtering joins return a copy of the dataset that has been filtered, not augmented.

# Semi joins:

names2 %>% 
  semi_join(plays2, by = c("name", "surname"))

# Creating same result with pipe operator

names2 %>% 
  right_join(plays2, by = c("name", "surname")) %>% 
  filter(!is.na(band)) %>% 
  select(name, surname, band)

# Exploring semi join

names2 %>% 
  # Collect the albums made by a band
  semi_join(plays2, by = "name") %>% 
  # Count the albums made by a band
  nrow()

semi_join(names2, plays2, by = "name")
semi_join(names, plays, by = "name")


names2 %>% 
  anti_join(plays2, by = c("name","surname"))
# Return rows of artists that don't have bands info

labels(names)

names2
plays2

# All rows in names2, names that have a match in plays2, plays.

# Set Operations:

# union will return every row that appears in one or more of the datasets
# If a row appears multiple times union will only return it once

union(plays2, names2)

# interesect will return only the rows that appear in both datasets
intersect(names2, plays2)


# setdiff will return the rows that appear in the first dataset but not the second
setdiff(names2, plays2)

# ****************************  Case-study  *****************************************************

# We can recognize what can go wrong with joins and quickly fix errors or avoiding 
#them altogether


customers = read.csv("customers.txt")
orders = read.csv("orders.txt")

customers
orders

left_join(customers, orders, by = "customer_id")

right_join(customers, orders, by = "customer_id")

#colnames(customers)[colnames(customers)=="id"] <- "customer_id"

          
