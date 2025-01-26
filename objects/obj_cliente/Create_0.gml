/// @description Paciência
pedido_cliente = undefined;
spot_consumido = noone;
tempo_maximo_paciencia = tempo_maximo_paciencia * ROOM_SPEED;

iniciar = function(receitas, spot){
	pedido_cliente = new ClientePedido(receitas, id); 
	spot_consumido = spot;

	var t = TweenEasyMove(x, y, spot_consumido.x, y, 0, 120, EaseLinear, 0);
	TweenAddCallback(t, TWEEN_EV_FINISH, id, function(){ cliente_fsm.change("pedido"); })
}

procurar_receitas_prontas = function(){
	if(pedido_cliente.procurar_receitas_prontas())
		cliente_fsm.change("sair");	
}

cliente_fsm = new SnowState("iniciar");
cliente_fsm.event_set_default_function("click", do_nothing);

cliente_fsm
.add("iniciar", {})
.add("pedido", {
	enter : function(){
		pedido_cliente.instanciar_pedido();
		
		timer_id = iniciar_timer(tempo_maximo_paciencia,,,, function(){
			cliente_fsm.change("sair");			
		});
	},
	click : function(){
		procurar_receitas_prontas();	
	}
})
.add("sair", {
	enter : function(){
		if(instance_exists(timer_id))
			paciencia_restante = timer_id.relogio_tempo.clock_get_remaining_perc_total();	
		
		pedido_cliente.calcular_valor_pedidos(paciencia_restante);
		
		instance_destroy_exists(timer_id);
		timer_id = noone;
		pedido_cliente.destruir_pedido();
		
		mailpost_delivery(MESSAGE_CLIENTE_FOI_EMBORA, id);

		var spawner = array_get_random(instance_find_all(obj_spawner_cliente))
		var t = TweenEasyMove(x, y, spawner.x, y, 0, 120, EaseLinear, 0);
		TweenAddCallback(t, TWEEN_EV_FINISH, id, instance_destroy);
	}
})	
