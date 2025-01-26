/// @description 
tempo_fase = tempo_fase * ROOM_SPEED;
delay_inicial = delay_inicial * ROOM_SPEED;
delay_entre_clientes = delay_entre_clientes * ROOM_SPEED;
delay_entre_clientes_fx = delay_entre_clientes;

/// Spawnar clientes
spot_total = instance_number(obj_posicao_cliente);
spot_livre = true;
spots_livres = ds_list_create()
array_foreach(instance_find_all(obj_posicao_cliente), function(item){ ds_list_add(spots_livres, item); });


spawners = instance_find_all(obj_spawner_cliente);

tentar_spawnar_cliente = function(){
	if(spot_livre && --delay_entre_clientes <= 0){
		spawnar_cliente();
		delay_entre_clientes = delay_entre_clientes_fx;
	}
}
spawnar_cliente = function(){
	spot_livre = --spot_total > 0;
	var _spawner = array_get_random(spawners);
	var _cliente = array_get_random(clientes_possiveis);
	var _receita = array_get_random(receitas_possiveis);
	var inst_cliente = instance_create_depth(_spawner.x, _spawner.y, _spawner.depth, _cliente);
	var _spot = obter_spot_livre();
	
	inst_cliente.iniciar(_receita, _spot);
}

obter_spot_livre = function(){
	var ind = irandom(ds_list_size(spots_livres) - 1);
	var spot = spots_livres[| ind];
	ds_list_delete(spots_livres, ind);
	
	spot_livre = ds_list_size(spots_livres) > 0;

	return spot;
}
liberar_spot = function(spot){
	spot_livre = true;
	ds_list_add(spots_livres, spot);
}

/// FSM
controle_jogo_fsm = new SnowState("iniciar");
controle_jogo_fsm.event_set_default_function("step", do_nothing);

controle_jogo_fsm
.add("iniciar", {
	step : function(){
		if(--delay_inicial <= 0) 
			controle_jogo_fsm.change("gameplay");
	},
	leave : function(){
		spawnar_cliente();
	}
})
.add("gameplay", {
	enter : function(){
		mailpost_delivery(MESSAGE_INICIAR_GAMEPLAY, id);
	},
	step : function(){
		tentar_spawnar_cliente();
	}
})
.add("fim", {
	enter: function(){
		room_goto_ext(rm_menu);
	}
})

controle_jogo_mailpost = new MailPost();
controle_jogo_mailpost.add_subscription(MESSAGE_CLIENTE_FOI_EMBORA, function(instance_cliente){
	liberar_spot(instance_cliente.spot_consumido);
})
controle_jogo_mailpost.add_subscription(MESSAGE_TEMPO_JOGO_ACABOU, function(){
	controle_jogo_fsm.change("fim");
})