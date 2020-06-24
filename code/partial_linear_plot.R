# plot Brasil
covidbr %>%
<<<<<<< HEAD
  mutate(aux = ifelse(semanaEpi == 26 | semanaEpi < 22, NA, obitos2a7),
         semanaEpi = ifelse(semanaEpi == 26 | semanaEpi < 22, NA, semanaEpi)) %>% 
=======
  mutate(aux = obitos2a7) %>% 
>>>>>>> 4b3484a81494b49ef9fa39bf4000fd39cf10e5f5
  filter(occday >= 21) %>% 
  ggplot() + 
  geom_line(aes(x = data, y = obitosAcumulado), color = "green", cex = 1.1) +
  geom_smooth(aes(x = data, y = aux, group=semanaEpi), 
              method = "lm", se=FALSE, formula = y ~ x, fullrange = TRUE,
              color = "black", linetype = "dashed", alpha = 0.1, cex = 0.5) +
  geom_dl(aes(label = semanaEpi, x = data, y = aux), 
          method = list(dl.trans(x = x -.35, y = y + .47), "last.bumpup")) +
  geom_point(aes(x = data, y = aux)) +
<<<<<<< HEAD
  ylim(0, 56000) +
  scale_x_datetime(limits = ymd_h(c("2020-03-15 00", "2020-06-25 23"))) +
  # geom_smooth(aes(x = data, y = aux),
  #             method = "glm", formula = y~x, fullrange=TRUE, se= FALSE,
  #             method.args = list(family = gaussian(link = 'log'))) +
  geom_point(aes(x = ymd_h("2020-06-23 00"), y = 52524), colour="blue", size = 2.2) +
# scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
#               labels = trans_format("log10", math_format(10^.x))) +
coord_cartesian(ymd_h(c("2020-05-25 00", "2020-06-25 23")),
                ylim = c(20000, 56000))
=======
  ylim(0, 23000) +
  scale_x_datetime(limits = ymd_h(c("2020-03-15 00", "2020-05-23 23"))) +
  geom_smooth(aes(x = data, y = aux),
              method = "glm", formula = y~x, fullrange=TRUE, se= FALSE,
              method.args = list(family = gaussian(link = 'log'))) 
# scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
#               labels = trans_format("log10", math_format(10^.x)))
>>>>>>> 4b3484a81494b49ef9fa39bf4000fd39cf10e5f5

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
  

