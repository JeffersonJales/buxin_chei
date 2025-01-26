/// @description Iniciar temporizador
image_alpha = 0;
relogio_tempo_jogo = new Clock(0, false);
relogio_tempo_jogo.clock_pause();

transformar_frame_para_tempo = function(){
    var tempo = relogio_tempo_jogo.clock_get_remaining();
    var tempo_total_segundos = tempo div 60;
    var minutes = tempo_total_segundos div 60;
    var seconds = tempo_total_segundos mod 60;
    
    return string_replace_all(string_format(minutes, 2, 0) + ":" + string_format(seconds, 2, 0), " ", "0");
}

configurar_tempo = function(tempo){
	relogio_tempo_jogo.clock_change_time(tempo);
	relogio_tempo_jogo.clock_resume();
}

ui_tempo_mailpost = new MailPost();
ui_tempo_mailpost.add_subscription(MESSAGE_INICIAR_GAMEPLAY, function(controlador_id){
	configurar_tempo(controlador_id.tempo_fase);
	TweenEasyFade(0, 1, 0, 30, EaseLinear, 0);
})