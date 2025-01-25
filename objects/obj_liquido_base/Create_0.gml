/// @description Definir Status do Copo
status = STATUS_COPO_VAZIO;
image_speed = 0;
tween_scale_base_init();

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
