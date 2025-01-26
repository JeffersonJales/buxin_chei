/// @description Definindo Torta
cor_torta = c_white;
raio_circulo = 0; 
relogio_tempo = new Clock(0, false);

surf = noone;
ao_concluir_tempo = do_nothing;

surf_config = function(){
	if(!surface_exists(surf))
		surf = surface_create(sprite_width, sprite_height);
	
	surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
		gpu_set_blendmode(bm_subtract);
		draw_pie(sprite_xoffset, sprite_yoffset, relogio_tempo.__time, relogio_tempo.__max_time, cor_torta, raio_circulo, raio_circulo, 1, 90, 1);
		gpu_set_blendmode(bm_normal);
	surface_reset_target();
}

configurar = function(tempo, callback, verde){
	relogio_tempo.clock_change_time(tempo);
	ao_concluir_tempo = callback;
	sprite_index = verde ? spr_timer_verde : spr_timer_vermelho;
	
	surf = surface_create(sprite_width, sprite_height);
	raio_circulo = max(sprite_width, sprite_height) * 1.5;
}
