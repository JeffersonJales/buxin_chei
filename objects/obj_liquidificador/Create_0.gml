/// @desc Iniciando liquidificador
image_speed = 0; 
tween_scale_base_init();

/// Tempo para mudar de status
status = STATUS_LIQUIDIFICADOR_DESLIGADO;
tempo_produzir = tempo_produzir * ROOM_SPEED;
tempo_restante_para_proximo_status = 0;

/// Recipente
instancia_copo = noone;

/// Maquina de Estado Finito
liquidificador_fsm = new SnowState(STATUS_LIQUIDIFICADOR_DESLIGADO);
liquidificador_fsm.event_set_default_function("click", do_nothing);
liquidificador_fsm.event_set_default_function("step", do_nothing);

liquidificador_fsm
.add(STATUS_LIQUIDIFICADOR_DESLIGADO, {
	enter : function(){
		image_index = 0;
		status = STATUS_LIQUIDIFICADOR_DESLIGADO;
	},
	click : function(){
		var inst = procurar_copo_vazio(copo_alvo);
		print(inst);
		if(inst != noone){
			instancia_copo = inst;	
			liquidificador_fsm.change(STATUS_LIQUIDIFICADOR_LIGADO);
		}
	}
})
.add(STATUS_LIQUIDIFICADOR_LIGADO, {
	enter : function(){
		image_index = 1;
		status = STATUS_LIQUIDIFICADOR_LIGADO;
		tempo_restante_para_proximo_status = tempo_produzir;
	},
	step : function(){
		if(--tempo_restante_para_proximo_status <= 0){
			instancia_copo.preencher_copo();
			instancia_copo = noone;
			liquidificador_fsm.change(STATUS_LIQUIDIFICADOR_DESLIGADO);
		}
	}
})
