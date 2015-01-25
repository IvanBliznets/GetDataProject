---
title: "Readme"
output: html_document
---

##Explanation of performed analysis

* Load test and train data (using read.table)
* Merge test and train data (using rbind)
* Extract names of variables that contain substrings "mean" and "std" (using grep)
* Subset data which correspond to mean or standart deviation (using subsetting operations)
* Rename columns to make them legal in R (using finction make.names with parameter unique=TRUE)
* Add labels to data.frame with correspoding activity and subject who performed the activity (using cbind)
* Create a new data.frame containing all observed combinations of subject and activity with mean computed for each varible  (using aggregate function, unobserved combinations of subject and activity are not present)
* Save data.frame finalData using write.table with option row.name=FALSE
