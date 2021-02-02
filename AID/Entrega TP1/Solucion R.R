# RESOLUCION TAREA 1
library(readxl) #excel
library(haven) #sas
library(tidyverse) #para todo lo demas

#Descomprimir el zip
unzip("datos_charly.zip", exdir = "datos")

#Porsuigieco
psg <- read_delim(file = "datos/porsuigieco.txt", delim = "|")

#Billy Bond
bb <- read_sas("datos/bbatj.sas7bdat")

#Charly solista
listasolista <- list.files("datos/solista", full.names = TRUE)
charly <- map_df(.x = listasolista, .f = read_delim, delim = "\t")

#Sui Generis
sg <- read_csv("datos/suigeneris.csv") %>% 
  mutate(album_artist = "Sui Generis") %>% 
  fill(album_name, album_id)

#Seru Giran
seru <- read_excel("datos/serugiran.xlsx") %>% 
  rename(name = cancion, 
         track_number = nro_track, 
         disc_number = nro_disco, 
         album_name = album_nombre, 
         album_artist = album_artista, 
         danceability = bailabilidad,
         energy = energia, 
         key = tonalidad, 
         loudness = volumen, 
         mode = modo,
         speechiness = habladicidad, 
         acousticness = acusticidad,
         instrumentalness = instrumentalidad, 
         liveness = envivocidad,
         valence = positividad, 
         duration_ms = duracion_ms, 
         time_signature = compas)

#La Máquina de Hacer Pájaros
mifuncion <- function(x, album) {
  read_delim(x,  delim = ": ", col_names = FALSE, trim_ws = TRUE) %>% 
    pivot_wider(names_from = X1, values_from = X2) %>% 
    mutate_at(vars(-name, -id), as.numeric) %>% 
    mutate(
      album_name = album,
      album_artist = "La Máquina de Hacer Pájaros"
    )
}

disco1 <- list.files("datos/lmdhp/album_peliculas", full.names = T) %>% 
  map_df(mifuncion, "Peliculas")

disco2 <- list.files("datos/lmdhp/album_la_maquina_de_hacer_pajaros", full.names = T) %>% 
  map_df(mifuncion, "La Máquina De Hacer Pájaros")

lmdhp <- read_excel("datos/albums.xlsx") %>% 
  select(album_name = name, album_id = id) %>% 
  right_join(bind_rows(disco1, disco2))


#UNION FINAL
unionfinal <- bind_rows(
  bb,
  charly,
  psg,
  seru,
  sg,
  lmdhp
)

write.table(unionfinal, file = "resultado.txt", sep = "\t", quote = F, row.names = F)

