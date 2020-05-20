# partial linear fit 
lm_part_br <- covidbr %>%
  group_by(semanaEpi) %>% 
  mutate(fit = map(data, ~ lm(obitosAcumulado ~ occday), data = .x),
         aux = map(fit, tidy)) %>% 
  unnest(aux) %>% 
  distinct(semanaEpi, term, estimate) %>% 
  spread(key = term, value = estimate) %>%
  rename(interceptFull = `(Intercept)`, occdayFull = occday) %>% 
  # base1a7 (sunday to saturday of each week)
  left_join(.,
            covidbr %>% 
              group_by(semanaEpi) %>% 
              filter(!is.na(obitos1a7)) %>% 
              mutate(fit = map(data, ~ lm(obitos1a7 ~ occday), data = .x),
                     aux = map(fit, tidy)) %>% 
              unnest(aux) %>% 
              distinct(semanaEpi, term, estimate) %>% 
              spread(key = term, value = estimate) %>%
              rename(intercept1a7 = `(Intercept)`, occday1a7 = occday),
            by = "semanaEpi") %>% 
  # base2a7 (monday to saturday of each week)
  left_join(.,
            covidbr %>% 
              group_by(semanaEpi) %>% 
              filter(!is.na(obitos2a7)) %>% 
              mutate(fit = map(data, ~ lm(obitos2a7 ~ occday), data = .x),
                     aux = map(fit, tidy)) %>% 
              unnest(aux) %>% 
              distinct(semanaEpi, term, estimate) %>% 
              spread(key = term, value = estimate) %>%
              rename(intercept2a7 = `(Intercept)`, occday2a7 = occday),
            by = "semanaEpi") %>% 
  # base3a7 (tuesday to saturday of each week)
  left_join(.,
            covidbr %>% 
              group_by(semanaEpi) %>% 
              filter(!is.na(obitos3a7)) %>% 
              mutate(fit = map(data, ~ lm(obitos3a7 ~ occday), data = .x),
                     aux = map(fit, tidy)) %>% 
              unnest(aux) %>% 
              distinct(semanaEpi, term, estimate) %>% 
              spread(key = term, value = estimate) %>%
              rename(intercept3a7 = `(Intercept)`, occday3a7 = occday),
            by = "semanaEpi")

# predict for today
y <- yday(today())-yday("2020-02-26")+1
lm_part_br %>% 
  mutate(predFull = interceptFull + occdayFull * y,
         pred1a7 = intercept1a7 + occday1a7 * y,
         pred2a7 = intercept2a7 + occday2a7 * y,
         pred3a7 = intercept3a7 + occday3a7 * y)
  
  
