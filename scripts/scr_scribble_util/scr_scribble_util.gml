function scr_scribble_draw(str, _x = x, _y = y, rotate = image_angle, scale_multiplier = 1, alpha = image_alpha){
	scribble(str)
		.starting_format("font_cordel_groteska", c_white)
		.blend(c_white, alpha)
		.transform(image_xscale * scale_multiplier, image_yscale * scale_multiplier, rotate)
		.scale_to_box(sprite_width, sprite_height)
		.sdf_shadow(c_black, alpha, 0, 5, 0.1)
		.draw(x, y);
}
