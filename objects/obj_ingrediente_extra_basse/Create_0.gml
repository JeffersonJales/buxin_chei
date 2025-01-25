/// @description Procurar por receitas prontas e adicionar queijo
tween_scale_base_init();
procurar_receitas_prontas = function(){
	var arr = instance_find_all(obj_receita);
	for(var i = 0; i < array_length(arr); i++){
		var inst = arr[i];
		if(inst.receber_ingrediente_extra(object_index))
			break;
	}
}
