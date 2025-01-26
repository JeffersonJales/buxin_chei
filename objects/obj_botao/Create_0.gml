/// @description  
ativo = true;
on_click = do_nothing;

desativar_botao = function(){
	ativo = false;
}

matar_botao = function(){
	desativar_botao();
	on_click = do_nothing;
}

tween_scale_base_init();