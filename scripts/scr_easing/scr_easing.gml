function scr_wave_animation(_min = 0, _max = 1, _spd = 1, _offset = 0, _based = current_time * 0.001) {
 
 
    // Returns a value that will wave back and forth between [from-to] over [duration] seconds
    // Examples
    //      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
    //      x = Wave(-10,10,0.25,0)         -> move left and right quickly
 
    // Or here is a fun one! Make an object be all squishy!! ^u^
    //      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
    //      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
 
    a4 = (_max - _min) * 0.5;
    return _min + a4 + sin((((_based) + _spd * _offset) / _spd) * (pi* 2)) * a4;
}