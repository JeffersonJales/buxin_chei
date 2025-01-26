/// @description 
image_alpha = 0;
quantidade_atual = 0;
quantidade_dinheiro = 0;

transformar_dinheiro_para_texto = function(){
	return "$" + string_replace_all(string_format(quantidade_atual, 10, 2), " ", "");
}


/// Mailpost
ui_dinheiro_mailpost = new MailPost();
ui_dinheiro_mailpost.add_subscription(MESSAGE_INICIAR_GAMEPLAY, function(controlador_id){
	TweenEasyFade(0, 1, 0, 30, EaseLinear, 0);
})
ui_dinheiro_mailpost.add_subscription(MESSAGE_CLIENTE_FOI_EMBORA, function(cliente_id){
	quantidade_dinheiro += cliente_id.pedido_cliente.__total_a_pagar;
	print(cliente_id.pedido_cliente.__total_a_pagar);
	TweenFire(id, EaseLinear, 0, 0, 0, 20, "quantidade_atual", quantidade_atual, quantidade_dinheiro);
})