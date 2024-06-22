#Script para salida de Data Frames a un Archivo Excel

# Instalar paquete RSQLite
install.packages("RSQLite")
install.packages("writexl")

# Cargar el paquete
library(RSQLite)
library(writexl)

# Conectar a la base de datos SQLite 
con <- dbConnect(RSQLite::SQLite(), dbname = "database.sqlite")

# Obtiene la lista de tablas en la base de datos
tablas <- dbListTables(con)
print(tablas)

# Creacion de Data Frames
DfResultados <- dbReadTable(con, "primary_results")
DfResultadosD <- DfResultados[, c("state", "state_abbreviation","county","party","candidate","votes")]
DfCountyfacts<- dbReadTable(con, "county_facts")
DfCountyfactsD <- DfCountyfacts[, c("area_name", "state_abbreviation","INC910213","INC110213","PVY020213","RHI125214","RHI225214","RHI725214","RHI425214" ,"PST045214")]

#Salida de DF a archivo Excel
write_xlsx(DDfResultadosD, "Resultados.xlsx")
write_xlsx(DfCountyfactsD, "CountyFactsN.xlsx")

# Cerrar la conexión a la base de datos
dbDisconnect(con)
