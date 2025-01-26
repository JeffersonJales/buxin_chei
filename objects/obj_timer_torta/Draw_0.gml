/// @description Torta
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, 0.25);

surf_config();
draw_surface(surf, x - sprite_xoffset, y - sprite_yoffset);