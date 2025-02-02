/// @desc Este ingrediente é o que fica na panela 
image_speed = 0; 

/// Tempo para mudar de status
status = STATUS_INGREDIENTE_CRU;
tempo_para_cozinhar_em_sec = tempo_para_cozinhar_em_sec * ROOM_SPEED;
tempo_para_queimar_em_sec = tempo_para_queimar_em_sec * ROOM_SPEED;

/// Som id
audio_id_preparando = noone;

/// Panela
penela_id = noone;
timer_id = noone;

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
		penela_id = instance_create_depth(x, y, depth + 1, panela);
		image_index = 0;
		status = STATUS_INGREDIENTE_CRU;
		audio_id_preparando = sfx_play(sfx_preparando, true);
		timer_id = iniciar_timer(tempo_para_cozinhar_em_sec)
	},
	click : function(){
		audio_stop_sound_fade(audio_id_preparando);
		audio_id_preparando = noone;
		
		desocupar_recipiente();
		gerar_ingrediente_ruim();
		instance_destroy();
	},
	step : function(){
		if(--tempo_para_cozinhar_em_sec <= 0)
			ingrediente_fsm.change(STATUS_INGREDIENTE_OK);
	}
})
.add(STATUS_INGREDIENTE_OK, {
	enter : function(){
		image_index = 1;	
		status = STATUS_INGREDIENTE_OK;
		sfx_play_simple(sfx_pronto);
		instance_destroy_exists(timer_id);
		timer_id = iniciar_timer(tempo_para_queimar_em_sec, false)
	},
	click : function(){
		if(procurar_recipente_vazio(recipiente_ao_ficar_pronto, receita)){
			sfx_play_simple(sfx_pegando);
			audio_stop_sound_fade(audio_id_preparando);
			audio_id_preparando = noone;

			desocupar_recipiente();
			instance_destroy();
		}
	}, 
	step : function(){
		if(--tempo_para_queimar_em_sec <= 0)
			ingrediente_fsm.change(STATUS_INGREDIENTE_QUEIMADO);	
	}
})
.add(STATUS_INGREDIENTE_QUEIMADO, {
	enter : function(){
		image_index = 2;		
		status = STATUS_INGREDIENTE_QUEIMADO;
		audio_stop_sound_fade(audio_id_preparando);
		audio_id_preparando = noone;
		
		instance_destroy_exists(penela_id.fogo_id);
		sfx_play_simple(sfx_falhado);
		instance_destroy_exists(timer_id);
	},
	click : function(){
		desocupar_recipiente();
		gerar_ingrediente_ruim();
		instance_destroy();
	}
})