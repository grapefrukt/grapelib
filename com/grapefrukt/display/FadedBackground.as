package com.grapefrukt.display {
	
	import com.grapefrukt.display.utilities.ColorConverter;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	/**
	* ...
	* @author Martin Jonasson
	*/
	public class FadedBackground extends Sprite {
		
		private var _base_color			:uint = 0x619928;
		private var _faded_color		:uint;
		private var _gfx				:Shape;
		private var _baseWidth			:Number = 0;
		private var _baseHeight			:Number = 0;
		
		private var _stageNormalWidth	:Number = 0;
		private var _stageNormalHeight	:Number = 0;
		private var _ratios:Array;
		
		public function FadedBackground(newColor:uint, stageNormalWidth:Number, stageNormalHeight:Number, fadedColor:uint = 0x000000, ratios:Array = null):void {
			_base_color = newColor;
			_stageNormalWidth = stageNormalWidth;
			_stageNormalHeight = stageNormalHeight;
			
			if(fadedColor == 0x000000){
				var fadedColorHSB:Array = ColorConverter.UINTtoHSB(_base_color);
				fadedColorHSB[2] *= 0.3;
				fadedColor = ColorConverter.HSBtoUINT(fadedColorHSB[0], fadedColorHSB[1], fadedColorHSB[2]);
			}
			_faded_color = fadedColor;
			
			if(!ratios) ratios = [0x00, 0xFF]
			_ratios = ratios;
			
			_gfx = new Shape();
			addChild(_gfx);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function resizeHandler(event:Event):void {
			var stageRatio:Number = stage.stageWidth / stage.stageHeight;
			var bkgRatio:Number = _baseWidth / _baseWidth;
			
			if(stageRatio >= bkgRatio){				
				width = stage.stageWidth;
				height = width / _baseWidth * _baseWidth;
			} else {
				height = stage.stageHeight;
				width = height / _baseWidth * _baseWidth;
			}
			
		}
		
        private function addedToStageHandler(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			redraw();
			resizeHandler(null);
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		public function redraw(newColor:int = -1):void {
			if(newColor >= 0) _base_color = newColor;
			
			graphics.clear();
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [_base_color, _faded_color];
			var alphas:Array = [1, 1];
			var ratios:Array = _ratios;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(300, 300, 0, -50, -50);
			var spreadMethod:String = SpreadMethod.PAD;
			_gfx.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod, null);  
			_gfx.graphics.drawRect(0, 0, 200, 200);
			
			_baseWidth = _gfx.width;
			_baseWidth = _gfx.height;
			
			_gfx.x = -_baseWidth / 2;
			_gfx.y = -_baseWidth / 2;
			x = _stageNormalWidth / 2;
			y = _stageNormalHeight / 2;
		}
	}
	
}