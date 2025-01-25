/// @description Definir Status do Copo
event_inherited();

status = STATUS_COPO_VAZIO;
image_speed = 0;

checar_pode_ser_preenchido = function(){
	return status == STATUS_COPO_VAZIO;	
}

preencher_copo = function(){
	status = STATUS_COPO_CHEIO;
	image_index = 1;
	tween_scale_base_exec();
}

esvaziar_copo = function(){
	status = STATUS_COPO_VAZIO;	
	image_index = 0;
	tween_scale_base_exec();
}

coletar_receita = esvaziar_copo;

pode_coletar = function(){
	return status == STATUS_COPO_CHEIO;	
}