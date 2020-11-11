# Acá iría el código del TP

# instalar librerias
install.packages("readr")
install.packages("readxl")
install.packages("haven")

# importacion de librerias
library(readxl)
library(readr)
library("haven")

#definicion de variables
dir_project = getwd()
dir_project_files <- paste( dir_project , "/Files", sep="")


#SERUGIRAN
path_serugiran_xlxs <- paste(dir_project_files, "/serugiran.xlsx", sep="")
serugiran <- read_excel(path=path_serugiran_xlxs,sheet = "Sheet1",range = "A1:V123")
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


#SUIGENERIS
suigeneris <- read_csv(paste(dir_project_files, "/suigeneris.csv", sep=""))
suigeneris$disc_number<-("")
suigeneris$album_artist<-("SuiGeneris")
suigeneris<- suigeneris [,c(1,2,21,3,22,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)]
View(suigeneris)


#PORSUIGIECO
porsuigieco <- read_delim(paste(dir_project_files, "/porsuigieco.txt", sep=""), 
                          "|", escape_double = FALSE, trim_ws = TRUE)
View(porsuigieco)


#BBATJ
bbatj <- read_sas(paste(dir_project_files, "/bbatj.sas7bdat", sep=""))
View(bbatj)


#DIRECTORY SOLISTA
path_dir_solista = paste(dir_project_files, "/solista/", sep="")
setwd(path_dir_solista)

DiscosSolistasSueltos <- list.files(path=path_dir_solista, pattern="*.txt")
DiscosSolista<-lapply(DiscosSolistasSueltos, read.delim)
View(DiscosSolista)


#TRANSFORMAMOS LA LISTA
DiscosSolistaDS <- rbind(DiscosSolista[[1]], DiscosSolista[[2]],DiscosSolista[[3]], DiscosSolista[[4]], DiscosSolista[[5]],DiscosSolista[[6]],
                         DiscosSolista[[7]], DiscosSolista[[8]],DiscosSolista[[9]], DiscosSolista[[10]],DiscosSolista[[11]],DiscosSolista[[12]],
                         DiscosSolista[[13]],DiscosSolista[[14]],DiscosSolista[[15]], DiscosSolista[[16]],DiscosSolista[[17]],DiscosSolista[[18]],
                         DiscosSolista[[19]],DiscosSolista[[20]],DiscosSolista[[21]] )
#ELIMINAMOS LA VARIABLE DE DISCO QUE YA NO SE USARÁN
rm(DiscosSolista)


#HACEMOS EL UNION
union <- rbind(serugiran, suigeneris,porsuigieco,DiscosSolistaDS, bbatj)
View(union)


#GENERAMOS EL RESULTADO
write.table(union,paste(dir_project_files, "/resultado/resultado.txt", sep=""),sep="\t")
