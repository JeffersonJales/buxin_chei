// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function draw_pie(_x		= x, 
				  _y		= y,
				  _value	= 1, 
				  _max		= 100, 
				  _col		= c_white, 
				  _rad_w	= 10,
				  _rad_h	= 5, 
				  _alpha	= 1) {

	
	if (_value > 0) { 
		
		var i, len, tx, ty, val;
	    var numberofsections	= 60 
	    var sizeofsection			= 360/numberofsections
    
		val = (_value/_max) * numberofsections 
    
    if (val > 1) { 
			
      draw_set_colour(_col);
      draw_set_alpha(_alpha);
        
      draw_primitive_begin(pr_trianglefan);
      draw_vertex(_x, _y);
        
      for(i=0; i<=val; i++) {
				
        len = (i*sizeofsection)-90; 
        tx  = lengthdir_x(_rad_w, len);
        ty  = lengthdir_y(_rad_h, len);
        draw_vertex(_x+tx, _y+ty);
      
			}
				
      draw_primitive_end();
        
    }
		
    draw_set_alpha(1);
		
	}
}

function draw_pie_reverse(_x	 = x, 
						  _y	 = y,
						  _value = 1, 
						  _max	 = 100, 
						  _col	 = c_white, 
						  _rad_w = 10,
						  _rad_h = 5, 
						  _alpha = 1) {
						  
	
	if (_value > 0) { 
		
		var i, len, tx, ty, val;
	    var numberofsections	= 60 
	    var sizeofsection		= 360/numberofsections
    
    val = (_value/_max) * numberofsections 
    
    if (val > 1) { 
			
      draw_set_colour(_col);
      draw_set_alpha(_alpha);
        
      draw_primitive_begin(pr_trianglefan);
      draw_vertex(_x, _y);
        
      for(i=0; i<=val; i++) {
				
        len = -((i*sizeofsection)-90); 
        tx  = lengthdir_x(_rad_w, len);
        ty  = lengthdir_y(_rad_h, len);
        draw_vertex(_x+tx, _y+ty);
      
			}
				
      draw_primitive_end();
        
    }
		
    draw_set_alpha(1);
		
	}
}