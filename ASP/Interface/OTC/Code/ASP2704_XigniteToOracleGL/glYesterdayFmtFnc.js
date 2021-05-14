function glYesterdayFmtFnc()
{
var date = new Date();
var yesterdayDate = new Date(date);
var dateFormated;

yesterdayDate.setDate(yesterdayDate.getDate() - 1);

dateFormated =
  yesterdayDate.getFullYear() +
  '/' +
  (yesterdayDate.getMonth() + 1) +
  '/' +
  yesterdayDate.getDate();

//alert(yesterdayDate.toDateString());
return dateFormated;
}

//glYesterdayFmtFnc()