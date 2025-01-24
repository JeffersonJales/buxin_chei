/// @desc 
event_inherited();
enum SCRIBBLE_FONT { TITLE, COMMOM }

scr = noone;
typper = noone;

scribble_setup = function(str = text){
	var _t = lexicon_text(str);
	var _font = font_type_title ? blackboard.font_title : blackboard.font_common;
	
	if(with_arabesco)
		_t = "[spr_arabesco] " + _t + " [spr_arabesco_mirror]"
	
	scr = scribble(_t).
		align(halign, valign). 
		starting_format(_font, color). 
		scale(scale);
	
	if(type_spd > 0){
		typper = scribble_typist();
		typper.in(type_spd, type_fade);
		scribble_draw = (fit_to_box ? scribble_draw_type_fit_to_box : scribble_draw_type_scale_to_box);;
	}
	else{
		scribble_draw = (fit_to_box ? scribble_draw_fit_to_box : scribble_draw_scale_to_box);
	}
	
	scribble_custon_setup();
}

scribble_draw = do_nothing;
scribble_draw_scale_to_box = function(){
	scr.blend(color_blend, image_alpha).transform(transform_scale_x, transform_scale_y, image_angle).scale_to_box(sprite_width, sprite_height, blackboard.using_CJK_language).draw(x, y);
}
scribble_draw_fit_to_box = function(){
	scr.blend(color_blend, image_alpha).transform(transform_scale_x, transform_scale_y, image_angle).fit_to_box(sprite_width, sprite_height, blackboard.using_CJK_language).draw(x, y);
}
scribble_draw_type_fit_to_box = function(){
	scr.blend(color_blend, image_alpha).transform(transform_scale_x, transform_scale_y, image_angle).fit_to_box(sprite_width, sprite_height, blackboard.using_CJK_language).draw(x, y, typper);
}
scribble_draw_type_scale_to_box = function(){
	scr.blend(color_blend, image_alpha).transform(transform_scale_x, transform_scale_y, image_angle).scale_to_box(sprite_width, sprite_height, blackboard.using_CJK_language).draw(x, y, typper);
}

on_overlay_init = scribble_setup;
on_language_change = function() { scribble_setup(); }
scribble_custon_setup = do_nothing;

mailpost = new MailPost(false);
mailpost.add_subscription(MESSAGE_LANGUAGE_CHANGE_SETUP, function(){ if(scr != noone) on_language_change() });
