# app/db.coffee

Wine = require './models/wine'
Region = require './models/region'

Wine.remove()
Region.remove()

regions = [
  { name: 'Southern Rhone', country: 'France' }
  { name: 'Rioja', country: 'Spain' }
  { name: 'Tuscany', country: 'Italy' }
]
new Region(region).save() for region in regions

wines = [
  {
    name: "CHATEAU DE SAINT COSME"
    year: "2009"
    region: "Southern Rhone, France"
    description: "The aromas of fruit and spice give one a hint of the light drinkability of this lovely wine, which makes an excellent complement to fish dishes.",
  },
  {
    name: "LAN RIOJA CRIANZA"
    year: "2006"
    region: "Rioja, Spain"
    description: "A resurgence of interest in boutique vineyards has opened the door for this excellent foray into the dessert wine market. Light and bouncy, with a hint of black truffle, this wine will not fail to tickle the taste buds.",
  }
]
new Wine(wine).save() for wine in wines
