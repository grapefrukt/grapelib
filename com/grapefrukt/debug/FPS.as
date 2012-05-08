package com.grapefrukt.debug
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import flash.events.Event;

	public class FPS extends Sprite
	{
		private var frametimes:Array;
		private var last_tick:uint = 0;
		private var fps_text:TextField;
		private var target_fps:Number = 0;
		private var manual_update:Boolean = false;
		private var fps_label:String = "FPS";
		
		private var _t:Number = 0;
		private var _sum:Number = 0;
		private var _average:Number = 0;
		
		private var insert_pos:int = 0;
		
		private var BUFFER_SIZE:uint = 0;
		
		public var speedFraction:Number = 1;

		public function FPS(_target_fps:Number, _label:String = "fps", _manual_update:Boolean = false, textColor:int = 0xffffff) {
			target_fps = _target_fps;
			BUFFER_SIZE = target_fps;
			
			fps_label = _label;
			manual_update = _manual_update;
			
			frametimes = new Array();
			
			for (var i:int = 0; i < BUFFER_SIZE; i++) frametimes.push(0);
			
			last_tick  = getTimer();
			
			var textformat:TextFormat = new TextFormat("Arial");
			
			fps_text = new TextField();
			fps_text.textColor = textColor;
			fps_text.selectable = false;
			fps_text.autoSize = TextFieldAutoSize.LEFT;
			fps_text.setTextFormat(textformat);
			fps_text.defaultTextFormat = textformat;
			addChild(fps_text);
			
			if(manual_update == false) addEventListener(Event.ENTER_FRAME, tick);
		}

		public function tick(event:Event = null):void	{
			_t = getTimer() - last_tick;
			last_tick = getTimer();
				
			frametimes[insert_pos] = _t;
			insert_pos++;
			if (insert_pos > BUFFER_SIZE) insert_pos = 0;
			
			_sum = 0;
			for each (var i:uint in frametimes)	_sum += i;
			
			_average = _sum / BUFFER_SIZE;
			
			speedFraction = (1000/target_fps)/_average;
			
			fps_text.text = fps_label + ": " + Number(1000 / _average).toFixed(1) + " (" + Number(speedFraction*100).toFixed(0) + "%)";
		}
		
		public function get average():Number { return _average; }
	}
}