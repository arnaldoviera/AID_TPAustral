# Acá iría el código del TP


install.packages("readr")

install.packages("readxl")

getwd()

rm() ## borrar lo que creo sin sentido


library(readxl) ## importación de Segú Giran
serugiran <- read_excel(path = "C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/serugiran.xlsx",sheet = "Sheet1",range = "A1:V123")

colnames(serugiran)<-c("name" , "track_number", "disc_number", "album_id",     
                       "album_artist",    "album_name"  ,    
                       "id"   ,            "danceability" ,   
                       "energy"  ,         "key"    ,         
                       "loudness"  ,       "mode"   ,         
                       "speechiness" ,     "acousticness" ,   
                       "instrumentalness", "liveness"  ,      
                       "valence",          "tempo"  ,         
                       "duration_ms" ,     "time_signature"  ,
                       "uri"  ,            "analysis_url"  )
View(serugiran)


library(readr) ## importación de Sui Generis
suigeneris <- read_csv("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/suigeneris.csv")

suigeneris$disc_number<-("")
suigeneris$album_artist<-("SuiGeneris")
suigeneris<- suigeneris [,c(1,2,21,3,22,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)]

View(suigeneris)

## a Sui Generis le faltan 2 columnas: la n° 3 (disc_number) y la n° 6 (album_artist) LISTO


setwd("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/") 
##importación solista

DiscosSolistasSueltos <- list.files(path="C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/", pattern="*.txt")

DiscosSolista<-lapply(DiscosSolistasSueltos, read.delim)


setwd("C:/Users/arnal/OneDrive/Dropbox/UAustral/ANÁLISIS INTELIGENTE DE DATOS/Repo/AID_TPAustral") 


library(readr) ##importación Porsuigieco
porsuigieco <- read_delim("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/porsuigieco.txt", 
                          "|", escape_double = FALSE, trim_ws = TRUE)
View(porsuigieco)


install.packages("haven")

library("haven")

library("haven") ## importación Billy Bond and The Jets
bbatj <- read_sas("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/bbatj.sas7bdat")


setwd("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/") 
##importación solista

DiscosSolistasSueltos <- list.files(path="C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/", pattern="*.txt")

DiscosSolista<-lapply(DiscosSolistasSueltos, read.delim)


## Transform la lista de dataframes solistas a un 

DiscosSolistaDS <- rbind(DiscosSolista[[1]], DiscosSolista[[2]],DiscosSolista[[3]], DiscosSolista[[4]], DiscosSolista[[5]],DiscosSolista[[6]],
                         DiscosSolista[[7]], DiscosSolista[[8]],DiscosSolista[[9]], DiscosSolista[[10]],DiscosSolista[[11]],DiscosSolista[[12]],
                         DiscosSolista[[13]],DiscosSolista[[14]],DiscosSolista[[15]], DiscosSolista[[16]],DiscosSolista[[17]],DiscosSolista[[18]],
                         DiscosSolista[[19]],DiscosSolista[[20]],DiscosSolista[[21]] )

rm(DiscosSolista)##elimino la lista que se creó


#unir Discos aun DataFrame
union <- rbind(serugiran, suigeneris,porsuigieco,DiscosSolistaDS, bbatj)
View(union)


#pasar a txt, separado por tabulador falta el working directory.
write.table(union,"C:/Users/quintej/Desktop/MCD/AID/AID/resultado.txt",sep="\t")
