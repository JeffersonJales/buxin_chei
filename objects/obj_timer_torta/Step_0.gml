/// @description Timer
if(relogio_tempo.clock_step()){
	ao_concluir_tempo();
	instance_destroy();
}