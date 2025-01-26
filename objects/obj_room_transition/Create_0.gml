/// @desc 
rm_destino = undefined;
tempo_fade_in = 0;
tempo_fade_out = 0;
tempo_entre_fade_in_out = 0;

image_alpha = 0;
image_xscale = display_get_gui_width();
image_yscale = display_get_gui_height();
image_blend = c_black;

on_fade_in = function(){
	room_goto(rm_destino);
	var _t = TweenEasyFade(1, 0, tempo_entre_fade_in_out, tempo_fade_out, EaseLinear);
	TweenAddCallback(_t, TWEEN_EV_FINISH, id, on_fade_out);
}

on_fade_out = function(){
	instance_destroy();
}

setup_room_transition = function(rm, in = 30, wait = 10, out = 30){
	rm_destino = rm;
	tempo_fade_in = in;
	tempo_fade_out = out;
	tempo_entre_fade_in_out = wait;
	
	var _t = TweenEasyFade(0, 1, 0, in, EaseLinear);
	TweenAddCallback(_t, TWEEN_EV_FINISH, id, on_fade_in);
}
