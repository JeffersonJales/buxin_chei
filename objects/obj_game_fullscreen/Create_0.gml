/// @description setup

change_fullscreen = function(){
	global.options.fullscreen = !global.options.fullscreen; 
	set_fullscreen();
}

set_fullscreen = function(){
	window_set_fullscreen(global.options.fullscreen);
	call_later(1, time_source_units_frames, recenter_window, false)
}

recenter_window = function(){
	if(!window_get_fullscreen()){
		window_game_size_setup();
	}
	
	mailpost_delivery(MESSAGE_FULLSCREEN_CHANGE, global.options.fullscreen)
}
