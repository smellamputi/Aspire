function glMonthFirstDayFmtFnc()
{
var date = new Date();
var FirstDay = new Date(date.getFullYear(), date.getMonth(), 1);
var dateFormated;

dateFormated =
  FirstDay.getFullYear() +
  '/' +
  (FirstDay.getMonth() + 1) +
  '/' +
  FirstDay.getDate();

//alert(dateFormated);
return dateFormated;
}

//glMonthFirstDayFmtFnc()