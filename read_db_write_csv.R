#Zack Voskamp
#Load Packages
install.packages('RODBC')
install.packages('data.table')
library(RODBC)
library(data.table)

setwd('Path where to save')

con <- RODBC::odbcConnect(dsn = <>, uid = '', pwd = '')

#List the tables
tables <- as.list(sqlTables(con))

#Function to read and write the tables as csv
readTables <- function(table, dbConnection)
{
  #Query to select from tables
  query <- paste0('SELECT * FROM ', table)
  
  #select * from tables and store as df
  df <- RODBC::sqlQuery(dbConnection, query)  
  
  #Write tables as csv
  fwrite(df, paste0(table, '.csv'), sep = '|')
}

#Actually execute the function readTables
lapply(tables, readTables,  con)