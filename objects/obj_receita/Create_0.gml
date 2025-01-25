/// @description Receber ingrediente extra
instancia_recipiente = noone;
desocupar_recipiente = function(){
	if(instance_exists(instancia_recipiente))
		instancia_recipiente.desocupar_espaco();
}

receber_ingrediente_extra = do_nothing;
mudar_receita = function(receita_destino){ 
	if(receita_destino != undefined){
		instance_change(receita_destino, false); 
		return true;
	}
	
	return false;
}

tween_scale_base_init();