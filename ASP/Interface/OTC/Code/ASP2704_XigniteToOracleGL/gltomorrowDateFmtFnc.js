function gltomorrowDateFmtFnc()
{
var date = new Date();
var tomorrow = new Date(date.getTime() + (24 * 60 * 60 * 1000));
var dateFormated;

dateFormated =
  tomorrow.getFullYear() + '/' + (tomorrow.getMonth() + 1) + '/' + tomorrow.getDate();

//alert(dateFormated);
return dateFormated;
}

//gltomorrowDateFmtFnc()