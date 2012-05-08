package com.grapefrukt.sound {
	import com.grapefrukt.sound.event.MP3LoopEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class MP3LoopBase extends EventDispatcher {
		
		public static var ASSET_CLASS		:Class;
		
		protected var _out					:Sound; 				// Used for output stream
		
		protected var _play_on_load			:Boolean = 	false;
		protected var _state				:int = 		NOT_LOADED;
		protected var _playing				:Boolean = 	false;
		protected var _loops				:int =		0;
		
		protected var _url					:String = 	"";
		protected var _out_channel			:SoundChannel;			// Used for output stream
		
		protected var _bytes_total			:int = 0;
		protected var _bytes_loaded			:int = 0;
		
		protected static const NOT_LOADED	:int = 0;
		protected static const LOADING		:int = 1;
		protected static const LOADED		:int = 2;
		
		public function MP3LoopBase(url:String, autoLoad:Boolean = false, playOnLoad:Boolean = false, loops:int = 0) {
			_url = url;
			_loops = loops;
			this.playOnLoad = playOnLoad;
			
			_out = new Sound;
			
			if(autoLoad && _url) load();
		}
		
		public function load(): void {
			trace("MP3LoopBase, load()", _state);
			if (loaded || loading) return;
			
			if (ASSET_CLASS) {
				_state = LOADING;
				_out = new ASSET_CLASS[_url.substr(0, _url.length - 4)] as Sound;
				
				var t:Timer = new Timer(100, 1);
				t.addEventListener(TimerEvent.TIMER_COMPLETE, function():void {
					t.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);
					handleLoadComplete(null);
				});
				t.start();
				
			} else {
				_state = LOADING;
				_out.addEventListener( Event.COMPLETE, 			handleLoadComplete );
				_out.addEventListener( ProgressEvent.PROGRESS, 	handleProgress);
				_out.addEventListener( IOErrorEvent.IO_ERROR, 	handleLoadError );
				_out.load( new URLRequest( _url ) );
			}
		}
		
		private function handleProgress(e:ProgressEvent):void {
			_bytes_total = _out.bytesTotal;
			_bytes_loaded = _out.bytesLoaded;
			
			dispatchEvent(e);
		}
		
		protected function handleLoadComplete( event:Event ):void {
			trace("MP3LoopBase, handleLoadComplete()", _state);
			_state = LOADED;
			dispatchEvent(new MP3LoopEvent(MP3LoopEvent.COMPLETE, this));
			if (_play_on_load) 	play();
		}
		
		public function play():Boolean {
			trace("playing loop, state:", _state);
			if (_playing || !loaded) return false;
			_out_channel = _out.play(0, _loops);
			_playing = true;
			dispatchEvent(new MP3LoopEvent(MP3LoopEvent.PLAY, this));
			return true;
		}
		
		public function stop():Boolean {
			if (!_playing) return false;
			_out_channel.stop();
			_playing = false;
			dispatchEvent(new MP3LoopEvent(MP3LoopEvent.STOP, this));
			return true;
		}
		
		private function handleLoadError( event:IOErrorEvent ):void {
			trace( event );
		}
		
		public function get loaded():Boolean { return _state == LOADED; }
		public function get loading():Boolean { return _state == LOADING; }
		
		public function get soundChannel():SoundChannel { return _out_channel; }
		
		public function get playOnLoad():Boolean { return _play_on_load; }
		public function set playOnLoad(value:Boolean):void { _play_on_load = value; }
		public function get playing():Boolean { return _playing; }
		
		public function get bytesTotal():int { return _bytes_total; }
		public function get bytesLoaded():int { return _bytes_loaded; }
		
	}

}