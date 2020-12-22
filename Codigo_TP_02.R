install.packages("tidyverse")
install.packages("PerformanceAnalytics")

library("readxl")
library (haven)
library(tidyverse)
library(readr)
library (tibble)


dir_project <- getwd()
file_resultado <- paste( dir_project , "/resultado.txt", sep="")
resultado <- read_delim(file_resultado, 
                        "\t", escape_double = FALSE, trim_ws = TRUE)
datos <- tibble(
  resultado
)


summary(datos)

## gráfico simple
ggplot(datos) + 
  aes(x = valence , y =  energy) +
  geom_point()


## G-02: gráfico sin agrupar: la energía y la positividad están relacionadas
ggplot(datos) + 
  aes(x = valence, y = energy) +
  geom_point() +
  stat_smooth(method = "lm")


## G-03: gráfico sin agrupar: la energía y la positividad están relacionadas en todos los tonos
ggplot(datos) + 
  aes(x = valence, y = energy) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ key)



## gráfico sin agrupar: la energía y la positividad están relacionadas en as categorías (no están!)
#ggplot(datos) + 
#  aes(x = valence, y = energy) +
#  geom_point() +
#  stat_smooth(method = "lm")+
#  facet_wrap(~ categoria)


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
## G-01
chart.Correlation(datosnumericos, histogram=TRUE, pch=40)

## G-04
boxplot(valence~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="valence",
        col="red",
        border="brown")

## G-05
boxplot(energy~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="energy",
        col="red",
        border="brown")



## G-06
ggplot(datos) + 
  aes(x = valence , y = energy, color = album_artist) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ album_artist)

## Filtramos para obtener todas las bandas excepto "Billy Bond and The Jets"
datossinBilly <- filter(datos, album_artist != "Billy Bond and The Jets")

## G-07
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



#class(datos) ## no sé qué es! (Arnaldo)
#datos2<- datos %>% 
#  group_by(album_name) %>% 
#  summarise(mean = mean(energy),
#            min = min(energy),
#            max = max(energy
#            )
#  )
datos2
boxplot(loudness~album_artist,
        data =datos,
        xlab="album_artist",
        ylab="danceability",
        col="red",
        border="brown")

Prueba
