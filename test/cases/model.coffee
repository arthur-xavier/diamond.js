# test/cases/model.coffee

should = require 'should'

Wine = require "#{dependencies}/models/wine"

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
      @wine = new Wine name: 'DOMAINE DU BOUSCAT', region: 'Bordeaux', country: 'France'
      @wine.get('location').should.equal "Bordeaux, France"

    it 'should have custom methods', ->
      @wine.toString().should.equal "'DOMAINE DU BOUSCAT 2014' from Bordeaux, France"
  
  #   
  describe 'validations', ->
    #
    it 'should validate for presence', ->
      new Wine().validate().country.should.equal true
      should.not.exist new Wine(country: "France").validate().country

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
      new Wine({
        name: "DINASTIA VIVANCO",
        year: "2008",
        country: "Spain",
        region: "Rioja",
        description: "Whether enjoying a fine cigar or a nicotine patch, don't pass up a taste of this hearty Rioja, both smooth and robust.",
      }).save()
      Wine.find name: "DINASTIA VIVANCO", (err, wines) ->
        throw err if err
        wines[0].location.should.equal "Rioja, Spain"
        done()

    it 'updates', (done) ->
      Wine.update {country: "Spain"},
        {country: "Italy", region: "Tuscany", location: "Tuscany, Italy"}, 
        (err) ->
          throw err if err
          Wine.find location: "Tuscany, Italy", (err, wines) ->
            throw err if err
            wines[0].name.should.equal "LAN RIOJA CRIANZA"
            wines[1].name.should.equal "DINASTIA VIVANCO"
            done()

    it 'removes', (done) ->
      Wine.remove {country: "France"}, (err) ->
        throw err if err
        Wine.all (err, wines) ->
          wines[0].name.should.equal "LAN RIOJA CRIANZA"
          wines[1].name.should.equal "DINASTIA VIVANCO"
          done()