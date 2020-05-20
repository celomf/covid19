library(readxl)
library(lubridate)
library(tidyverse)
library(broom)
library(directlabels)
library(scales)

path <- "C:/Users/ferna/OneDrive/Documentos/R/covid19/data/HIST_PAINEL_COVIDBR_16jun2020.xlsx"
data0 <- read_excel(path)

excel_sheets(path) %>% set_names()

datagovbr <- data0 %>% 
  mutate_at(vars(semanaEpi:emAcompanhamentoNovos),
            funs(as.numeric(.))) %>% 
  mutate(data = as_datetime(data)) %>% 
  mutate(wday = wday(data), 
         occday = yday(data) - min(yday(data)) + 1,
         obitosDia = obitosAcumulado - lag(obitosAcumulado),
         obitos1a7 = ifelse(data == as.Date("2020-06-11") | # Corpus Christi
                            data == as.Date("2020-05-01") | # Labor day
                            data == as.Date("2020-05-02") | 
                            # data == as.Date("2020-05-04") | 
                            data == as.Date("2020-04-21") | # Tiradentes day
                            data == as.Date("2020-04-10") | # Good friday
                            data == as.Date("2020-04-11"), NA, obitosAcumulado),
         obitos1a7 = ifelse(occday < 21, NA, obitos1a7),
         obitos2a7 = ifelse(wday %in% c(1), NA, obitos1a7), #intercept_2a7
         obitos3a7 = ifelse(wday %in% c(1, 2), NA, obitos1a7), #intercept_3a7
         # semanaEpi = ifelse(semanaEpi == 21, NA, semanaEpi),
  )

covidbr <- datagovbr %>% 
  filter(regiao == "Brasil")

covidsp <- datagovbr %>% 
  filter(coduf == "35", is.na(codmun))

covidrj <- datagovbr %>% 
  filter(coduf == "33", is.na(codmun))
