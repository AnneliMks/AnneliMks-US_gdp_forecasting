# Projet de prévision du PIB américain

## Description
Projet personnel simple sur séries temporelles pour prévoir le PIB des États-Unis.  
Les données utilisées proviennent de la [Federal Reserve Bank of St. Louis](https://fred.stlouisfed.org/).

## Prérequis
- R 4.3.1
- Bibliothèques utilisées : dplyr, ggplot2, forecast, tseries, urca, patchwork

## Utilisation
Le code s'exécute simplement en une fois. Plusieurs fenêtres contenant des graphiques s'ouvriront automatiquement pour visualiser les séries temporelles et les prévisions.

## Structure du projet
1. Import et préparation des données.  
2. Visualisation. 
3. Tests de stationnarité (ADF, Phillips-Perron, KPSS).  
4. Modélisation avec ARIMA et auto.arima.  
5. Vérification des résidus et diagnostic du modèle.  
6. Prévision et comparaison in-sample / out-of-sample.

## Résultats

#### *Tests in-sample et out-of-sample*
- Le modèle qui fonctionne le mieux est celui construit sur le log du PIB.  
- Le modèle sur le PIB original suit bien les variations mais a tendance à sous-estimer légèrement les valeurs.  
- Le modèle sur la croissance trimestrielle suit la tendance descendante, mais les prévisions restent correctes.  
- Seul le modèle avec les logs présente des résidus proches d’un bruit blanc, signe d’une bonne adéquation.

#### *Prévisions*
- Le PIB américain continue sa progression ascendante, mais de manière relativement modérée.  
- La croissance trimestrielle reste positive mais faible.

## Auteure
[@AnneliMks](https://github.com/AnneliMks)

------------------------------------------------------------------------------------------------------------------

# US GDP Forecasting Project

## Description
Simple personal project on time series for forecasting US GDP.  
Data source: [Federal Reserve Bank of St. Louis](https://fred.stlouisfed.org/).

## Requirements
- R 4.3.1
- Libraries used: dplyr, ggplot2, forecast, tseries, urca, patchwork

## Usage
The code runs in one go. Multiple windows with charts will open automatically to visualize the time series and forecasts.

## Project Structure
1. Data import and preparation.  
2. Visualization. 
3. Stationarity tests (ADF, Phillips-Perron, KPSS).  
4. Modeling with ARIMA and auto.arima.  
5. Residuals check and model diagnostics.  
6. Forecasting and in-sample / out-of-sample comparison.

## Results

#### *In-sample and out-of-sample tests*
- The model that works best is the one built on the log of GDP.  
- The model on the original GDP follows the variations well but tends to slightly underestimate the values.  
- The model on quarterly growth follows the downward trend, but the forecasts remain adequate.  
- Only the log-based model shows residuals close to white noise, indicating a good fit.

#### *Forecasts*
- The U.S. GDP continues its upward progression, but in a relatively moderate manner.  
- Quarterly growth remains positive but weak.
## Author
[@AnneliMks](https://github.com/AnneliMks)
