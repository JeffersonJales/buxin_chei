/// @description LOAD GAME OR BOOT
if(file_exists_default(SAVE_GAME_FILE)){
	mailpost.add_subscription(MESSAGE_LOAD_GAME, game_boot_normal)
	load_game()
}
else{
	game_boot_first_time()
}