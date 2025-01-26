/// @description Self + Scribble
draw_self();
scribble(str_text)
	.blend(c_white, image_alpha)
	.transform(5 * image_xscale, 5 * image_yscale, 5)
	.scale_to_box(sprite_width, sprite_height)
	.draw(x, y);