/// @description Verificar tempo acabou
if(relogio_tempo_jogo.clock_step()){
	relogio_tempo_jogo.clock_change_time(0);
	mailpost_delivery(MESSAGE_TEMPO_JOGO_ACABOU)
}