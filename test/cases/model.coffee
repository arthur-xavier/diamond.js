# test/cases/model.coffee

should = require 'should'

Wine = require "#{dependencies}/models/wine"
Region = require "#{dependencies}/models/region"

describe 'Model', ->

  #
  describe 'properties', ->
    #
    it 'should have properties', ->
      @wine = new Wine name: 'Test'
      @wine.get('name').should.equal 'Test'
    
    it 'should have default properties', ->
      @wine.get('description').should.equal ''
      @wine.get('year').should.equal new Date().getFullYear()

    it 'should have computed properties', ->
      @region = new Region name: 'Bordeaux', country: 'France'
      @region.get('location').should.equal "Bordeaux, France"

    it 'should have custom methods', ->
      @region.toString().should.equal "Bordeaux, France"

    it 'should have other models as properties', ->
      @wine = new Wine name: 'DOMAINE DU BOUSCAT', region: @region
      @wine.get('region.location').should.equal "Bordeaux, France"
  
  #   
  describe 'validations', ->
    #
    it 'should validate for presence', ->
      new Wine().validate().region.should.equal true
      should.not.exist new Wine(region: new Region country: 'France').validate().country

    it 'should validate for RegExp patterns', ->
      new Wine(name: "1NV4L1D W1N3").validate().name.should.equal true
      should.not.exist new Wine(name: 'DOMAINE DU BOUSCAT').validate().name

    it 'should validate with functions', ->
      new Wine(year: 1995).validate().name.should.equal true
      should.not.exist new Wine().validate().year

  #
  describe 'storage', ->
    #
    it 'finds all', (done) ->
      Wine.all (err, wines) ->
        throw err if err
        wines[0].name.should.equal "CHATEAU DE SAINT COSME"
        wines[1].name.should.equal "LAN RIOJA CRIANZA"
        done()

    it 'counts', (done) ->
      Wine.count (err, count) ->
        throw err if err
        count.should.equal 2
        done()

    it 'finds by query', (done) ->
      Wine.find year: 2009, (err, wines) ->
        throw err if err
        wines[0].name.should.equal "CHATEAU DE SAINT COSME"
        done()

    it 'finds by id', ->
      # works from assertion. Find by query works

    it 'saves', (done) ->
      rioja = new Region name: 'Rioja', country: 'Spain'
      new Wine({
        name: "Dinastia Vivanco",
        year: "2008",
        region: rioja,
        description: "Whether enjoying a fine cigar or a nicotine patch, don't pass up a taste of this hearty Rioja, both smooth and robust.",
      }).save()
      Wine.find name: "DINASTIA VIVANCO", (err, wines) ->
        throw err if err
        wines[0].region.should.equal "Rioja, Spain"
        done()

    it 'updates', (done) ->
      Wine.update {region: "Rioja, Spain"},
        {region: "Tuscany, Italy"}, 
        (err) ->
          throw err if err
          Wine.find region: "Tuscany, Italy", (err, wines) ->
            throw err if err
            wines[1].name.should.equal "LAN RIOJA CRIANZA"
            wines[0].name.should.equal "DINASTIA VIVANCO"
            done()

    it 'removes', (done) ->
      Wine.remove {region: "Southern Rhone, France"}, (err) ->
        throw err if err
        Wine.all (err, wines) ->
          wines[1].name.should.equal "LAN RIOJA CRIANZA"
          wines[0].name.should.equal "DINASTIA VIVANCO"
          done()

    it 'fetches models', (done) ->
      verify = (wines) ->
        wine.region.country.should.equal "Italy" for wine in wines
        done()

      Wine.find region: "Tuscany, Italy", (err, wines) ->
        throw err if err
        wines.forEach (wine, i) ->
          Region.find location: wine.region, (err, regions) ->
            throw err if err
            wines[i].region = regions[0]
            verify wines if i == wines.length - 1
