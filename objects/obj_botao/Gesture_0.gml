/// @description On Click
if(ativo){
	on_click();
	sfx_play_exists(sfx_on_click);
}
else 
	sfx_play_exists(sfx_on_click_disable);

tween_scale_base_exec();
