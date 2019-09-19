library(tidyverse)
library(readr)

posicoes <- readr::fwf_positions(start = c(1,41,43), end = c(40, 42, 47), c("nome", "tipo", "tamanho"))

ref_raw <- readr::read_fwf("MUNICIP.REF", col_positions = posicoes)

ref <- ref_raw %>%
  mutate(nome = str_sub(nome, start = 4),
         posicoes_finais = cumsum(tamanho),
         posicoes_iniciais = posicoes_finais - as.numeric(tamanho) + 1)


arq <- read_fwf("MUNICIP.TXT", 
                col_positions = fwf_positions(start     = ref$posicoes_iniciais,
                                              end       = ref$posicoes_finais,
                                              col_names = ref$nome))

write.csv2(arq, "tabela_municipios.csv")



