Thai = require '../'
should = require 'should'

describe 'Date Formatting', ->
  mock = 
    hunt: "06/07/1987"
    por: "06/27/1990"

  it 'Default date (now)', ->
    should(Thai.date('full')).be.a.string

  it 'Full (full)', ->
    should(Thai.date(new Date(mock.hunt), 'full')).be.a.string
    should(Thai.date(new Date(mock.hunt), 'full')).be.eql 'วันอาทิตย์ที่ 7 มิถุนายน พ.ศ. 2530'

  it 'Date (d)', ->
    should(Thai.date('d')).be.a.number

  it 'Hours (H,HH)', ->
    d = new Date mock.por
    d.setHours 1, 0
    should(Thai.date(d, 'H')).be.a.number
    should(Thai.date(d, 'H')).have.length 1
    should(Thai.date(d, 'HH')).be.a.string
    should(Thai.date(d, 'HH')).have.length 2
    d.setHours 11, 0
    should(Thai.date(d, 'H')).be.a.number
    should(Thai.date(d, 'H')).have.length 2
    should(Thai.date(d, 'HH')).be.a.string
    should(Thai.date(d, 'HH')).have.length 2

  it 'Minutes (i)', ->
    d = new Date mock.por
    d.setHours 1, 7
    should(Thai.date(d, 'i')).be.a.string
    should(Thai.date(d, 'i')).have.length 2

  it 'Seconds (s)', ->
    d = new Date mock.por
    d.setHours 1, 7, 7
    should(Thai.date(d, 's')).be.a.string
    should(Thai.date(d, 's')).have.length 2

  describe 'Year', ->
    it '+543', ->
      year = (new Date).getFullYear()
      should(Thai.date('Y')).be.eql (year+543).toString()

    it 'Long (Y)', ->
      d = new Date mock.por
      should(Thai.date(d, 'Y')).be.a.string
      should(Thai.date(d, 'Y')).be.eql '2533'

    it 'Short (y)', ->
      d = new Date mock.por
      should(Thai.date(d, 'y')).be.a.string
      should(Thai.date(d, 'y')).be.eql '33'

  describe 'Month', ->
    it 'Long (F)', ->
      d = new Date mock.por
      for month in ['มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม', 'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม']
        should(Thai.date(d, 'F')).be.a.string
        should(Thai.date(d, 'F')).be.eql month
        d.setMonth(d.getMonth()+1)

    it 'Short (f)', ->
      d = new Date mock.por
      for month in ['มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.', 'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.']
        should(Thai.date(d, 'f')).be.a.string
        should(Thai.date(d, 'f')).be.eql month
        d.setMonth(d.getMonth()+1)

  describe 'Day', ->
    it 'Long (L)', ->
      d = new Date mock.hunt
      for day in ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัส', 'ศุกร์', 'เสาร์']
        should(Thai.date(d, 'L')).be.a.string
        should(Thai.date(d, 'L')).be.eql day
        d.setDate(d.getDate()+1)

    it 'Short (l)', ->
      d = new Date mock.hunt
      for day in ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.']
        should(Thai.date(d, 'l')).be.a.string
        should(Thai.date(d, 'l')).be.eql day
        d.setDate(d.getDate()+1)

