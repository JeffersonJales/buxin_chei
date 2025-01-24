/// @description 
event_inherited();

image_speed = 0;

/// @description SETUP BUTTON
enable = true; /// If the player can click on button, but enter and leave will continue to work
set_enable = function(boolean){
	enable = boolean;
}

/// Scale feedback
scale_x = image_xscale;	/// The scale start of of the button for animation porporsee
scale_y = image_yscale;
set_scale = function(_x = scale_x, _y = scale_y){
	image_xscale = _x;
	image_yscale = _y;
}


/// Text On Button
button_text = noone;
button_text_create = function(text, fit_to_box = true){
	if(instance_exists(button_text)) instance_destroy(button_text);
	button_text = instance_create_depth(x, y, depth - 1, obj_scribble, {
		text : text,
		sprite_index : sprite_index,
		image_xscale : image_xscale - 0.1,
		image_yscale : image_yscale - 0.1,
		image_angle : image_angle,
		image_blend : c_black,
		fit_to_box : fit_to_box
	});
	
	button_text.scribble_setup();
	return button_text;
}
button_text_increase_size = function(){ 
	with(button_text){
		var _scale = other.scale_increase_on_enter * 0.9;
		transform_scale_x += _scale;
		transform_scale_y += _scale;
		image_xscale += _scale;
		image_yscale += _scale;
	}
}
button_text_decrease_size = function(){
	with(button_text){
		var _scale = other.scale_increase_on_enter * 0.9;
		transform_scale_x -= _scale;
		transform_scale_y -= _scale;

		image_xscale -= _scale;
		image_yscale -= _scale;
	}
}


/// Audio feedback
play_audio = function(audio){
	if(audio != noone)
		return audio_play_sound(audio, AUDIO_PRIORITY_SFX_BASIC, false, sfx_get_volume());
}

on_click_custom = do_nothing;	/// The custom click, enter and leave events, overwrite this when inhenrenting
on_enter_custom = do_nothing;
on_leave_custom = do_nothing;
__on_click = do_nothing;
__on_enter = do_nothing;
__on_leave = do_nothing;

check_collision = function(){
	return position_meeting(blackboard.device_pos_x, blackboard.device_pos_y, id);
}

setup_behavior = function(click, enter = do_nothing, leave = do_nothing){ 
	on_click_custom = click;
	on_enter_custom = enter;
	on_leave_custom = leave;
}

/// Inner functions

/// Called when the player clicks in the button
on_click = function(){
	if(enable){
		on_click_custom(id);
		play_audio(on_click_audio);
		mailpost_delivery(MESSAGE_BUTTON_CLICK, id);
	}
	else{
		play_audio(on_disable_click_audio);
		mailpost_delivery(MESSAGE_BUTTON_CLICK_DISABLE, id);
	}
}

/// Called when the mouse collides with the button
on_enter = function(){
	on_enter_custom(id);
	
	play_audio(on_enter_audio);
	set_scale(scale_x + scale_increase_on_enter, scale_y + scale_increase_on_enter);
	button_text_increase_size();
	mailpost_delivery(MESSAGE_BUTTON_ENTER, id);
}

/// Called when the mouse leaves the collision
on_leave = function(){
	on_leave_custom(id);
	
	set_scale();
	button_text_decrease_size();
	play_audio(on_leave_audio);
	mailpost_delivery(MESSAGE_BUTTON_LEAVE, id);
}

/// Button stops working, but continue to render
button_kill = function(){
	if(!enable) return;
	
	set_enable(false);
	__on_click = on_click;
	__on_enter = on_enter;
	__on_leave = on_leave;
	on_click = do_nothing;
	on_enter = do_nothing;
	on_leave = do_nothing;
	button_kill_custom();
}

/// Revive button with it's behaviors
button_revive = function(){
	if(enable) return;
	
	set_enable(true);
	
	on_click = __on_click;
	on_enter = __on_enter;
	on_leave = __on_leave;
	button_revive_custom();
}

button_kill_custom = do_nothing;
button_revive_custom = do_nothing;
