#Zack Voskamp
#Load Packages
install.packages('RODBC')
install.packages('data.table')
install.packages('dplyr')
library(dplyr)
library(RODBC)
library(data.table)

setwd('E:\\csv')

con <- RODBC::odbcConnect(dsn = 'SQL')

databases <- sqlQuery(con, "SELECT name FROM master..sysdatabases where name like '%IA%'")

#List the tables
tables <- sqlTables(con, catalog = "IA_DB") 

# %>%
#   SELECT(TABLE_NAME)

tables <- as.list(tables$TABLE_NAME)

#Function to read and write the tables as csv
readTables <- function(table, dbConnection)
{
  #Query to select from tables
  query <- paste0('SELECT * FROM IA_DB.dbo.', table)
  
  #select * from tables and store as df
  df <- as.data.frame(RODBC::sqlQuery(dbConnection, query))
  
  #Write tables as csv
  fwrite(df, paste0('E:/csv/', table, '.csv'), sep = '|')
}

#Actually execute the function readTables
lapply(tables, readTables, dbConnection = con)
