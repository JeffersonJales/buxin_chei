/// @description 

event_inherited();

button_kill_custom = function(){ fsm.on_kill(); fsm.change("killed"); }
button_revive_custom = function(){ fsm.change("idle"); }

/// --- FSM BUTTON ---

fsm = new SnowState("idle", false);
fsm.event_set_default_function("step", do_nothing);
fsm.event_set_default_function("on_kill", do_nothing);
fsm.add("killed", {});

#region INPUT SMARTPHONE X PC 

if(ON_SMARTPHONE){
	fsm.add("idle", {
		step : function(){
			if(blackboard.input_click && check_collision()) 
				on_click();
		}
	})
}
else {
	fsm.add("idle", {
		step : function(){
			if(check_collision()){ 
				on_enter();
				fsm.change("on_it");
			}
		},
	})

	fsm.add("on_it", {	
		step : function(){
			if(check_collision()){
				if(blackboard.input_click)
					fsm.change("clicked");
			}
			else{
				fsm.change("idle");
				on_leave();
			}
		},
		
		on_kill : function(){
			set_scale();
			button_text_decrease_size();
		}
	});

	fsm.add("clicked", {
		enter : function(){
			image_index = 1;
		},
		leave : function(){
			image_index = 0;
		},
		step : function(){
			if(!blackboard.input_holding_click){ 
				if(check_collision()){
					on_click();
					fsm.change("on_it");
				}
				else{
					fsm.change("idle");
					on_leave();
				}
			}
		},
		on_kill : function(){
			set_scale();
			button_text_decrease_size();
		}
	});
}
	
#endregion
