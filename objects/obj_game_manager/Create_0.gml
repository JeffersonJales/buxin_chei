/// @desc Iniciar

mailpost = new MailPost(true);
mailpost.
	add_subscription(MESSAGE_LANGUAGE_CHANGE, game_language_change). 
	add_subscription(MESSAGE_BGM_VOLUME_CHANGE, function(value){ 
		global.options.sound_bgm = value;  
		bgm_on_volume_change();
	}).
	add_subscription(MESSAGE_MASTER_VOLUME_CHANGE, function(value){
		global.options.sound_master = value;
		bgm_on_volume_change();
	}).
	add_subscription(MESSAGE_SFX_VOLUME_CHANGE, function(value){
		global.options.sound_sfx = value;
	}).
	add_subscription(MESSAGE_OVERLAYER_DESTROY, function(){
		blackboard.input_click = false;
		blackboard.input_holding_click = false;
	})

game_boot_instances();
game_boot_game_start();
overlay_system_init();
instance_create(obj_game_boot);
