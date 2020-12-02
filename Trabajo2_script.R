library("readxl") #excel
library (haven) #sas
install.packages("tidyverse")

library(tidyverse) #para todo lo demas

library(readr)
resultado <- read_delim("C:/Users/quintej/Desktop/MCD/AID/TP2/resultado.txt", 
                        "\t", escape_double = FALSE, trim_ws = TRUE)
library (tibble)
datos <- tibble(
  resultado
)

datos = resultado


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


ggplot(datos) + ## gráfico sin agrupar: la energía y la positividad están relacionadas en as categorías (no están!)
  aes(x = valence, y = energy) +
  geom_point() +
  stat_smooth(method = "lm")+
  facet_wrap(~ categoria)







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
