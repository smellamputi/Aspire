function glMonthLastDayFmtFnc()
{
var date = new Date();
var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
var dateFormated;

dateFormated =
  lastDay.getFullYear() +
  '/' +
  (lastDay.getMonth() + 1) +
  '/' +
  lastDay.getDate();

//alert(dateFormated);
return dateFormated;
}

//glMonthLastDayFmtFnc()