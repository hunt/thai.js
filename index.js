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

function number_format(number, decimals, dec_point, thousands_sep) {
  // borrow from : http://phpjs.org/functions/number_format/
  /* istanbul ignore next */
  number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + (Math.round(n * k) / k)
        .toFixed(prec);
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n))
    .split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '')
    .length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1)
      .join('0');
  }
  return s.join(dec);
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
    if(typeof date == 'string'){
      date = new Date(date);
    }
    var token = ['full', 'Y', 'y', 'F', 'f', 'd', 'DD', 'D', 'L', 'l', 'HH', 'H', 'i', 's'];
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
  },
  number: function(number){
    output = '';
    if(typeof number == 'number') number = number_format(number);
    for (var i=0; i<number.length; i++) {
      if(thai_number.number[number[i]])
        output += thai_number.number[number[i]];
      else
        output += number[i];
    }
    return output;
  },
  number_to_text: function(number, glue){
    var output = [];
    if(typeof glue == 'undefined') glue = '';
    if(typeof number == 'number') number = number.toString();
    if(number.length>6){
      m = number.length/6
      mil = Math.ceil(m);
      for (var i=mil; i>0; i--){
        if(number.length%6 != 0){start = number.length % 6}
        else{start = 6}
        x = number.substring(0,start)
        output.push(Thai.number_to_text(x, glue))
        if(i != 1) output[output.length-1] += 'ล้าน';
        number = number.substring(start)
      }

    }else{
      for (var i=0; i<number.length; i++) {

        if(i==number.length-1 && number[i] == 1 && number.length > 1){
          output[output.length-1] += 'เอ็ด'
        }else if(i==number.length-2 && number[i] == 1){
          output.push('สิบ');
        }else if(i==number.length-2 && number[i] == 2){
          output.push('ยี่สิบ');
        }else if(number[i] == 0){

        }else{
          output.push(thai_number.text[number[i]]+thai_number.position[number.length-i-1]);
        }
      }
    }
    return output.join(glue);
  }
};

module.exports = Thai;
