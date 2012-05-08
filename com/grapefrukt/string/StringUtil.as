package com.grapefrukt.string {
	/**
	 * ...
	 * @author Martin Jonasson
	 */
	public class StringUtil {
		
		public static function padStart(string:String, len:int, padding:String):String {
			while (string.length < len) string = padding + string;
			return string;
		}
		
		public static function zeroPad(string:String, len:int):String {
			while (string.length < len) string = '0' + string;
			return string;
		}
		
		public static function secondsToTime(seconds:int, separator:String = ":"):String {
			/*var hours:int = seconds / 60 / 60;
			seconds -= hours * 60 * 60;*/
			var minutes:int = seconds / 60;
			seconds -= minutes * 60;
			return zeroPad(minutes.toString(), 2) + separator + zeroPad(seconds.toString(), 2);
		}
		
	}

}