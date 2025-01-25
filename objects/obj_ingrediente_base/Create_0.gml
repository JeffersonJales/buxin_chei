/// @desc Este ingrediente é o que fica na panela 
image_speed = 0; 

/// Tempo para mudar de status
status = STATUS_INGREDIENTE_CRU;
tempo_para_cozinhar_em_sec = tempo_para_cozinhar_em_sec * ROOM_SPEED;
tempo_para_queimar_em_sec = tempo_para_queimar_em_sec * ROOM_SPEED;
tempo_restante_para_proximo_status = 0;

/// Recipente
instancia_recipiente = noone;
desocupar_recipiente = function(){
	if(instance_exists(instancia_recipiente))
		instancia_recipiente.desocupar_espaco();
}

/// Maquina de Estado Finito
ingrediente_fsm = new SnowState(STATUS_INGREDIENTE_CRU);
ingrediente_fsm.event_set_default_function("click", do_nothing);
ingrediente_fsm.event_set_default_function("step", do_nothing);

ingrediente_fsm
.add(STATUS_INGREDIENTE_CRU, {
	enter : function(){
		image_index = 0;
		status = STATUS_INGREDIENTE_CRU;
	},
	click : function(){
		desocupar_recipiente();
		gerar_ingrediente_ruim();
		instance_destroy();
	},
	step : function(){
		tempo_restante_para_proximo_status = tempo_para_cozinhar_em_sec;
		if(--tempo_para_cozinhar_em_sec <= 0)
			ingrediente_fsm.change(STATUS_INGREDIENTE_OK);
	}
})
.add(STATUS_INGREDIENTE_OK, {
	enter : function(){
		image_index = 1;	
		status = STATUS_INGREDIENTE_OK;
	},
	click : function(){
		if(procurar_recipente_vazio(recipiente_ao_ficar_pronto, receita)){
			desocupar_recipiente();
			instance_destroy();
		}
	}, 
	step : function(){
		tempo_restante_para_proximo_status = tempo_para_queimar_em_sec;
		if(--tempo_para_queimar_em_sec <= 0)
			ingrediente_fsm.change(STATUS_INGREDIENTE_QUEIMADO);	
	}
})
.add(STATUS_INGREDIENTE_QUEIMADO, {
	enter : function(){
		image_index = 2;		
		status = STATUS_INGREDIENTE_QUEIMADO;
	},
	click : function(){
		desocupar_recipiente();
		gerar_ingrediente_ruim();
		instance_destroy();
	}
})