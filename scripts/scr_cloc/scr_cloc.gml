/// By @jalesjefferson
/// source code https://github.com/JeffersonJales/Clock_GMS2

/// Clock that returns a boolean
function Clock (time, loop = true, clock_speed = 1) constructor {
	__time = time;
	__max_time = time;
	__loop = loop;
	
	__clock_speed = clock_speed;
	__clock_speed_pause = clock_speed;

	static clock_step = function(){
		__time -= __clock_speed;
		
		if(__time < 0){
			if(!__loop) clock_kill(); // You can change it to clock_pause too
			clock_reset();
			return true;	
		}
		
		return false;
	}
	
	static clock_reset = function(){
		__time = __max_time;
	}
	
	static clock_change_time = function(new_time, reset_clock = true){
		__max_time = new_time;
		if(reset_clock) clock_reset();
	}
	
	static clock_change_speed = function(new_speed){
		__clock_speed = new_speed;
	}
	
	static clock_pause = function(){
		if(__clock_speed != 0)
			__clock_speed_pause = __clock_speed;
		
		__clock_speed = 0;	
	}
	
	static clock_resume = function(){
		__clock_speed = __clock_speed_pause;
	}
		
	static clock_kill = function(){
		clock_step = do_nothing;
	}
	
	static clock_get_remaining = function(){
		return __time;
	}

	static clock_get_remaining_perc = function(){
		return 1 - __time / __max_time;
	}
	
	static clock_get_remaining_perc_total = function(){
		return __time / __max_time;
	}
		
	static clock_add_time = function(time_to_add){
		__time += time_to_add;
	}
}

/// Clock with callback
function ClockCB(time, callback, loop = true, clock_speed = 1) : Clock(time, loop, clock_speed) constructor {
	__target = other;
	__clock_callback = method(__target, callback);
	
	static clock_kill = function(){
		clock_step = do_nothing;
		__clock_callback = do_nothing;
	}
	static clock_step = function(){
		__time -= __clock_speed;
		if(__time < 0){
			if(!__loop) clock_kill();
			clock_reset();
			__clock_callback();
		}
	}
	static clock_change_callback = function(new_callback){
		__clock_callback = method(__target,new_callback);
	}
}
	
function to_seconds(time){
	return time * room_speed;	
}
