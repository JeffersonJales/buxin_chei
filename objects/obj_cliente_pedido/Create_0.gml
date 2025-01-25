/// @description 
icones = undefined;
cliente = noone;

configurar_pedidos = function(instCliente, pedidos){
	clinte = instCliente;
	var count = array_length(pedidos);
	var _x = x + sprite_width * 0.5;
	var _y = bbox_top;
	
	icones = array_create(count);
	for(var i = 0; i < count; i++){
		var inst = instance_create_depth(_x, _y, depth - 1, obj_cliente_pedido_icon);
		_y = _y + inst.sprite_height * 0.5 + 64;
		inst.y = _y;
		inst.configurar_pedido(cliente, pedidos[i]);
		
		icones[i] = inst;
	}
}

atualizar_lista = function(receita){
	for(var i = 0; i < array_length(icones); i++){
		if(instance_exists(icones[i]) && icones[i].receita_relacionada == receita){
			instance_destroy(icones[i]);
		}
	}
}

