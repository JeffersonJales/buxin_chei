/// SETUP VIEWPORT OFF ALL COLLECT normal ROOMS


/*
	Setup all collect rooms. Setting enable its view plus its viewport size
	Setup the window size
	Setup the display gui size of the game for a smaller size
	Also, set the game to fullscreen if its on
*/

#macro ASPECT_RATIO_MANTAIN_WIDTH true 


#macro VIEWPORT_WIDTH 1920			/// The viewport width base projection
#macro VIEWPORT_HEIGHT 1080			/// The viewport heigth base projection

#macro DISPLAY_GUI_WIDTH 480		/// The display gui width and height (See viewports_auto_setup)
#macro DISPLAY_GUI_HEIGHT 270		

#macro ROOM_SIZE_WIDTH 480		/// The room width and height of the collectables rooms (See viewports_auto_setup)
#macro ROOM_SIZE_HEIGHT 270

#macro GUI_W display_get_gui_width()	
#macro GUI_H display_get_gui_height()
#macro DISPLAY_WIDTH display_get_width()
#macro DISPLAY_HEIGHT display_get_height()
#macro WINDOW_WIDTH window_get_width()
#macro WINDOW_HEIGHT window_get_height()

global.__resolution = {
	aspect_ratio : 0,
	width : 0,
	height : 0,
}


#macro RESOLUTION_WIDTH global.__resolution.width
#macro RESOLUTION_HEIGHT global.__resolution.height
#macro RESOLUTION_ASPECT_RATIO global.__resolution.aspect_ratio

/// Setup the vieport of all collecable rooms. Also configures the game window plus the display gui size.
/// See Macros for more info
function viewports_auto_setup(){
	
	RESOLUTION_ASPECT_RATIO = DISPLAY_WIDTH / DISPLAY_HEIGHT;
	RESOLUTION_WIDTH = ASPECT_RATIO_MANTAIN_WIDTH ? 0 : VIEWPORT_WIDTH;
	RESOLUTION_HEIGHT = ASPECT_RATIO_MANTAIN_WIDTH ? VIEWPORT_HEIGHT : 0;
	
	if(ASPECT_RATIO_MANTAIN_WIDTH){ 
		RESOLUTION_WIDTH = round(RESOLUTION_HEIGHT * RESOLUTION_ASPECT_RATIO);
		RESOLUTION_WIDTH += RESOLUTION_WIDTH & 1 ? 1 : 0;
	}
	else {
		RESOLUTION_HEIGHT = round(RESOLUTION_WIDTH * RESOLUTION_ASPECT_RATIO);
		RESOLUTION_HEIGHT += RESOLUTION_HEIGHT & 1 ? 1 : 0;
	}
	
	//var _rm = room_first;
	//with(_rm != -1){
	//	room_set_view_enabled(_rm, true);
	//	if(asset_has_tags(_rm, TAG_ROOM_COLLECT, asset_room))
	//		room_set_viewport(_rm, 0, true, 0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
	//	else
	//		room_set_viewport(_rm, 0, true, 0, 0, RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
	//	_rm = room_next(_rm);
	//}
	
	//var _arr = tag_get_asset_ids(TAG_ROOM_COLLECT, asset_room);
	//for(var i = 0; i < array_length(_arr); i++){
	//	room_set_view_enabled(_arr[i], true);
	//	room_set_viewport(_arr[i], 0, true, 0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
	//}
	
	//surface_resize(application_surface, RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
	display_set_gui_size(VIEWPORT_WIDTH, VIEWPORT_HEIGHT)
	window_game_size_setup();

	if(ON_DESKTOP && global.options.fullscreen)
		with(obj_game_fullscreen) set_fullscreen();
}
	
/// Configure the Game Window (Windows Only)
function window_game_size_setup(){
	if(!ON_DESKTOP) return;
	
	var _w = DISPLAY_WIDTH * 0.5;
	var _h = DISPLAY_HEIGHT * 0.5;
		
	window_set_size(_w, _h);
	window_center();
}