function timeline_action_ui_fade_out(time, ease = EaseLinear, alpha = 0){
	with(obj_ui_element) TweenEasyFade(image_alpha, alpha, 0, time, ease);
	timeline_action_ui_button_kill();
}

function timeline_action_ui_fade_in(time, ease = EaseLinear, alpha = 1){
	with(obj_ui_element) TweenEasyFade(0, alpha, 0, time, ease);
	timeline_action_ui_button_kill();
}

function timeline_action_ui_revive_buttons(){
	with(obj_button_generic) button_revive();
}

function timeline_action_ui_button_kill(){
	with(obj_button_generic) button_kill();
}
