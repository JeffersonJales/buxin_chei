/// @description Receita Tapioca
event_inherited();
instance_set_sprite(sprite_index, 1, 0);

receber_ingrediente_extra = function(ingrediente_extra){
	var receita_destino = undefined;
	switch(ingrediente_extra){
		case obj_ingrediente_extra_queijo: receita_destino = obj_receita_tapioca_queijo; break;
	}
	
	return mudar_receita(receita_destino);
}