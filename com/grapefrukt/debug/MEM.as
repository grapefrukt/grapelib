package com.grapefrukt.debug
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class MEM extends Sprite
	{

		private var mem_text:TextField;		
		private var update_timer:Timer;

		public function MEM(color:uint = 0xffffff) {
						
			var textformat:TextFormat = new TextFormat("Arial");
			
			mem_text = new TextField();
			mem_text.textColor = color;
			mem_text.selectable = false;
			mem_text.autoSize = TextFieldAutoSize.LEFT;
			mem_text.setTextFormat(textformat);
			mem_text.defaultTextFormat = textformat;
			addChild(mem_text);
			
			update_timer = new Timer(250);
			update_timer.start();
			
			update_timer.addEventListener(TimerEvent.TIMER, onTimerCallback);
		}

		private function onTimerCallback(event:Event):void	{			
			mem_text.text = "mem: " + Number(System.totalMemory / (1024 * 1024)).toFixed(1) + " MB";
		}
	}
}