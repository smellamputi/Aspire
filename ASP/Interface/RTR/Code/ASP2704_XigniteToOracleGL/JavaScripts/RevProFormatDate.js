function RevProFormatDate(date) {
var d = new Date(date),
month = '' + (d.getMonth() + 1),
day = '' + d.getDate(),
year = d.getFullYear();

 if (month.length < 2) month = '0' + month;
if (day.length < 2) day = '0' + day;

 newformat = [month,day,year].join('/');
return newformat;
}

// alert(formatDate('2021/12/31'));