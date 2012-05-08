package com.grapefrukt.display.utilities {
	import flash.display.Graphics;
 
	public class DrawGeometry
	{
 
		
		/*
		 * This function includes code from by Ric Ewing.
		 * @author 	Zack Jordan
		 */
		
		static public function drawIrregularCircle(graphics:Graphics, x:Number, y:Number, radius:Number, irregularity:Number = .2, slices:int = -1):void {
			if (slices < 0) {
				slices = Math.round(Math.sqrt(radius * radius * Math.PI) / 10);
				if (slices < 6) slices = 6;
			}
			
			var angle:Number = Math.random() * 2 * Math.PI; // random offset over 360 degrees (in radians)
			
			var px:Number = 0;
			var py:Number = 0;
			var rndRadius:Number = 0;
			for (var i:int = 0; i < slices; i++) {
				rndRadius = radius * (1 + Math.random() * irregularity * 2 - irregularity / 2)
				//angle *= (1 + Math.random() * irregularity - irregularity / 2);
				px = x + Math.cos(angle) * rndRadius;
				py = y + Math.sin(angle) * rndRadius;
				
				if (i == 0) graphics.moveTo(px, py);
				graphics.lineTo(px, py);
				
				angle += 2 * Math.PI / slices;
			}
			graphics.endFill();
		}

		static public function drawDonut( 
			graphics:Graphics, 
			x:Number, 
			y:Number, 
			xRadius:Number, 
			yRadius:Number, 
			innerXRadius:Number, 
			innerYRadius:Number, 
			color:uint = 0xFF0000, 
			fillAlpha:Number = 1 
		): void
		{
			var segAngle	: Number
			var theta		: Number
			var angle		: Number
			var angleMid	: Number
			var segs		: Number
			var bx		: Number
			var by		: Number
			var cx		: Number
			var cy		: Number;
 
			segs = 8;
			segAngle = 45;
			theta = 0;
			angle = 0;
 
			//graphics.lineStyle( 0, 0x000000, 1 );
			graphics.beginFill( color, fillAlpha );
			graphics.moveTo( 
				x + Math.cos( 0 ) * innerXRadius,
				y + Math.sin( 0 ) * innerYRadius 
			);
 
			// line 1
			graphics.lineTo( 
				x + Math.cos( 0) * xRadius,
				y + Math.sin( 0) * yRadius 
			);
 
			// outer arc
			for ( var i:int = 0; i < segs; i++ ) {
				angle += theta;
				angleMid = angle - ( theta / 2 );
				bx = x + Math.cos( angle ) * xRadius;
				by = y + Math.sin( angle ) * yRadius;
				cx = x + Math.cos( angleMid ) * ( xRadius / Math.cos( theta / 2 ) );
				cy = y + Math.sin( angleMid ) * ( yRadius / Math.cos( theta / 2 ) );
				graphics.curveTo( cx, cy, bx, by );
			}
 
			// line 2
			graphics.lineTo( 
				x + Math.cos( 2 * Math.PI ) * innerXRadius, 
				y + Math.sin( -2 * Math.PI ) * innerYRadius 
			);
 
			theta = -( segAngle / 180 ) * Math.PI;
			angle = -2 * Math.PI;
 
			// inner arc
			for (var j:int = 0; j < segs; j++ ) {
				angle -= theta;
				angleMid = angle + ( theta / 2 );
				bx = x + Math.cos( angle ) * innerXRadius;
				by = y + Math.sin( angle ) * innerYRadius;
				cx = x + Math.cos( angleMid ) * ( innerXRadius / Math.cos( theta / 2 ) );
				cy = y + Math.sin( angleMid ) * ( innerYRadius / Math.cos( theta / 2 ) );
				graphics.curveTo( cx, cy, bx, by );
			}			
			graphics.endFill();			
		}
		 
		 
		/**
		 * Draws a wedge shape onto a Graphics3D instance.
		 * 
		 * @param 	graphics		a Graphics3D instance on which to draw
		 * @param 	x				x position of the center of this wedge
		 * @param	y				y position of the center of this wedge
		 * @param	startAngle		the angle of one straight line of this wedge
		 * @param	arc				the angle (in degrees) of the total arc of this wedge
		 * @param	xRadius			the external radius along the x axis
		 * @param	yRadius			the external radius along the y axis
		 * @param	innerXRadius	the internal radius along the x axis
		 * @param	innerYRadius	the internal radius along the y axis
		 * @param	color			the color of the wedge fill
		 * @param	fillAlpha		the alpha value of the wedge fill
		 * 
		 * @return					nothing
		 */
		static public function drawWedge( 
			graphics:Graphics, 
			x:Number, 
			y:Number, 
			startAngle:Number, 
			arc:Number, 
			xRadius:Number, 
			yRadius:Number, 
			innerXRadius:Number, 
			innerYRadius:Number, 
			color:uint = 0xFF0000, 
			fillAlpha:Number = 1 
		): void
		{
			var segAngle	: Number
			var theta		: Number
			var angle		: Number
			var angleMid	: Number
			var segs		: Number
			var bx		: Number
			var by		: Number
			var cx		: Number
			var cy		: Number;
 
			segs = Math.ceil( Math.abs( arc ) / 45 );
			segAngle = arc / segs;
			theta = -( segAngle / 180 ) * Math.PI;
			angle = -( startAngle / 180 ) * Math.PI;
 
			//graphics.lineStyle( 0, 0x000000, 1 );
			graphics.beginFill( color, fillAlpha );
			graphics.moveTo( 
				x + Math.cos( startAngle / 180 * Math.PI ) * innerXRadius,
				y + Math.sin( -startAngle/180 * Math.PI ) * innerYRadius 
			);
 
			// line 1
			graphics.lineTo( 
				x + Math.cos( startAngle / 180 * Math.PI ) * xRadius,
				y + Math.sin( -startAngle / 180 * Math.PI ) * yRadius 
			);
 
			// outer arc
			for ( var i:int = 0; i < segs; i++ ) {
				angle += theta;
				angleMid = angle - ( theta / 2 );
				bx = x + Math.cos( angle ) * xRadius;
				by = y + Math.sin( angle ) * yRadius;
				cx = x + Math.cos( angleMid ) * ( xRadius / Math.cos( theta / 2 ) );
				cy = y + Math.sin( angleMid ) * ( yRadius / Math.cos( theta / 2 ) );
				graphics.curveTo( cx, cy, bx, by );
			}
 
			// line 2
			graphics.lineTo( 
				x + Math.cos( ( startAngle + arc ) / 180 * Math.PI ) * innerXRadius, 
				y + Math.sin( -( startAngle + arc ) / 180 * Math.PI ) * innerYRadius 
			);
 
			theta = -( segAngle / 180 ) * Math.PI;
			angle = -( ( startAngle + arc ) / 180 ) * Math.PI;
 
			// inner arc
			for (var j:int = 0; j < segs; j++ ) {
				angle -= theta;
				angleMid = angle + ( theta / 2 );
				bx = x + Math.cos( angle ) * innerXRadius;
				by = y + Math.sin( angle ) * innerYRadius;
				cx = x + Math.cos( angleMid ) * ( innerXRadius / Math.cos( theta / 2 ) );
				cy = y + Math.sin( angleMid ) * ( innerYRadius / Math.cos( theta / 2 ) );
				graphics.curveTo( cx, cy, bx, by );
			}			
			graphics.endFill();			
		}
		
		public static function drawTriangle(graphics:Graphics, x:Number, y:Number, size:Number, invert:Boolean = false):void {
			if (invert) {
				graphics.moveTo(x, y - size / 2);
				graphics.lineTo(x + size / 2, y + size / 2);
				graphics.lineTo(x - size / 2, y + size / 2);
			} else {
				graphics.moveTo(x - size / 2, y - size / 2);
				graphics.lineTo(x + size / 2, y - size / 2);
				graphics.lineTo(x, y + size / 2);	
			}
		}
		
		public static function drawArrow(graphics:Graphics, size:Number):void {
			//graphics.drawRect(-size / 4, 0, size/2, size / 2);
			drawTriangle(graphics, 0, size, size);
		}
	}
}