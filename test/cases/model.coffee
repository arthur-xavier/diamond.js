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

    #
    it 'should have default properties', ->
      @wine.get('description').should.equal ''
      @wine.get('year').should.equal new Date().getFullYear()

    #
    it 'should have computed properties', ->
      @wine = new Wine name: 'DOMAINE DU BOUSCAT', city: 'Bordeaux', country: 'France'
      @wine.get('location').should.equal "Bordeaux, France"

    #
    it 'should have custom methods', ->
      @wine.toString().should.equal "'DOMAINE DU BOUSCAT 2014' from Bordeaux, France"
  
  #   
  describe 'validations', ->
    #
    it 'should validate for presence', ->
      new Wine().validate().country.should.equal true
      should.not.exist new Wine(country: "France").validate().country

    #
    it 'should validate for RegExp patterns', ->
      new Wine(name: "1NV4L1D W1N3").validate().name.should.equal true
      should.not.exist new Wine(name: 'DOMAINE DU BOUSCAT').validate().name

    #
    it 'should validate with functions', ->
      new Wine(year: 1995).validate().name.should.equal true
      should.not.exist new Wine().validate().year