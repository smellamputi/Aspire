function glplusSevenDateFmtFnc()
{
var date = new Date();
plusSeven = new Date(date.setDate(date.getDate() + 7));
var dateFormated;

dateFormated =
  plusSeven.getFullYear() + '/' + (plusSeven.getMonth() + 1) + '/' + plusSeven.getDate();

//alert(dateFormated);
return dateFormated;
}

//glplusSevenDateFmtFnc();