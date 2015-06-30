Thai = require '../'
process.env.TZ = 'UTC'

describe 'Date Formatting', ->
  mock =
    hunt: "06/07/1987"
    por: "06/27/1990"

  it 'Default date (now)', ->
    expect(Thai.date('full')).be.a.string

  it 'Parse from JSON date', ->
    expect(Thai.date('2015-03-07T18:45:00','full')).be.a.string
    expect(Thai.date('2015-03-07T18:45:00','D F Y H:i น.')).be.eql '7 มีนาคม 2558 18:45 น.'
    expect(Thai.date('2015-03-07T18:45:00+0700','D F Y H:i น.')).be.eql '7 มีนาคม 2558 11:45 น.'

  it 'Full (full)', ->
    expect(Thai.date(new Date(mock.hunt), 'full')).be.a.string
    expect(Thai.date(new Date(mock.hunt), 'full')).be.eql 'วันอาทิตย์ที่ 7 มิถุนายน พ.ศ. 2530'

  it 'Date (D,DD)', ->
    expect(Thai.date('D')).be.a.number
    expect(Thai.date('DD')).be.a.string
    expect(Thai.date('DD')).have.length 2

  it 'Hours (H,HH)', ->
    d = new Date mock.por
    d.setHours 1, 0
    expect(Thai.date(d, 'H')).be.a.number
    expect(Thai.date(d, 'H')).have.length 1
    expect(Thai.date(d, 'HH')).be.a.string
    expect(Thai.date(d, 'HH')).have.length 2
    d.setHours 11, 0
    expect(Thai.date(d, 'H')).be.a.number
    expect(Thai.date(d, 'H')).have.length 2
    expect(Thai.date(d, 'HH')).be.a.string
    expect(Thai.date(d, 'HH')).have.length 2

  it 'Minutes (i)', ->
    d = new Date mock.por
    d.setHours 1, 7
    expect(Thai.date(d, 'i')).be.a.string
    expect(Thai.date(d, 'i')).have.length 2

  it 'Seconds (s)', ->
    d = new Date mock.por
    d.setHours 1, 7, 7
    expect(Thai.date(d, 's')).be.a.string
    expect(Thai.date(d, 's')).have.length 2

  describe 'Year', ->
    it '+543', ->
      year = (new Date).getFullYear()
      expect(Thai.date('Y')).be.eql (year+543).toString()

    it 'Long (Y)', ->
      d = new Date mock.por
      expect(Thai.date(d, 'Y')).be.a.string
      expect(Thai.date(d, 'Y')).be.eql '2533'

    it 'Short (y)', ->
      d = new Date mock.por
      expect(Thai.date(d, 'y')).be.a.string
      expect(Thai.date(d, 'y')).be.eql '33'

  describe 'Month', ->
    it 'Long (F)', ->
      d = new Date mock.por
      for month in ['มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม', 'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม']
        expect(Thai.date(d, 'F')).be.a.string
        expect(Thai.date(d, 'F')).be.eql month
        d.setMonth(d.getMonth()+1)

    it 'Short (f)', ->
      d = new Date mock.por
      for month in ['มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.', 'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.']
        expect(Thai.date(d, 'f')).be.a.string
        expect(Thai.date(d, 'f')).be.eql month
        d.setMonth(d.getMonth()+1)

  describe 'Day', ->
    it 'Number (d)', ->
      expect(Thai.date('d')).be.a.number

    it 'Long (L)', ->
      d = new Date mock.hunt
      for day in ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัส', 'ศุกร์', 'เสาร์']
        expect(Thai.date(d, 'L')).be.a.string
        expect(Thai.date(d, 'L')).be.eql day
        d.setDate(d.getDate()+1)

    it 'Short (l)', ->
      d = new Date mock.hunt
      for day in ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.']
        expect(Thai.date(d, 'l')).be.a.string
        expect(Thai.date(d, 'l')).be.eql day
        d.setDate(d.getDate()+1)
