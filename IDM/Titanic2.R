##limpiar ambiente de trabajo
rm(list =ls())

##setear directorio de trabajo
WD <- getwd()
Files_IDM <- paste(WD, "/IDM")

##Instalación de paquetes

lista_paquetes = c("funModeling","caret","ggthemes","rpart", "rpart.plot","ggcorrplot","dplyr","corrplot",'tidyverse','Hmisc','dplyr','PerformanceAnalytics','psych','corrplot','readr','tidyverse', 'DescTools', 'here','blockcluster', 'knitr', 'readxl', 'ggplot2',"cowplot")
install.packages("PerformanceAnalytics")

nuevos_paquetes = lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]

if(length(nuevos_paquetes)) install.packages(nuevos_paquetes, dependencies = TRUE)

##carga de librerías
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
library(DataExplorer)
library(gridExtra)
library(caret)



##importación
train <- read_csv("IDM/train.csv")
test <- read_csv("IDM/test.csv")

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

#en comparacion, hay mas cantidad de hombres vs mujeres.
train %>% group_by(Sex) %>% count()

train %>% group_by(Survived) %>% count()

### si graficamos la tasa de supervivencia, vemos que en comparacion las mujeres tienen mas chance de sobrevivir.
train %>% filter(!is.na(Survived)) %>% ggplot(aes(factor(Sex), fill = factor(Survived))) +
  geom_bar(position = "fill")  +
  scale_fill_brewer(palette = "Set2") +    
  ggtitle("Tasa de Supervivencia") + 
  labs(x = "Sex0", y = "Rate")


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


g1 <- train %>% 
  ggplot(aes(x = SibSp + Parch)) + 
  geom_bar(aes(fill = as.factor(SibSp + Parch))) + 
  labs(x="Tamaño de Familia") + 
  scale_fill_discrete(guide=FALSE) 

g2 <-train %>% 
  ggplot(aes(SibSp + Parch)) + 
  geom_bar(aes(fill = Survived),position = "fill")+ 
  labs(x="Tamaño de Familia") +
  scale_fill_discrete(guide=FALSE) 
grid.arrange(g1,g2)



#Armado del arbol

##combinar variables vinculadas a la familia
train$Familia <- train$Parch + train$SibSp 


##factorizar variables
train <- train %>% 
  mutate(Survived=factor(Survived), 
         Pclass=factor(Pclass, ordered=T),
         Name=factor(Name), 
         Sex=factor(Sex), 
         Embarked=factor(Embarked),
         Familia=factor(Familia))
View(train)


## Almacenar Fórmula. Se descartan los nombres, ID y Cabina. 
formula_3 <- formula(Survived ~Pclass + Sex + Embarked + Age + Fare + Familia )


##Armado del arbol 
arbol_4 <- rpart(formula_3, data = train, 
                 control = rpart.control(
                   minbucket = 1, 
                   minsplit = 1, 
                   maxdepth=30,
                   CP = 0
                 ))
##gráficos 4
prp(arbol_4, extra=101, type=2,  xsep="/", box.palette = "auto",
    round=0, leaf.round = 2, shadow.col = "gray", yes.text="Si", 
    no.text = "No")
rpart.plot(arbol_4)
printcp (arbol_4)
plotcp (arbol_4)


## Poda del Arbol 
Parbol_4 <- prune(arbol_4, cp = 0.020468 )
printcp(Parbol_4)
rpart.plot(Parbol_4)

##predicción sobre Train con arbol podado

  Predic_PA4 <- predict(Parbol_4, newdata = train, type = "class")

table(Predic_PA4, train$Survived)

sum((Predic_PA4 == train$Survived) / length(train$Survived))*100


##predicción sobre Train con arbol entero

Predic_A4 <- predict(arbol_4, newdata = train, type = "class")

table(Predic_A4, train$Survived)

sum((Predic_A4 == train$Survived) / length(train$Survived))*100


##combinar variables vinculadas a la familia
test$Familia <- test$Parch + test$SibSp 

############
####TEST####
############

##factorizar variables
test <- test %>% 
  mutate( Pclass=factor(Pclass, ordered=T),
          Name=factor(Name), 
          Sex=factor(Sex), 
          Embarked=factor(Embarked),
          Familia=factor(Familia))

##predicción sobre test con arbol entero
test$PSurvived<-NA
test$PSurvived <- predict(arbol_4, newdata = test, type = "class")

summary (test)
View(test)

###para submitir a Kaggle
test2<-data.frame(test$PassengerId,test$PSurvived)
names(test2)<-c("PassengerId","Survived")
write.csv(test2, "testtitanic.csv",row.names = F)


###score de 0.7799###
