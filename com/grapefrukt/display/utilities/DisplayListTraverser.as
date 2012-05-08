package com.grapefrukt.display.utilities {
	import com.grapefrukt.string.StringUtil;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class DisplayListTraverser {
		
		public static function explore(root:DisplayObjectContainer):void {
			traverse(root);
		}
		
		private static function traverse(node:DisplayObjectContainer, level:int = 0, childCount:int = 0):int {
			var displayObject			:DisplayObject;
			var displayObjectContainer	:DisplayObjectContainer;
			
			for (var i:int = 0; i < node.numChildren; i++) {
				
				displayObject 			= node.getChildAt(i) as DisplayObject;
				displayObjectContainer 	= node.getChildAt(i) as DisplayObjectContainer;
				
				trace(StringUtil.padStart("", level, "\t") + node.getChildAt(i).name + "\t" + node.getChildAt(i) + "\t" +  node.getChildAt(i).alpha + "\t" +  node.getChildAt(i).visible);
				
				if (displayObjectContainer) {
					childCount += traverse(displayObjectContainer, level+1);
				} else {
					childCount++;
				}
			}
			
			return childCount;
		}
	}

}