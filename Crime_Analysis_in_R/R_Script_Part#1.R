
packages <- c("tidyr", "xlsx", "pastecs", "ggplot2", "ggmap","reshape2","readr","dplyr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

#Load all required libraries
library(reshape2)   #reshaping the dataframe
library(xlsx)       #reads excel files
library(dplyr)      #join
library(ggplot2)    #plot
library(tidyr)
library(readr)
library(pastecs)


#Checking and Changing working directory
getwd()
#Changing the working directory
setwd("C:\\Project_Analytics\\SA_Crime_Analysis")


##Loading Dataset A  Crime Reported by  Police Station
Dataset_A <- read.csv("dataset\\Dataset_A.csv")


#Sorting the records using 'Police_Station'
Dataset_A[Dataset_A$Police_Station,]

#View the top 6 records
head(Dataset_A)


#Viewing the properties of the Features | Variables | Coulms
str(Dataset_A)


#Reshaping the dataset from "long" to "wide" format
Dataset_A_Wide <- spread(Dataset_A, Crime_Category, Period_2015_2016)
head(Dataset_A_Wide)

#Dataset_A_Wide_Flatten = dcast(Dataset_A, Province + Police_Station ~ Crime_Category , 
#                               value.var = "Period_2015_2016", fun.aggregate = sum)
head(Dataset_A_Wide)

#Test for duplicity in the dataset
length(duplicated(Dataset_A_Wide))  #all the rows were returned, therefore no duplicated rows

length(duplicated(Dataset_A_Wide$Police_Station))

#Capitalising the names of police stations
#This is done by adding "Police_Station_String" generated from "Police_Station"
#Dataset_A_Wide_Flatten$Police_Station <-toupper(Dataset_A_Wide$Police_Station) #convert Police_Station to uppercase

#Dataset B - Police Station and the Population that they Cover
#This dataset is in xls (MS Excel) format
Dataset_B = read.xlsx("dataset\\Dataset_B.xlsx", sheetIndex =1)    # read in excel file
head(Dataset_B)

#Check the structure of Variables
str(Dataset_B)

#Test for duplicity in the dataset
length(duplicated(Dataset_B$Police_Station))  #all the rows were returned, therefore no duplicated rows
#anyDuplicated(duplicated(Dataset_B))  #all the rows were returned, therefore no duplicated rows

# Dataset C - Police Station and their Geo-Coordinates
#This dataset is in tsv (tab delimited) format
Dataset_C <- read.table("dataset\\Dataset_C.tsv", header=TRUE,sep='\t')
head(Dataset_C)

#Viewing the Attributes of the Variables
str(Dataset_C)

#Test for duplicity in the dataset
length(duplicated(Dataset_C))  #all the rows were returned, therefore no duplicated rows

###### Merging Dataset A & B#########
paste("Size of Dataset A =" , nrow(Dataset_A_Wide_Flatten))
paste("Size of Dataset B =" , nrow(Dataset_B))
paste("Size of Dataset B =" , nrow(Dataset_C))

#Note: Dataset A contains more records than Dataset B. Hence, Dataset A is the universal dataset.
Dataset_A_and_B <- left_join(Dataset_A_Wide, Dataset_B, by="Police_Station")
head(Dataset_A_and_B,10)

# Note: In the code above: 
# The two datasets were merged using a feature that is common to the 2 of them i.e. Police_Station 
# Dataset_A is on the left
# Dataset_B is on the right
# Since I want all records on the left (universal). I specified: how='left'

head(Dataset_A_and_B)
head(Dataset_A_Wide,2)

#Left Join
Dataset_A_B_and_C <- left_join(Dataset_A_and_B, Dataset_C,by="Police_Station")
head(Dataset_A_B_and_C)








