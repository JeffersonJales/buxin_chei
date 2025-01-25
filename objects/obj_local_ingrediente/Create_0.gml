/// @description Definir Status
status = STATUS_RECIPIENTE_VAZIO;
ingrediente_vinculado = noone;

pode_ser_ocupado = function(){
	return status == STATUS_RECIPIENTE_VAZIO
}

ocupar_com_ingrediente = function(instancia_ingrediente){
	status = STATUS_RECIPIENTE_OCUPADO;
	ingrediente_vinculado = instancia_ingrediente;
	instancia_ingrediente.instancia_recipiente = id;
}

desocupar_espaco = function(){
	status = STATUS_RECIPIENTE_VAZIO;
	ingrediente_vinculado = noone;
}