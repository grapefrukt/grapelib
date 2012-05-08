package com.grapefrukt.sound {
	import com.gskinner.motion.GTween;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class MP3LoopController {
		
		private var _loop		:MP3LoopBase;
		private var _next_music	:MP3LoopBase;
		private var _gtween		:GTween;
		private var _volume		:Number = 0;
		
		public function MP3LoopController(loop:MP3LoopBase) {
			_loop = loop;
			_gtween = new GTween(this, 1);
			_gtween.onChange = handleTweenChange;
			_gtween.onComplete = handleTweenComplete;
		}
		
		private function handleTweenComplete(g:GTween):void{
			if (_volume == 0) _loop.stop();
		}
		
		private function handleTweenChange(g:GTween):void {
			if (!_loop.soundChannel) return;
			var soundTransform:SoundTransform = _loop.soundChannel.soundTransform;
			soundTransform.volume = _volume;
			_loop.soundChannel.soundTransform = soundTransform;
		}
		
		public function tweenVolume(value:Number):void {
			_gtween.proxy.volume = value;
			
			if (value > 0 && !_loop.playing) _loop.play();
		}
		
		public function play():Boolean {
			if (!_loop.play()) return false;
			
			_loop.soundChannel.soundTransform = new SoundTransform(_volume);
			if (_next_music && !_next_music.loaded) _next_music.load();
			
			return true;
		}
		
		public function setNextMusic(value:MP3LoopBase):void {
			_next_music = value;
		}
		
		public function get volume():Number { return _volume; }
		
		public function set volume(value:Number):void {
			_volume = value;
		}
		
		public function get loop():MP3LoopBase { return _loop; }
		
	}

}