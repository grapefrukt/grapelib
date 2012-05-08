package com.grapefrukt.sound {
	
	import com.grapefrukt.sound.event.MP3LoopEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * Playback MP3-Loop (gapless)
	 *
	 * This source code enable sample exact looping of MP3.
	 * 
	 * http://blog.andre-michelle.com/2010/playback-mp3-loop-gapless/
	 *
	 * Tested with samplingrate 44.1 KHz
	 *
	 * <code>MAGIC_DELAY</code> does not change on different bitrates.
	 * Value was found by comparision of encoded and original audio file.
	 *
	 * @author andre.michelle@audiotool.com (04/2010)
	 */
	
	public class MP3LoopGapless extends MP3LoopBase {
		
		private const MAGIC_DELAY		:Number = 	2257.0; 	// LAME 3.98.2 + flash.media.Sound Delay
		private const BUFFER_SIZE		:int = 		2048; 		// Stable playback
		
		private var _samples_total		:int = 		0; 			// original amount of sample before encoding (change it to your loop)
		private var _mp3				:Sound;					// Used for decoding
		private var _samples_position	:int = 		0;
		
		public function MP3LoopGapless(samplesTotal:int, url:String = "", autoLoad:Boolean = false, playOnLoad:Boolean = false) {
			super(url, autoLoad, playOnLoad);
			_samples_total = samplesTotal;
			if (_samples_total == 0) throw new Error("sound must be longer than zero samples");
			_mp3 = new Sound;
		}
		
		override protected function handleLoadComplete(event:Event):void {
			_mp3 = _out;
			_out = new Sound;
			super.handleLoadComplete(event);
		}
		
		override public function play():Boolean {
			if (_playing || !loaded) return false;
			_out.addEventListener( SampleDataEvent.SAMPLE_DATA, handleSampleDataRequest );
			super.play();
			return true;
		}
		
		override public function stop():Boolean {
			if (!super.stop()) return false;
			_out.removeEventListener( SampleDataEvent.SAMPLE_DATA, handleSampleDataRequest );
			return true;
		}
		
		private function handleSampleDataRequest( event:SampleDataEvent ):void {
			extract( event.data, BUFFER_SIZE );
		}
		
		/**
		 * This methods extracts audio data from the mp3 and wraps it automatically with respect to encoder delay
		 *
		 * @param target The ByteArray where to write the audio data
		 * @param length The amount of samples to be read
		 */
		private function extract( target: ByteArray, length:int ):void {
			while( 0 < length ) {
				if( _samples_position + length > _samples_total ) {
					var read: int = _samples_total - _samples_position;
					_mp3.extract( target, read, _samples_position + MAGIC_DELAY );
					_samples_position += read;
					length -= read;
				} else {
					_mp3.extract( target, length, _samples_position + MAGIC_DELAY );
					_samples_position += length;
					length = 0;
				}
				
				if( _samples_position == _samples_total ) { // END OF LOOP > WRAP
					_samples_position = 0;
				}
			}
		}
		
		
	}
}