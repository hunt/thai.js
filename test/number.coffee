Thai = require '../'
should = require 'should'

describe 'Number Formatting', ->
  it 'Number to Thai number', ->
    should(Thai.number(1000)).be.a.string
    should(Thai.number(1000)).be.eql '๑,๐๐๐'
    should(Thai.number(1000000)).be.eql '๑,๐๐๐,๐๐๐'

describe 'Number to Thai text', ->
  it '1 corrected', ->
    should(Thai.number_to_text(1,' ')).be.eql 'หนึ่ง'
  it '2 corrected', ->
    should(Thai.number_to_text(2,' ')).be.eql 'สอง'
  it '10 corrected', ->
    should(Thai.number_to_text(10,' ')).be.eql 'สิบ'
  it '11 corrected', ->
    should(Thai.number_to_text(11,' ')).be.eql 'สิบเอ็ด'
  it '20 corrected', ->
    should(Thai.number_to_text(20,' ')).be.eql 'ยี่สิบ'
  it '20 corrected', ->
    should(Thai.number_to_text(21,' ')).be.eql 'ยี่สิบเอ็ด'
  it '12,345,678 corrected', ->
    should(Thai.number_to_text(12345678,' ')).be.eql 'สิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด'


