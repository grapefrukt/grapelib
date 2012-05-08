package com.grapefrukt.display.utilities {
	// Stolen from http://d.hatena.ne.jp/flashrod/20060930#1159622027
	// Modded by grapefrukt
	
	public class ColorConverter {
	
		/**
		 * Converts a RGB uint value in to it's discrete r, g and b parts
		 * @param	color The color you want to split
		 * @return  RGB ([0] = red, [1] = green, [2] = blue)
		 */
		public static function UINTtoRGB(color:uint):Array {
			var r:uint = (color >> 16) & 0xFF;
			var g:uint = (color >> 8) & 0xFF;
			var b:uint = color & 0xFF;
			
			return [r, g, b];
		}
		
		/**
		 * Converts a RGB uint value into hue, saturation and brightness
		 * @param	color The color you want to split
		 * @return HSB ([0]=hue, [1]=saturation, [2]=brightness)
		 */
		public static function UINTtoHSB(color:uint):Array {
			var rgb:Array = UINTtoRGB(color);
			return RGBtoHSB(rgb[0], rgb[1], rgb[2]);
		}
		
		/** 
		 * Converts three distinct HSB values to three separate RGB values
		 * @param hue (0.0 - 1.0)
		 * @param saturation (0.0 - 1.0)
		 * @param brightness (0.0 - 1.0)
		 * @return RGB ([0] = red, [1] = green, [2] = blue)
		*/
		public static function HSBtoRGB(hue:Number, saturation:Number, brightness:Number):Array {
			return UINTtoRGB(HSBtoUINT(hue, saturation, brightness));
		}
		
		/**
		 * Merges three distinct RGB values into a single uint
		 * @param r Red channel (0-255)
		 * @param g Green channel (0-255)
		 * @param b Blue channel (0-255)
		 * @return The color as an uint
		 */
		public static function RGBtoUINT(r:int, g:int, b:int):uint {
			return (r << 16) | (g << 8) | (b << 0);
		}
		
		/**
		 * Converts three distinct RGB values to three HSB values
		 * @param r Red channel (0-255)
		 * @param g Green channel (0-255)
		 * @param b Blue channel (0-255)
		 * @return HSB ([0]=hue, [1]=saturation, [2]=brightness)
		 */
		public static function RGBtoHSB(r:int, g:int, b:int):Array {
			var cmax:Number = Math.max(r, g, b);
			var cmin:Number = Math.min(r, g, b);
			var brightness:Number = cmax / 255.0;
			var hue:Number = 0;
			var saturation:Number = (cmax != 0) ? (cmax - cmin) / cmax : 0;
			if (saturation != 0) {
				var redc:Number = (cmax - r) / (cmax - cmin);
				var greenc:Number = (cmax - g) / (cmax - cmin);
				var bluec:Number = (cmax - b) / (cmax - cmin);
				if (r == cmax) {
					hue = bluec - greenc;
				} else if (g == cmax) {
					hue = 2.0 + redc - bluec;
				} else {
					hue = 4.0 + greenc - redc;
				}
				hue = hue / 6.0;
				if (hue < 0) {
					hue = hue + 1.0;
				}
			}
			return [hue, saturation, brightness];
		}

		/** 
		 * Converts three distinct HSB values to an RGB-uint
		 * @param hue ?????? (0.0 - 1.0)
		 * @param saturation ???? (0.0 - 1.0)
		 * @param brightness ???? (0.0 - 1.0)
		 * @return RGB
		*/
		public static function HSBtoUINT(hue:Number, saturation:Number, brightness:Number):uint {
			var r:int = 0;
			var g:int = 0;
			var b:int = 0;
			if (saturation == 0) {
				r = g = b = brightness * 255.0 + 0.5;
			} else {
				var h:Number = (hue - int(hue)) * 6.0;
				var f:Number = h - int(h);
				var p:Number = brightness * (1.0 - saturation);
				var q:Number = brightness * (1.0 - saturation * f);
				var t:Number = brightness * (1.0 - (saturation * (1.0 - f)));
				switch (int(h)) {
				case 0:
					r = brightness * 255.0 + 0.5;
					g = t * 255.0 + 0.5;
					b = p * 255.0 + 0.5;
					break;
				case 1:
					r = q * 255.0 + 0.5;
					g = brightness * 255.0 + 0.5;
					b = p * 255.0 + 0.5;
					break;
				case 2:
					r = p * 255.0 + 0.5;
					g = brightness * 255.0 + 0.5;
					b = t * 255.0 + 0.5;
					break;
				case 3:
					r = p * 255.0 + 0.5;
					g = q * 255.0 + 0.5;
					b = brightness * 255.0 + 0.5;
					break;
				case 4:
					r = t * 255.0 + 0.5;
					g = p * 255.0 + 0.5;
					b = brightness * 255.0 + 0.5;
					break;
				case 5:
					r = brightness * 255.0 + 0.5;
					g = p * 255.0 + 0.5;
					b = q * 255.0 + 0.5;
					break;
				}
			}
			return (r << 16) | (g << 8) | (b << 0);
		}
	 }
}