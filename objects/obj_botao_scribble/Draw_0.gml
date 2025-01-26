/// @description Self + Scribble
draw_self();
scribble(str_text)
	.starting_format("font_cordel_groteska", c_white)
	.blend(c_white, image_alpha)
	.transform(2 * image_xscale, 2 * image_yscale, 5)
	.scale_to_box(sprite_width, sprite_height)
	.sdf_shadow(c_black, image_alpha, 0, 5, 0.1)
	.draw(x, y);