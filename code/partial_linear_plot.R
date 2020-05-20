# plot Brasil
covidbr %>%
  mutate(aux = obitos2a7) %>% 
  filter(occday >= 21) %>% 
  ggplot() + 
  geom_line(aes(x = data, y = obitosAcumulado), color = "green", cex = 1.1) +
  geom_smooth(aes(x = data, y = aux, group=semanaEpi), 
              method = "lm", se=FALSE, formula = y ~ x, fullrange = TRUE,
              color = "black", linetype = "dashed", alpha = 0.1, cex = 0.5) +
  geom_dl(aes(label = semanaEpi, x = data, y = aux), 
          method = list(dl.trans(x = x -.35, y = y + .47), "last.bumpup")) +
  geom_point(aes(x = data, y = aux)) +
  ylim(0, 23000) +
  scale_x_datetime(limits = ymd_h(c("2020-03-15 00", "2020-05-23 23"))) +
  geom_smooth(aes(x = data, y = aux),
              method = "glm", formula = y~x, fullrange=TRUE, se= FALSE,
              method.args = list(family = gaussian(link = 'log'))) 
# scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
#               labels = trans_format("log10", math_format(10^.x)))

# plot São Paulo state
covidsp %>%
  filter(semanaEpi > 11) %>% 
  ggplot() + 
  geom_line(aes(x = data, y = obitosAcumulado), color = "orange", cex = 1.1)+
  geom_smooth(aes(x = data, y = obitos2, group=semanaEpi), 
              method = "lm", se=FALSE, formula = y ~ x, fullrange = TRUE,
              color = "black", linetype = "dashed", alpha = 0.1, cex = 0.5)+
  geom_dl(aes(label = semanaEpi, x = data, y = obitos2), 
          method = list(dl.trans(x = x -.35, y = y + .35), "last.bumpup")) +
  geom_point(aes(x = data, y = obitos2)) +
  ylim(0, 6000) +
  geom_smooth(aes(x = data, y = obitos3),
              method = "glm", formula = y~x, fullrange=TRUE,
              method.args = list(family = gaussian(link = 'log')))

# plot Rio de Janeiro State
covidrj %>%
  filter(semanaEpi > 11) %>%  
  ggplot() + 
  geom_line(aes(x = data, y = obitosAcumulado), color = "purple", cex = 1.1)+
  geom_smooth(aes(x = data, y = obitos2, group=semanaEpi), 
              method = "lm", se=FALSE, formula = y ~ x, fullrange = TRUE,
              color = "black", linetype = "dashed", alpha = 0.1, cex = 0.5)+
  geom_dl(aes(label = semanaEpi, x = data, y = obitos2), 
          method = list(dl.trans(x = x -.35, y = y + .35), "last.bumpup")) +
  geom_point(aes(x = data, y = obitos2)) +
  ylim(0, 3000) 
  

