var thai_date = {
  day: {
    short: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'],
    full: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัส', 'ศุกร์', 'เสาร์']
  },
  month: {
    short: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'],
    full: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม']
  }
};

var thai_number = {
  number: ['๐', '๑', '๒', '๓', '๔', '๕', '๖', '๗', '๘', '๙'],
  text: ['ศูนย์', 'หนึ่ง', 'สอง', 'สาม', 'สี่', 'ห้า', 'หก', 'เจ็ด', 'แปด', 'เก้า'],
  position: ['', 'สิบ', 'ร้อย', 'พัน', 'หมื่น', 'แสน', 'ล้าน']
}

function pad(n, p, c) {
    var pad_char = typeof c !== 'undefined' ? c : '0';
    var pad = new Array(1 + p).join(pad_char);
    return (pad + n).slice(-pad.length);
}

var date_token = {
  // date
  Y: function(date){
    return date.getFullYear()+543;
  },
  y: function(date){
    return (date.getFullYear()+543).toString().substring(2);
  },
  F: function(date){
    return thai_date.month.full[date.getMonth()]
  },
  f: function(date){
    return thai_date.month.short[date.getMonth()]
  },
  d: function(date){
    return date.getDay()
  },
  D: function(date){ return date.getDate() },
  DD: function(date){ return pad(date.getDate(),2) },
  L: function(date){
    return thai_date.day.full[date.getDay()]
  },
  l: function(date){
    return thai_date.day.short[date.getDay()]
  },
  full: function(date){
    return Thai.date(date, 'วันLที่ D F พ.ศ. Y')
  },
  // time
  HH: function(date){ return pad(date.getHours(),2) },
  H: function(date){ return date.getHours() },
  i: function(date){ return pad(date.getMinutes(),2) },
  s: function(date){ return pad(date.getSeconds(),2) }
}

var Thai = {
  date: function(date, format){
    if(typeof format == 'undefined'){
      format = date;
      date = new Date;
    }
    var token = ['full', 'Y', 'y', 'F', 'f', 'd', 'D', 'DD', 'L', 'l', 'HH', 'H', 'i', 's'];
    var match = [];
    for (var i=0; i<token.length; i++) {
      if(format.indexOf(token[i]) > -1){
        match.push(token[i]);
      }
    }
    for (var i=0; i<match.length; i++) {
      format = format.replace(match[i], date_token[match[i]](date));
    }
    return format;
  }
};

module.exports = Thai;