/// @description Definindo Torta
cor_torta = c_white;
tempo_atual = tempo_maximo;
raio_circulo = max(sprite_width, sprite_height) * 1.5;

surf = surface_create(sprite_width, sprite_height);
surf_config = function(){
	if(!surface_exists(surf))
		surf = surface_create(sprite_width, sprite_height);
	
	surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
		gpu_set_blendmode(bm_subtract);
		draw_pie(sprite_xoffset, sprite_yoffset, tempo_atual, tempo_maximo, cor_torta, raio_circulo, raio_circulo, 1, 90, 1);
		gpu_set_blendmode(bm_normal);
	surface_reset_target();
}
	
setar_velocidade = function(spd){
	spd_timer = spd;	
}