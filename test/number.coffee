Thai = require '../'

describe 'Number Formatting', ->
  it 'Number to Thai number', ->
    expect(Thai.number(1000)).be.a.string
    expect(Thai.number(1000)).be.eql '๑,๐๐๐'
    expect(Thai.number(1000000)).be.eql '๑,๐๐๐,๐๐๐'

describe 'Number to Thai text', ->
  it '1 corrected', ->
    expect(Thai.number_to_text(1,' ')).be.eql 'หนึ่ง'
  it '2 corrected', ->
    expect(Thai.number_to_text(2,' ')).be.eql 'สอง'
  it '10 corrected', ->
    expect(Thai.number_to_text(10,' ')).be.eql 'สิบ'
  it '11 corrected', ->
    expect(Thai.number_to_text(11,' ')).be.eql 'สิบเอ็ด'
  it '20 corrected', ->
    expect(Thai.number_to_text(20,' ')).be.eql 'ยี่สิบ'
  it '21 corrected', ->
    expect(Thai.number_to_text(21,' ')).be.eql 'ยี่สิบเอ็ด'
  it '22 corrected', ->
    expect(Thai.number_to_text(22,' ')).be.eql 'ยี่สิบสอง'
  it '555 corrected', ->
    expect(Thai.number_to_text(555,' ')).be.eql 'ห้าร้อย ห้าสิบห้า'
  it '432156 corrected', ->
    expect(Thai.number_to_text(432156,' ')).be.eql 'สี่แสน สามหมื่น สองพัน หนึ่งร้อย ห้าสิบหก'
  it '5102151 corrected', ->
    expect(Thai.number_to_text(5102151,' ')).be.eql 'ห้าล้าน หนึ่งแสน สองพัน หนึ่งร้อย ห้าสิบเอ็ด'
  it '11,345,678 corrected', ->
    expect(Thai.number_to_text(11345678,' ')).be.eql 'สิบเอ็ดล้าน สามแสน สี่หมื่น ห้าพัน หกร้อย เจ็ดสิบแปด'
  it '123,456,781,876,543 corrected', ->
    expect(Thai.number_to_text(123456781876543,' ')).be.eql 'หนึ่งร้อย ยี่สิบสามล้าน สี่แสน ห้าหมื่น หกพัน เจ็ดร้อย แปดสิบเอ็ดล้าน แปดแสน เจ็ดหมื่น หกพัน ห้าร้อย สี่สิบสาม'
