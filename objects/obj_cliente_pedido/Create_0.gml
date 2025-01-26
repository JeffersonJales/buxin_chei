/// @description 
icones = undefined;
cliente = noone;

configurar_pedidos = function(instCliente, pedidos){
	cliente = instCliente;
	var count = array_length(pedidos);
	var _x = x + sprite_width * 0.5;
	var _y = bbox_top;
	
	icones = array_create(count);
	for(var i = 0; i < count; i++){
		var inst = instance_create_depth(_x, _y, depth - 1, obj_cliente_pedido_icon);
		_y = _y + inst.sprite_height * 0.5 + 64;
		inst.y = _y;
		inst.configurar_pedido(pedidos[i]);
		
		icones[i] = inst;
	}
}

atualizar_lista = function(ind_receita){
	if(instance_exists(icones[ind_receita]))
		instance_destroy(icones[ind_receita]);
}
