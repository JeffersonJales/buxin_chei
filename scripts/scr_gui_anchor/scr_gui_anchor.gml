// Script Desc 

enum ANCHOR { 
	TOP_LEFT, TOP_CENTER, TOP_RIGHT, 
	CENTER_LEFT, CENTER, CENTER_RIGHT,
	BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT,
	NOONE
}

enum ALIGNMENT
{
	top=0, middle=1, bottom=2,
	left=0, center=1, right=2
}

function gui_anchor_init(){
	gui_anchor_pos_x = x;
	gui_anchor_pos_y = y;
}

function gui_anchor_ajust(){
	if(anchor == ANCHOR.NOONE) return;
	
	var _gw = display_get_gui_width(),
			_gh = display_get_gui_height(),
			_vw = VIEWPORT_WIDTH,
			_vh = VIEWPORT_HEIGHT,
			_vcx = _vw * 0.5, 
			_vcy = _vh * 0.5,
			_x = xstart, 
			_y = ystart;

	var _posx = [_x,    _gw/2-(_vcx-_x),    _gw-(_vw-_x)];
	var _posy = [_y,    _gh/2-(_vcy-_y),    _gh-(_vh-_y)];

switch(anchor){
	//Top
	case ANCHOR.TOP_LEFT:
			 x=_posx[ALIGNMENT.left];
			 y=_posy[ALIGNMENT.top];
			 break;
	case ANCHOR.TOP_CENTER:
			 x=_posx[ALIGNMENT.center];
			 y=_posy[ALIGNMENT.top];
			 break;
	case ANCHOR.TOP_RIGHT: 
			 x=_posx[ALIGNMENT.right];
			 y=_posy[ALIGNMENT.top];
			 break;
	
	//Middle		 
	case ANCHOR.CENTER_LEFT:
			 x=_posx[ALIGNMENT.left];
			 y=_posy[ALIGNMENT.middle];
	     break;
	case ANCHOR.CENTER:
			 x=_posx[ALIGNMENT.center];
			 y=_posy[ALIGNMENT.middle];
			 break;
	case ANCHOR.CENTER_RIGHT:
			 x=_posx[ALIGNMENT.right];
			 y=_posy[ALIGNMENT.middle];
			 break;
	
	//Bot		 
	case ANCHOR.BOTTOM_LEFT:
			 x=_posx[ALIGNMENT.left];
			 y=_posy[ALIGNMENT.bottom];
			 break;
	case ANCHOR.BOTTOM_CENTER:
			 x=_posx[ALIGNMENT.center];
			 y=_posy[ALIGNMENT.bottom];
			 break;
	case ANCHOR.BOTTOM_RIGHT:
			 x=_posx[ALIGNMENT.right];
			 y=_posy[ALIGNMENT.bottom];
	}
	
	gui_anchor_init();
}

function gui_anchor_ajust_force(){
	with(obj_ui_element) gui_anchor_ajust();
}