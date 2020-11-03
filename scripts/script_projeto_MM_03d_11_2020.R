

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


require(spatstat)

ppplobo_sp<-ppp(lobo_sp$LONG_X,lobo_sp$LAT_Y)
plot(ppplobo_sp)

summary (lobo_sp)
dim(lobo_sp)

# extrair os dados apenas de Puma concolor

puma_sp <- neo_sp[neo_sp$SPECIES == "Puma concolor", ]
puma_sp

ppppuma_sp<-ppp(puma_sp$LONG_X,puma_sp$LAT_Y)
plot(ppppuma_sp)

summary (puma_sp)
dim(puma_sp)


