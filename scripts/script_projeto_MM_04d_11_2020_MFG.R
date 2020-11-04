

library(tidyverse)
library(here)
library(readxl)
library(writexl)
library(lubridate)





#tabela carnivoros neotropical em formato .csv
neotrop <- readr::read_csv(here::here("dados", "NEOTROPICAL_CARNIVORES_DATASET_2020-04.csv"))
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

plot(lobo_sp)

summary (lobo_sp)
dim(lobo_sp)

# extrair os dados apenas de Puma concolor

puma_sp <- neo_sp[neo_sp$SPECIES == "Puma concolor", ]
puma_sp


summary (puma_sp)
dim(puma_sp)


## modelos climáticos para habitat suitability de Puma e Lobo-guará




## Dados climáticos:

download.file(url = "https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_10m_bio.zip",
              destfile = here::here("dados", "raster", "wc2.0_10m_bio.zip"), mode = "wb")

# unzip
unzip(zipfile = here::here("dados", "raster", "wc2.0_10m_bio.zip"),
      exdir = here::here("dados", "raster"))

# list files > lista das files onde estão os dados climáticos
fi <- dir(path = here::here("dados", "raster"), pattern = "wc") %>% 
  grep(".tif", ., value = TRUE)
fi
#raster dos dados climaticos

# import stack > importa as 19 variaveis climaticas 
st <- raster::stack(here::here("dados", "raster", fi))
st

projection (st)
## projeção: WGS84


# Dados climáticos do mundo todo. Precisa juntar tudo num mapa só e plotar os pontos nesse mapa.
raster::plot(st[[1:2]], col = viridis::viridis(10))



require(dismo)
require (raster)


#######################################################################
# Tudo abaixo  deu certo!

# Files dos dados climáticos da América Latina
files <- list.files(path=paste(system.file(package="dismo"),
                                 '/ex', sep=''), pattern='grd', full.names=TRUE )


files
projection (files)

predictors <- stack(files)
 predictors
#projeção: WGS84
 
 
 names (predictors)

 plot (predictors)

 
 ##Plotar dados dos pontos no mapa com todas as variáveis climáticas
 
library(maptools)
data(wrld_simpl)
 file <- paste(system.file(package="dismo"), "lobo_sp", sep="") # Colocar os dados de lobo no lugar de bradypus.csv
 

#And now plot:
  # first layer of the RasterStack
  plot(predictors, 1)
  
# note the "add=TRUE" argument with plot
  plot(wrld_simpl, add=TRUE)

  # Plotar pontos no mapa de bioclimáticas
  
 
  lobo_points<- lobo_sp %>% 
    sf::st_as_sf(coords = c("LONG_X", "LAT_Y"), crs = 4326)
  lobo_points
  
  projection (lobo_points)
  
  plot(lobo_points$geometry, pch = 20, col = "blue", add = TRUE)
   
  #Agora precisa aumentar a resolução
   
 
   


  

   
 
   
   
   
  
