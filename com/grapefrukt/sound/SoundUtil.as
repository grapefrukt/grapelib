/**
 * SoundManager
 * A bunch of convenience methods for playing sounds
 *
 * @author		Martin Jonasson
 * @version		1.0
 */

/* 
Licensed under the MIT License

Copyright (c) 2009 Martin Jonasson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

http://www.grapefrukt.com/blog/

*/

package com.grapefrukt.sound {
	import flash.display.DisplayObject;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
		
	public class SoundUtil {
		/**
		 * Sets the stage width used for sounds on DisplayObjects
		 */
		public static var stageWidth:uint = 800;
		
		/**
		 * Sets the stereo separation used for sounds on DisplayObjects
		 */
		public static var stereoSeparation:Number = 0.75;
		
		/**
		 * Sets the global volume for all future sounds played (if you already have sounds playing you will need to update them)
		 */
		public static var globalVolume:Number = 1;
		
		/**
		 * Plays a Sound at the specified DisplayObjects x coordinates
		 * @param	sound	The Sound you want to play
		 * @param	target	The target DisplayObject
		 * @param	volume	The relative volume of the sound (0 to 1)
		 * @param	loops	The number of loops you want the sound to play for
		 * @return			The SoundChannel in which the sound is playing
		 */
		public static function playAtSprite(sound:Sound, target:DisplayObject = null, volume:Number = 1, loops:uint = 0):SoundChannel{
			return play(sound, volume, getPan(target), loops);
		}
		
		/**
		 * Plays a sound from an embedded class at the specified DisplayObjects x coordinates
		 * @param	soundClass	The Class you want to play
		 * @param	target		The target DisplayObject
		 * @param	volume		The relative volume of the sound (0 to 1)
		 * @param	loops		The number of loops you want the sound to play for
		 * @return				The SoundChannel in which the sound is playing
		 */
		public static function playClassAtSprite(soundClass:Class, target:DisplayObject = null, volume:Number = 1, loops:uint = 0):SoundChannel{
			return playAtSprite(getClassAsSound(soundClass), target, volume, loops);
		}
		
		/**
		 * Plays a sound
		 * @param	sound	The sound you want to play
		 * @param	target	The target DisplayObject
		 * @param	volume	The relative volume of the sound (0 to 1)
		 * @param	pan		The pan of the sound (-1 to 1)
		 * @param	loops	The number of loops you want the sound to play for
		 * @return			The SoundChannel in which the sound is playing
		 */
		public static function play(sound:Sound, volume:Number = 1, pan:Number = 0, loops:uint = 0):SoundChannel {
			return sound.play(0, loops, generateTransform(volume, pan));
		}
		
		/**
		 * Plays a sound from an embedded class
		 * @param	sound	The sound you want to play
		 * @param	target	The target DisplayObject
		 * @param	volume	The relative volume of the sound (0 to 1)
		 * @param	pan		The pan of the sound (-1 to 1)
		 * @param	loops	The number of loops you want the sound to play for
		 * @return			The SoundChannel in which the sound is playing
		 */
		public static function playClass(soundClass:Class, volume:Number = 1, pan:Number = 0, loops:uint = 0):SoundChannel {
			return play(getClassAsSound(soundClass), volume, pan, loops);
		}
		
		/**
		 * Casts a plain Class to Sound
		 */
		public static function getClassAsSound(soundClass:Class):Sound {
			return new soundClass as Sound;
		}
		
		/**
		 * Generates a sound transform from the values you specify, all values are wrapped
		 * @param	volume	The volume of the sound (0 to 1)
		 * @param	pan		The pan of the sound (-1 to 1) 
		 * @return
		 */
		public static function generateTransform(volume:Number = 1, pan:Number = 0):SoundTransform {
			var st:SoundTransform = new SoundTransform();
			st.volume 	= wrapVol(volume / 10) * 2 * globalVolume;
			st.pan 		= wrapPan(pan);
			return st;
		}
		
		/**
		 * Updates the SoundTransform on an already created SoundChannel
		 * @param	soundChannel	The sound channel which transform you want to change
		 * @param	volume			The relative volume of the sound  0 to 1)
		 * @param	pan				The pan of the sound (-1 to 1) 
		 */
		public static function setNewTransform(soundChannel:SoundChannel,  volume:Number = 1, pan:Number = 0):void {
			soundChannel.soundTransform = generateTransform(volume, pan);
		}
		
		/**
		 * Updates the SoundTransform of a channel using the position of the DisplayObject
		 * @param	soundChannel	The sound channel which transform you want to change
		 * @param	target			The target DisplayObject
		 * @param	volume			The relative volume of the sound  0 to 1)
		 */
		public static function updateTransformAtSprite(soundChannel:SoundChannel, target:DisplayObject = null, volume:Number = 1):void {
			setNewTransform(soundChannel, volume, getPan(target));
		}
		
		/**
		 * Calculates the position of the DisplayObject relative to the set stageWidth
		 * @param	target	The target DisplayObject
		 * @return			The pan of the sound (-1 to 1)
		 * @see	stageWidth
		 */
		private static function getPan(target:DisplayObject):Number {
			var pan:Number = (target.x / stageWidth) * 2 - 1; 
			return pan * stereoSeparation;
		}
		
		/**
		 * Wraps a value to within zero to one
		 * @param	num	A number of any value
		 * @return	The number wrapped to a max of one and a min of zero
		 */
		private static function wrapVol(num:Number):Number{
			if(num > 1) num = 1;
			if(num < 0) num = 0;
			return num;
		}
		
		/**
		 * Wraps a value between negative one and one
		 * @param	num A number of any value
		 * @return The number wrapped to a max of one and a min of negative one
		 */
		private static function wrapPan(num:Number):Number{
			if(num > 1)  num = 1;
			if(num < -1) num = -1;
			return num;
		}
	}
}