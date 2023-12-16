/// AIdistCheck([object],[spacing],[maxReturnedValue])
// checks if specified object is a certain distance away, and returns appropriate value
// based on and defaults to MM4 distance checker function
// if specified object doesn't exist, returns random value

var object = target;
if(argument_count >= 1) object = argument[0];
var spacing = 64;
if(argument_count >= 2) spacing = argument[1];
var maxReturnedValue = 2;
if(argument_count >= 3) maxReturnedValue = argument[2];

if(instance_exists(object)) return min(floor(abs(x-object.x)/spacing),maxReturnedValue);
else return irandom_range(0,maxReturnedValue);

