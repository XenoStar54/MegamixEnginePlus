/// powerOfTwo(number, [...])
// returns a power of two that is closest to the given numbers while being equal to or greater than the greatest number.

// get highest number
for (_i = 0; _i < argument_count; _i++)
{
    if (_i == 0)
    {
        _number = argument[_i];
    }
    else if (_number < argument[_i])
    {
        _number = argument[_i];
    }
}

_powerOfTwo = 2;
while (_powerOfTwo < _number)
{
    _powerOfTwo *= 2;
}

return _powerOfTwo;
