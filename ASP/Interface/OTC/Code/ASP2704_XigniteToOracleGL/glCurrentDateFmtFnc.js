function glCurrentDateFmtFnc()
{
var date = new Date();
var dateFormated;

dateFormated =
  date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate();

//alert(dateFormated);
return dateFormated;
}

//glCurrentDateFmtFnc()