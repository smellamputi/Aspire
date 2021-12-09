function getGLRatePrecision(rate){

var precisionrate;

if (rate == Math.floor(rate)) 
{
//alert("Whole Number :" + rate);
precisionrate = rate.toString();
return precisionrate;
}
else 
{
var y = rate.toFixed(10);
var parts = rate.toString().split('.');
var z = parts[1].length;
//alert("Decimal Number :"+rate);
if(z > 10)
{
    precisionrate = y.toString();
    return precisionrate;
}
else
{
    precisionrate = rate.toString();
    return precisionrate;
}
}

return precisionrate;
//alert(precisionrate);
}

//getGLRatePrecision(10.865356456556)
