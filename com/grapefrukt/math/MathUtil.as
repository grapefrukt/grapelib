package com.grapefrukt.math {
	
	/**
	 * ...
	 * @author Martin Jonasson
	 */
	public class MathUtil {
		
		public static function wrap(value:Number, max:Number = 1, min:Number = 0):Number {
			while (value >= max) value -= (max - min);
			while (value < min) value += (max - min);
			return value;
		}
		
		public static function clamp(value:Number, max:Number = 1, min:Number = 0):Number {
			if (value > max) return max;
			if (value < min) return min;
			return value;
		}
		
		public static function parseNumber(value:String, nanAsZero:Boolean = false):Number {
			value = value.replace(",", ".");
			var val:Number = parseFloat(value);
			if (nanAsZero && isNaN(val)) val = 0;
			return val;
		}
		
		public static function parseBoolean(value:String):Boolean {
			if (value == "true") return true;
			if (value == "1") return true;
			if (value == "yes") return true;
			return false;
		}
		
		
	}

}