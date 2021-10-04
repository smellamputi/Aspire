function yearcheck(pstartdate,penddate) {
var startdate=pstartdate;
var startdtarray= startdate.split('-');
var enddate=penddate;
var enddtarray= enddate.split('-');
var yeardiff= enddtarray[0] - startdtarray[0];
var monthdiff= enddtarray[1] - startdtarray[1];
var daydiff= enddtarray[2] - startdtarray[2];
var check =0;

if(yeardiff > 1){
console.log(1);
check = 1;
return check;
}
else if(yeardiff == 1){
if(monthdiff>=1){
  console.log(1);
  check = 1;
return check;
  }
  else if(monthdiff == 0)
 {
 if(daydiff<=0){
 console.log(1);
check = 0;
return check;
 }
 else{
 console.log(0);
 check = 1;
return check;
 }
 }
 else {
  console.log(0); 
   check = 0;
return check;
 }  
}
else{
console.log(0);
 check = 0;
return check;
}
return check;
}