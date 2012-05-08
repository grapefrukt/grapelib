package com.grapefrukt.debug {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TXT extends Sprite {
		
		private var txt_text:TextField;
		
		public function TXT(color:uint = 0xffffff, size:uint = 12){
			
			var textformat:TextFormat = new TextFormat("Arial", size);
			
			txt_text = new TextField();
			txt_text.textColor = color;
			txt_text.selectable = false;
			//txt_text.autoSize = TextFieldAutoSize.LEFT;
			txt_text.setTextFormat(textformat);
			txt_text.defaultTextFormat = textformat;
			addChild(txt_text);
			
			mouseChildren = false;
			mouseEnabled = false;
			
			txt_text.mouseWheelEnabled = true;
			
			txt_text.height = 580;
			txt_text.width = 400;
		}
		
		public function setText(str:String):void {
			txt_text.text = str + "\n";
		}
		
		public function appendText(str:String):void {
			txt_text.appendText(str + "\n");
		}
		
		public function set selectable(value:Boolean):void {
			txt_text.selectable = value;
		}
	
	}
}