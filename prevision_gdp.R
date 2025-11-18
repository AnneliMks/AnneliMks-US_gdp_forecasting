#import des librairies
library(dplyr)
library(ggplot2)
library(forecast)
library(tseries)
library(urca)
library(patchwork)


rm(list= ls())

#Analyse gdp US
gdp_us <- read.csv("gdp_us.csv", header = T)
gdp_us

gdp_us$Date <- as.Date(gdp_us$Date)
colnames(gdp_us) <- c("Date","gdp")

gdp_us <- gdp_us %>%
  mutate(d_gdp = 100 * (gdp / lag(gdp, n = 4) - 1))


ts_gdpus <- ts(gdp_us$gdp, start = c(1947, 01), frequency = 4)
ts_gdpus
autoplot(ts_gdpus)

log_gdpus <- ts(log(gdp_us$gdp), start = c(1947,01), frequency = 4)
autoplot(log_gdpus)


d_gdpus <- ts(na.omit(gdp_us$d_gdp), start = c(1948,01), frequency = 4)
autoplot(d_gdpus)

windows()
par(mfrow = c(3,2))
acf(ts_gdpus, main = "ACF du PIB américain")
pacf(ts_gdpus, main = "PACF du PIB américain")
acf(log_gdpus, main = "ACF du log du  PIB américain")
pacf(log_gdpus, main = "PACF du log PIB américain")
acf(d_gdpus, main = "ACF du taux de croissance américain")
pacf(d_gdpus, main = "PACF du taux de croissance américain")

#On observe que pour les séries ts_gdpus et log_gdp la décroissance des ACF est très lente => pas stationnaire
#en revanche en ce qui concerne le taux de croissance il semblerait que ce soit stationnaire

#test de stationnarité

#test de Dickey-Fuller
adf.test(ts_gdpus)
adf.test(log_gdpus)
adf.test(d_gdpus)

#test de Phillips Perron
pp.test(ts_gdpus)
pp.test(log_gdpus)
pp.test(d_gdpus)

#test avec constant, trend

summary(ur.df(ts_gdpus, type="trend", lags=8))
summary(ur.df(ts_gdpus, type="drift", lags=8))
summary(ur.df(ts_gdpus, type="none", lags=8))

summary(ur.df(d_gdpus, type="trend", lags=8)) #on voit que c'est stationnaire mais quand même limite
summary(ur.df(d_gdpus, type="drift", lags=8)) 

par(mfrow = c(1,1))

ggplot(gdp_us, aes(x = Date, y = d_gdp)) +
  geom_line() +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Croissance du GDP US", y = "d_gdp", x = "Année")

ggseasonplot(d_gdpus, type = "polar") #pas de saisonnalité


#Model

model1 = auto.arima(ts_gdpus)
summary(model1)
model2 = auto.arima(log_gdpus)
summary(model2)
model3 = auto.arima(d_gdpus)
summary(model3)

#On regarde les résidus et on vérifie la présence d'auto-corrélation

checkresiduals(model1)
checkresiduals(model2)
checkresiduals(model3)

#les résidus des model 1 et 3 ne sont pas parfaitement blancs 

#Prévision 

h = 12
prev1 = forecast(model1, h = h)
prev2 = forecast(model2, h=h)
prev3 = forecast(model3, h=h)

windows()
par(mfrow = c(3,1))
plot(prev1, main="Prévision pour le PIB américain brut")
plot(prev2, main="Prévision pour le PIB américain (log)")
plot(prev2, main="Prévision de la croissance")

fitted(prev1)


par(mfrow = c(1,1))

#test des model out sample/in sample

train1 <- window(ts_gdpus, end=c(2021,4))
test1 <- window(ts_gdpus, start=c(2022,1))

model1_train <- auto.arima(train1)

oos1 <- forecast(model1_train, length(test1))


train2 <- window(log_gdpus, end=c(2021,4))
test2 <- window(log_gdpus, start=c(2022,1))

model2_train <- auto.arima(train2)

oos2 <- forecast(model2_train, length(test2))


train3 <- window(d_gdpus, end=c(2021,4))
test3 <- window(d_gdpus, start=c(2022,1))

model3_train <- auto.arima(train3)

oos3 <- forecast(model3_train, length(test3))


m1 <- autoplot(ts_gdpus, series = "Evolution observé du PIB américain")+
  autolayer(oos1, series = "Prévision du PIB a partir du second semestre 2022")+
  xlab("Année") + ylab("PIB")+
  ggtitle("Comparaison réelle VS prévision")+
  scale_colour_manual(values = c("black", "blue"))

m2 <- autoplot(log_gdpus, series = "Evolution observé du PIB américain (log)")+
  autolayer(oos2, series = "Prévision du PIB (log)a partir du second semestre 2022")+
  xlab("Année") + ylab("PIB")+
  ggtitle("Comparaison réelle VS prévision")+
  scale_colour_manual(values = c("black", "blue"))

m3 <- autoplot(d_gdpus, series = "Evolution observé de la croissance aux EUA")+
  autolayer(oos3, series = "Prévision de la croissance a partir du second semestre 2022", PI = F)+
  xlab("Année") + ylab("croissance")+
  ggtitle("Comparaison réelle VS prévision")+
  scale_colour_manual(values = c("black", "blue"))

m1/m2/m3
