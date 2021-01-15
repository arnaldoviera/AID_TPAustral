lista_paquetes = c('funModeling',"ggthemes","rpart", "rpart.plot","ggcorrplot","dplyr","corrplot",'tidyverse','Hmisc','dplyr','PerformanceAnalytics','psych','corrplot','readr','tidyverse', 'DescTools', 'here','blockcluster', 'knitr', 'readxl', 'ggplot2',"cowplot")
install.packages("PerformanceAnalytics")	
nuevos_paquetes = lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]

if(length(nuevos_paquetes)) install.packages(nuevos_paquetes, dependencies = TRUE)
library(tidyverse) #para todo lo demas	

install.packages("caret")

##no se qué es
suppressWarnings(suppressMessages(easypackages::libraries(lista_paquetes)))

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

test <- read_csv("IDM/test.csv")
View(test)


##EDA
summary(train)	
glimpse(train)
print(status(train))
freq(train) 
print(profiling_num(train))
plot_num(train)
describe(train)
head(train)

##evalua datos faltantes
plot_missing(train)

#paso a factores.
train <- train %>% 
  mutate(Survived=factor(Survived), 
                          Pclass=factor(Pclass, ordered=T),
                          Name=factor(Name), 
                          Sex=factor(Sex), 
                          Embarked=factor(Embarked))
View(train)
#en comparacion, hay mas cantidad de hombres vs mujeres.
train %>% group_by(Sex) %>% count()

train %>% group_by(Survived) %>% count()

### si graficamos la tasa de supervivencia, 
train %>% filter(!is.na(Survived)) %>% ggplot(aes(factor(Sex), fill = factor(Survived))) +
  geom_bar(position = "fill")  +
  scale_fill_brewer(palette = "Set2") +    
  ggtitle("Tasa de Supervivencia") + 
  labs(x = "Sex", y = "Rate")


##si evaluamos la tasa de supervivencia por clase, vemos que 
##cuanta más alta la clase, más probabilidades de sobrevivir
train %>%
  filter(!is.na(Survived)) %>%
  ggplot(aes(factor(Pclass), fill = factor(Survived))) +
  geom_bar(position = "fill") + 
  scale_fill_brewer(palette = "Set2") +  
  ggtitle("Tasa de supervivencia por Clase") + 
  labs(x = "Pclass", y = "Rate")


##si dividimos la supervivencia por Edad, vemos que los más jovenes tuvieron mayor tasa de supervivencia
train %>%
  ggplot(aes(x = Age, y = ..count.., fill = Survived)) +
  geom_density(alpha = 0.2)




##formula
formula_1 <- formula(Survived ~ Pclass + Sex + Embarked )

##arbol discreto
arbol_1 <- rpart(formula_1, data = train)

##gráfico básico
prp(arbol_1, extra=101, type=2,  xsep="/")

##formula 2
formula_2 <- formula(Survived ~Pclass + Sex + Embarked + Age + SibSp + Parch + Fare)

##arbol 2
arbol_2 <- rpart(formula_2, data = train)

##gráficos 2
prp(arbol_2, extra=101, type=2,  xsep="/", box.palette = "auto",
    round=0, leaf.round = 2, shadow.col = "gray", yes.text="Si", no.text = "No")

rpart.plot(arbol_2)

printcp (arbol_2)

##Predicción 
Predicción_Arbol2 <- predict(arbol_2)
View(Predicción_Arbol2)

##Revisión predicción
head(Predicción_Arbol2)




##formula 3
formula_3 <- formula(Survived ~Pclass + Sex + Embarked + Age + Fare)
##arbol 3
arbol_3 <- rpart(formula_3, data = train, 
                 control = rpart.control(minbucket = 3, maxdepth=10))
##arbol_3 <- rpart(formula_3, data = train)
##gráficos 3
prp(arbol_3, extra=101, type=2,  xsep="/", box.palette = "auto",
    round=0, leaf.round = 2, shadow.col = "gray", yes.text="Si", 
    no.text = "No")
rpart.plot(arbol_3)
printcp (arbol_3)
##Predicción 
Predicción_Arbol3 <- predict(arbol_3)
View(Predicción_Arbol3)
##Revisión predicción
head(Predicción_Arbol3)




#### NO FUNCA
##Curva ROC
install.packages("keras")
install.packages("Metrics")
library(keras)
vecPred = as.vector(Predicción_Arbol3)
View(vecPred)
mdl_auc <- Metrics::auc(actual = Predicción_Arbol3, predicted = train$Survived)
### NO FUNCA
#####################
pred <- prediction(predict(arbolcv$finalModel, type = "prob", newdata = dfBlodTest)[, 2], dfBlodTest$dono)
plot(performance(pred, "tpr", "fpr"),
     main= paste0("AUC = ", round(mdl_auc, 4)))


