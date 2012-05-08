package com.grapefrukt.sound {
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class MP3LoopEmbedded extends MP3LoopBase{
		
		public function MP3LoopEmbedded(soundClass:Class, autoLoad:Boolean, loops:int = 0) {
			super("", false, false, loops);
			
			_out = new soundClass() as Sound;
			
			if(autoLoad) load();
		}
		
		override public function load():void {
			handleLoadComplete(null);
		}
		
	}

}