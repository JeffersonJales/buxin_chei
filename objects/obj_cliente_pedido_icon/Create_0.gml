/// @description 
image_xscale = 0.5;
image_yscale = 0.5;

receita_relacionada = noone;
configurar_pedido = function(receita){
	receita_relacionada = receita;
	instance_set_sprite(object_get_sprite(receita), 1, 0);
}
