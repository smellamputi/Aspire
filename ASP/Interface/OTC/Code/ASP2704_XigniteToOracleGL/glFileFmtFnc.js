function glFileFmtFnc()
{
var date = new Date();
var dateFormated;

dateFormated =
  date.getFullYear() + '' + (date.getMonth() + 1) + '' + date.getDate() + '' + date.getHours() + '' + date.getMinutes() + '' + date.getSeconds();

//alert(dateFormated);
return dateFormated;
}

//glFileFmtFnc()