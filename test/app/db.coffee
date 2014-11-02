# app/db.coffee

Wine = require './models/wine'

Wine.remove()

wines = [{
    name: "CHATEAU DE SAINT COSME"
    year: "2009"
    country: "France"
    region: "Southern Rhone"
    description: "The aromas of fruit and spice give one a hint of the light drinkability of this lovely wine, which makes an excellent complement to fish dishes.",
  },
  {
    name: "LAN RIOJA CRIANZA"
    year: "2006"
    country: "Spain"
    region: "Rioja"
    description: "A resurgence of interest in boutique vineyards has opened the door for this excellent foray into the dessert wine market. Light and bouncy, with a hint of black truffle, this wine will not fail to tickle the taste buds.",
  }]

wines.forEach (wine) ->
  new Wine(wine).save()
