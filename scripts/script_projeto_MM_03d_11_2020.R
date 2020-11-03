

library(tidyverse)
library(here)
library(readxl)
library(writexl)
library(lubridate)


#tabela carnivoros neotropical em formato .csv
neotrop <- readr::read_csv(here::here("NEOTROPICAL_CARNIVORES_DATASET_2020-04.csv"))
neotrop

#espiar os dados
glimpse(neotrop)

# Pegar dados das colunas: SPECIES, LONG_X, LAT_Y
# Pegar só as linhas contendo Chrysocyon brachyurus dentro da coluna SPECIES 

library(dplyr)


neotrop[, c("SPECIES", "LONG_X", "LAT_Y")]

#Criar o objeto neo_sp com apenas as 3 colunas que queremos

neo_sp<- {neotrop[, c("SPECIES", "LONG_X", "LAT_Y")]}

neo_sp 

nrow (neo_sp)
dim(neo_sp)

rownames(neo_sp)

summary (neo_sp)


# extrair os dados apenas de Chrysocyon brachyurus

lobo_sp <- neo_sp[neo_sp$SPECIES == "Chrysocyon brachyurus", ]
lobo_sp

require(RgoogleMaps)
require(ggplot2)
require(ggmap)

#fazer o mapa com os pontos de localização do lobo
box <- make_bbox(LONG_X,LAT_Y, data = lobo_sp)


map <-ggmap(get_map(location = box, maptype="toner", source="stamen")
) +
  geom_point(data=lobo_sp, x=lobo_sp$LONG_X, y=lobo_sp$LAT_Y, color="red")
map

plot(map)


summary (lobo_sp)
dim(lobo_sp)

# extrair os dados apenas de Puma concolor

puma_sp <- neo_sp[neo_sp$SPECIES == "Puma concolor", ]
puma_sp

#fazer o mapa com os pontos de localização da puma concolor
box <- make_bbox(LONG_X,LAT_Y, data = puma_sp)


map2 <-ggmap(get_map(location = box, maptype="toner", source="stamen")
) +
  geom_point(data=puma_sp, x=puma_sp$LONG_X, y=puma_sp$LAT_Y, color="blue")
map

plot(map2)

summary (puma_sp)
dim(puma_sp)


