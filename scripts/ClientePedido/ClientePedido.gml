function ClientePedido(receitas, cliente) constructor{
	pedidos = receitas;
	if(!is_array(receitas))
		pedidos = array_create(1, receitas);
	
	total_pedidos = array_length(pedidos);
	pedidos_ok = array_create(total_pedidos);
	
	__soma_valor_fixos = 0;
	__total_a_pagar = 0;
	
	balao_id = noone; 
	cliente_id = cliente
	
	__total_especiais = 1;
	static calcular_valor_pedidos = function(paciencia_perc){
		var _multi = calcular_gorjeta(paciencia_perc);
		__total_a_pagar = (__soma_valor_fixos * _multi + random_range(0, 1) * _multi) * __total_especiais;
	}
	
	static calcular_gorjeta = function(paciencia_perc){
		if(paciencia_perc > 0.66) return 1.2;
		if(paciencia_perc > 0.33) return 1.1;
		return 1;
	}
	
	static procurar_receitas_prontas = function(){
		var qtd_ok = 0;
		for(var i = 0; i < total_pedidos; i++){
			if(!pedidos_ok[i] && instance_exists(pedidos[i])){
				var receitas = instance_find_all(pedidos[i])
				for(var f = 0; f < array_length(receitas); f++){
					var inst = instance_find(pedidos[i], f);
					if(inst != noone && inst.pode_coletar()){
						pedidos_ok[i] = true;
						__total_especiais += inst.receita_especial;
						__soma_valor_fixos += inst.valor;
						inst.coletar_receita();
						balao_pedido.atualizar_lista(i);
						break;
					}
				}
			}
		
			qtd_ok += pedidos_ok[i];
		}
	
		return qtd_ok == total_pedidos;
	}
	
	static instanciar_pedido = function(){
		var _balao = noone;
		with(cliente_id)
			_balao = instance_create_layer(x + sprite_width * 0.2, y - sprite_width * 0.25, "Baloes", obj_cliente_pedido);

		balao_pedido = _balao;
		balao_pedido.configurar_pedidos(cliente_id, pedidos);	
	}
	
	static destruir_pedido = function(){
		instance_destroy_exists(balao_pedido);
		balao_pedido = noone;
	}
}