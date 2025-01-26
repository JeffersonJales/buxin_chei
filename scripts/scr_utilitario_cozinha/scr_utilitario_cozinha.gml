#macro STATUS_INGREDIENTE_CRU "INGREDIENTE_CRU"
#macro STATUS_INGREDIENTE_OK "INGREDIENTE_OK"
#macro STATUS_INGREDIENTE_QUEIMADO "INGREDIENTE_QUEIMADO"

function gerar_ingrediente_ruim(){
	instance_create_depth(x, y, depth, obj_ingrediente_ruim, {
		sprite_index : sprite_index, 
		image_index : image_index, 
		image_speed : 0
	});
}


#macro STATUS_RECIPIENTE_VAZIO "RECIPIENTE_VAZIO"
#macro STATUS_RECIPIENTE_OCUPADO "RECIPIENTE_OCUPADO"

function procurar_recipente_vazio(destino_recipiente, ingrediente_obj) {
	var recipientes = instance_find_all(destino_recipiente)
	for(var i = 0; i < array_length(recipientes); i++){
		var alvo_recipiente = recipientes[i];
		if(alvo_recipiente.pode_ser_ocupado()){
			var ingrediente = instance_create_depth(alvo_recipiente.x, alvo_recipiente.y, alvo_recipiente.depth - 10, ingrediente_obj)
			recipientes[i].ocupar_com_ingrediente(ingrediente);
			return true;
		}
	}
	
	return false;
}	
	
#macro STATUS_LIQUIDIFICADOR_LIGADO "LIQUIDIFICADOR_LIGADO"
#macro STATUS_LIQUIDIFICADOR_DESLIGADO "LIQUIDIFICADOR_DESLIGADO"

#macro STATUS_COPO_VAZIO "COPO_VAZIO"
#macro STATUS_COPO_CHEIO "COPO_CHEIO"

function procurar_copo_vazio(copo) {
	var recipientes = instance_find_all(copo)
	for(var i = 0; i < array_length(recipientes); i++){
		if(recipientes[i].checar_pode_ser_preenchido())
			return recipientes[i];
	}
	
	return noone;
}

function iniciar_timer(tempo, verde = true, _x = x, _y = bbox_top - 32){
	
	var _timer = instance_create_layer(_x, _y, "Timers", obj_timer_torta, {
		tempo_maximo : tempo, 
		sprite_index : verde ? spr_timer_verde : spr_timer_vermelho
	});

	return _timer;
}