/// @description Paciência
pedidos = [];
pedidos_ok = [];
pedidos_especiais = [];
total_pagar = 0;


spot_consumido = noone;
tempo_maximo_paciencia = tempo_maximo_paciencia * ROOM_SPEED;

iniciar = function(receitas, spot){
	pedidos = receitas;
	spot_consumido = spot;
	if(!is_array(pedidos))
		pedidos = array_create(1, pedidos);
	
	qtdPedidos = array_length(pedidos);
	pedidos_ok = array_create(qtdPedidos, false);
	pedidos_shine = array_create(qtdPedidos, false);

	var t = TweenEasyMove(x, y, spot_consumido.x, y, 0, 120, EaseLinear, 0);
	TweenAddCallback(t, TWEEN_EV_FINISH, id, function(){ cliente_fsm.change("pedido"); })
}

procurar_receitas_prontas = function(){
	var qtd_ok = 0;
	for(var i = 0; i < qtdPedidos; i++){
		if(!pedidos_ok[i] && instance_exists(pedidos[i])){
			var receitas = instance_find_all(pedidos[i])
			for(var f = 0; f < array_length(receitas); f++){
				var inst = instance_find(pedidos[i], f);
				if(inst != noone && inst.pode_coletar()){
					pedidos_ok[i] = true;
					pedidos_especiais[i] = inst.receita_especial;
					inst.coletar_receita();
					balao_pedido.atualizar_lista(pedidos[i]);
					break;
				}
			}
		}
		
		qtd_ok += pedidos_ok[i];
	}
	
	if(qtd_ok == qtdPedidos){
		dar_dinheiro();
		cliente_fsm.change("sair");	
	}
}

dar_dinheiro = function(){
	
}

balao_pedido = noone;

cliente_fsm = new SnowState("iniciar");
cliente_fsm.event_set_default_function("step", do_nothing);
cliente_fsm.event_set_default_function("click", do_nothing);

cliente_fsm
.add("iniciar", {})
.add("pedido", {
	enter : function(){
		balao_pedido = instance_create_layer(x + sprite_width * 0.2, y - sprite_width * 0.25, "Baloes", obj_cliente_pedido);
		balao_pedido.configurar_pedidos(id, pedidos);
		timer_id = iniciar_timer(tempo_maximo_paciencia);
	},
	step : function(){
		if(--tempo_maximo_paciencia <= 0)
			cliente_fsm.change("sair");			
	},
	click : function(){
		procurar_receitas_prontas();	
	}
})
.add("sair", {
	enter : function(){
		instance_destroy_exists(timer_id);
		timer_id = noone;
		
		instance_destroy_exists(balao_pedido);
		mailpost_delivery(MESSAGE_CLIENTE_FOI_EMBORA, id);

		var spawner = array_get_random(instance_find_all(obj_spawner_cliente))
		var t = TweenEasyMove(x, y, spawner.x, y, 0, 120, EaseLinear, 0);
		TweenAddCallback(t, TWEEN_EV_FINISH, id, instance_destroy);
	}
})	
