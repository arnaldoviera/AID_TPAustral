lista_paquetes = c('funModeling',"ggthemes","rpart", "caret", "rpart.plot","ggcorrplot","dplyr","corrplot",'tidyverse','Hmisc','dplyr','PerformanceAnalytics','psych','corrplot','readr','tidyverse', 'DescTools', 'here','blockcluster', 'knitr', 'readxl', 'ggplot2',"cowplot")
install.packages("PerformanceAnalytics")	
nuevos_paquetes = lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]

if(length(nuevos_paquetes)) install.packages(nuevos_paquetes, dependencies = TRUE)

library(tidyverse)
library(dplyr)
library(readxl)
library(ggplot2)
library(corrplot)
library(psych)
library(ggcorrplot)
library(PerformanceAnalytics)	
library(ggthemes)
library(funModeling)
library(readr)
library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

##me falta llamar al archivo, como lo hago desde mi pc no puedo usar el que esta en github.

##setear directorio de trabajo
WD <- getwd()
Files_IDM <- paste(WD, "/IDM")

##importación
library(readr)
train <- read_csv("IDM/train.csv")
View(train)



##EDA
summary(train)	
glimpse(train)
print(status(train))
freq(train) 
print(profiling_num(train))
plot_num(train)
describe(train)
head(train)


##formula
formula_1 <- formula(Survived ~ Pclass + Sex + Embarked)

##arbol discreto
arbol_1 <- rpart(formula_1, data = train)

##gráfico básico
prp(arbol_1, extra=101, type=2,  xsep="/")

##formula
formula_2 <- formula(Survived ~Pclass + Sex + Embarked + Age + SibSp + Parch + Fare)

##arbol 2
arbol_2 <- rpart(formula_2, data = train)

##gráficos
prp(arbol_2, extra=101, type=2,  xsep="/", box.palette = "auto",
    round=0, leaf.round = 2, shadow.col = "gray", yes.text="Si", no.text = "No")

rpart.plot(arbol_2)

printcp (arbol_2)

##Predicción 
Predicción_Arbol2 <- predict(arbol_2)

##Revisión predicción
head(Predicción_Arbol2)


