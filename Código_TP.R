# Acá iría el código del TP


install.packages("readr")

install.packages("readxl")

getwd()



library(readxl) ## importación de Segú Giran
serugiran <- read_excel(path = "C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/serugiran.xlsx",sheet = "Sheet1",range = "A1:V123")

library(readr) ## importación de Sui Generis
suigeneris <- read_csv("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/suigeneris.csv")
View(suigeneris)


setwd("C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/") 
DiscosSolistasSueltos <- list.files(path="C:/Users/arnal/OneDrive/Escritorio/Tarea 1/datos_charly/solista/", pattern="*.txt")

DiscosSolista<-lapply(DiscosSolistasSueltos, read.delim)


setwd("C:/Users/arnal/OneDrive/Dropbox/UAustral/ANÁLISIS INTELIGENTE DE DATOS/Repo/AID_TPAustral") 


  

