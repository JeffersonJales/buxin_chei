/// @description Animacao

image_xscale = lerp(image_xscale, scr_wave_animation(0.99, 1.01, 6), .1);
image_yscale = image_xscale;

image_angle = scr_wave_animation(-2, 2, 5);
