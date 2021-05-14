function glnextDateFmtFnc(i)
{
var date = new Date();
date.setDate(date.getDate() + i);
var dateFormated;

dateFormated =
  date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate();

//alert(dateFormated);
return dateFormated;
}

//glnextDateFmtFnc(i);