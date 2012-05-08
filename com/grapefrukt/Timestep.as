package com.grapefrukt {
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Timestep {
		
		private var _game_speed			:Number = 1;
		private var _target_frametime	:Number = 0.6;
		private var _max_speed			:Number = 3;
		private var _smoothing			:Number = .5;
		
		private var _real_speed			:Number = 0.0;
		private var _last_frame_time	:Number = 0.0;
		private var _delta				:Number = 0.0;
		
		/**
		 * Initializes the timestepper
		 * @param	fps			The target framerate you wish to maintain
		 * @param	gameSpeed	The game's speed, useful for slowdown effects or general speed tweaking. 1 = 100% speed.
		 * @param	maxSpeed	The maximum size of a timeDelta, steps will not be bigger than this
		 * @param	smoothing	How much to smooth the step size across ticks, 1 gives old value full priority (value will never change), 0 means no smoothing, so new value will be used. 
		 */
		public function Timestep(fps:int = 60, gameSpeed:Number = 1.0, maxSpeed:Number = 3.0, smoothing:Number = 0.5) {
			_target_frametime = 1000 / fps;
			_smoothing = smoothing;
			this.gameSpeed = gameSpeed;
			this.maxSpeed = maxSpeed;
		}
		
		/**
		 * Call this function every frame to get a updated timeDelta
		 * @return	timeDelta
		 */
		public function tick():Number {
			_real_speed = (getTimer() - _last_frame_time) / _target_frametime;
			_last_frame_time = getTimer();
			
			if (_real_speed > _max_speed) _real_speed = _max_speed;
			
			_delta -= (_delta - _real_speed) * (1 - _smoothing);
			
			return _delta * _game_speed;
		}
		
		public function get timeDelta():Number { return _delta * _game_speed; }
		
		public function get maxSpeed():Number {	return _max_speed; }
		public function set maxSpeed(value:Number):void { _max_speed = value; }
		
		public function get gameSpeed():Number { return _game_speed; }
		public function set gameSpeed(value:Number):void { _game_speed = value;	}
		
		public function get smoothing():Number { return _smoothing; }
		public function set smoothing(value:Number):void {
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			_smoothing = value;
		}
		
	}

}