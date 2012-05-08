package com.grapefrukt.sound.event {
	import com.grapefrukt.sound.MP3LoopBase;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class MP3LoopEvent extends Event {
		
		public static const PLAY		:String = "mp3loopevent_play";
		public static const STOP		:String = "mp3loopevent_stop";
		public static const COMPLETE	:String = "mp3loopevent_complete";
		
		private var _loop:MP3LoopBase;
		
		public function MP3LoopEvent(type:String, loop:MP3LoopBase) { 
			super(type, bubbles, cancelable);
			_loop = loop;
		} 
		
		public override function clone():Event { 
			return new MP3LoopEvent(type, _loop);
		} 
		
		public override function toString():String { 
			return formatToString("MP3LoopEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get loop():MP3LoopBase { return _loop; }
		
	}
	
}