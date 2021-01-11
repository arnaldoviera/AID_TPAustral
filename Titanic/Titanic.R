lista_paquetes = c('funModeling',"ggthemes","ggcorrplot","dplyr","corrplot",'tidyverse','Hmisc','dplyr','PerformanceAnalytics','psych','corrplot','readr','tidyverse', 'DescTools', 'here','blockcluster', 'knitr', 'readxl', 'ggplot2',"cowplot")
nuevos_paquetes = lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]
if(length(nuevos_paquetes)) install.packages(nuevos_paquetes, dependencies = TRUE)

suppressWarnings(suppressMessages(easypackages::libraries(lista_paquetes)))
library(dplyr)
library(readxl)
library(ggplot2)
library(corrplot)
library(psych)
library(ggcorrplot)
library("PerformanceAnalytics")
library(ggthemes)
library(funModeling)
library(readr)

##me falta llamar al archivo, como lo hago desde mi pc no puedo usar el que esta en github.

summary(train)
glimpse(train)
print(status(train))
freq(train) 
print(profiling_num(train))
plot_num(train)
describe(train)







____________

library(readr)
resultado <- read_delim("C:/Users/quintej/Desktop/MCD/AID/TP2/resultado.txt", 
                        "\t", escape_double = FALSE, trim_ws = TRUE)
library (tibble)
datos <- tibble(
  resultado
)

datos = resultado_ok


summary(datos)

ggplot(datos) + ## gráfico simple
  aes(x = valence , y =  energy) +
  geom_point()


ggplot(datos) + ## gráfico sin agrupar: la energía y la positividad están relacionadas
  aes(x = valence, y = energy) +
  geom_point() +
  
  stat_smooth(method = "lm")


ggplot(datos) + ## gráfico sin agrupar: la energía y la positividad están relacionadas en todos los tonos
  aes(x = valence, y = energy) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ key)



X
ggplot(datos) + ## gráfico sin agrupar: la energía y la positividad están relacionadas en as categorías (no están!)
  aes(x = valence, y = energy) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ categoria)


datosnumericos <- select(datos, 
                         danceability, 
                         energy, 
                         loudness, 
                         speechiness,
                         acousticness,
                         instrumentalness, 
                         liveness,
                         valence,
                         tempo)

library("PerformanceAnalytics")
chart.Correlation(datosnumericos, histogram=TRUE, pch=40)


boxplot(valence~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="valence",
        col="red",
        border="brown")

boxplot(energy~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="energy",
        col="red",
        border="brown")




ggplot(datos) + 
  aes(x = valence , y = energy, color = album_artist) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ album_artist)

datossinBilly <- filter(datos, album_artist != "Billy Bond and The Jets")

ggplot(datossinBilly) + 
  aes(x = valence , y = energy, color = album_artist) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ album_artist)

datosnumericosSB <- select(datossinBilly, 
                           danceability, 
                           energy, 
                           loudness, 
                           speechiness,
                           acousticness,
                           instrumentalness, 
                           liveness,
                           valence,
                           tempo,
                           duration_ms)

library("PerformanceAnalytics")
chart.Correlation(datosnumericosSB, histogram=TRUE, pch=40)


class(datos)
datos2<- datos %>% 
  group_by(album_artist) %>% 
  summarise(mean = mean(energy),
            min = min(energy),
            max = max(energy)
  )
datos2

class(datos)
datos2<- datos %>% 
  group_by(album_artist) %>% 
  summarise(mean = mean(duration_ms),
            min = min(duration_ms),
            max = max(duration_ms)
  )
datos2

ggplot(datos) +
  aes(x = album_artist , y = energy, color =key) +
  geom_point(mapping = aes(color = key)) +
  stat_smooth(method = "lm", color = "black")



class(datos) ## no sé qué es! (Arnaldo)
datos2<- datos %>% 
  group_by(album_name) %>% 
  summarise(mean = mean(energy),
            min = min(energy),
            max = max(energy
            )
  )
datos2
boxplot(loudness~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="danceability",
        col="red",
        border="brown")
