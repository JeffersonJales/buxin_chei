/// @description Receber ingrediente extra
receita_especial = false;
instancia_recipiente = noone;

/// Ingredientes / Receitas que transformam essa receita
relacao_objeto_receita = {};
adicionar_objeto_receita = function(obj, receita){
	relacao_objeto_receita[$ object_get_name(obj)] = receita;
}
receber_ingrediente_extra = function(ingrediente_receita){
	var _name = object_get_name(ingrediente_receita);
	var _receita = relacao_objeto_receita[$ _name];
	
	if(_receita != undefined){
		desocupar_recipiente();

		var inst = instance_create_depth(x, y, depth, _receita, {
			receita_especial : receita_especial, 
			instancia_recipiente : instancia_recipiente
		});
		instancia_recipiente.ocupar_com_ingrediente(inst);

		instance_destroy();
		return true;
	}
	
	return false;
}


desocupar_recipiente = function(){
	if(instance_exists(instancia_recipiente))
		instancia_recipiente.desocupar_espaco();
}

pode_coletar = function(){
	return true;	
}

coletar_receita = function(){
	sfx_play_simple(array_get_random(sfx_coletado));
	desocupar_recipiente();
	instance_destroy();
}

tween_scale_base_init();
