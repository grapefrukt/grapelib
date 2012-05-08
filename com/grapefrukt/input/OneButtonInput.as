package com.grapefrukt.input {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Martin Jonasson (grapefrukt@grapefrukt.com)
	 */
	
	/*	Key        Ascii   Key     Ascii   Key      Ascii   Key       Ascii    
		L-Button   1       2       50      W        87      F12       123      
		R-Button   2       3       51      X        88      F13       124      
		Cancel     3       4       52      Y        89      F14       125      
		M-Button   4       5       53      Z        90      F15       126      
		Back       8       6       54      NP - 0   96      F16       127      
		Tab        9       7       55      NP - 1   97      F17       128      
		Clear      12      8       56      NP - 2   98      F18       129      
		Return     13      9       57      NP - 3   99      F19       130      
		Shift      16      A       65      NP - 4   100     F20       131      
		Control    17      B       66      NP - 5   101     F21       132      
		Menu       18      C       67      NP - 6   102     F22       133      
		Pause      19      D       68      NP - 7   103     F23       134      
		Cap        20      E       69      NP - 8   104     F24       135      
		Escape     27      F       70      NP - 9   105     Numlock   144      
		Space      32      G       71      *        106     Scroll    145      
		Prior      33      H       72      +        107     Rshift    161      
		Next       34      I       73      -        109     L-Ctrl    162      
		End        35      J       74      .        110     R-Ctrl    163      
		Home       36      K       75      /        111     L-Menu    164      
		Left       37      L       76      F1       112     R-Menu    165      
		Up         38      M       77      F2       113     =         187      
		Right      39      N       78      F3       114     ,         188      
		Down       40      O       79      F4       115     [         189      
		Select     41      P       80      F5       116     .         190      
		PrintScrn  44      Q       81      F6       117     /         191      
		Insert     45      R       82      F7       118     '         192      
		Delete     46      S       83      F8       119     [         219      
		Help       47      T       84      F9       120     /         220      
		0          48      U       85      F10      121     ]         221      
		1          49      V       86      F11      122     '         222   
	*/

	public class OneButtonInput extends EventDispatcher {
		
		private var _keyCode				:int = 32;
		private var _resetChangedOnReadout	:Boolean = true;
		private var _keyState				:Boolean = false;
		private var _changedSinceLastReadout:Boolean = false;
		private var _last_was_keyboard		:Boolean = true;
		
		public function OneButtonInput(stage:Stage, keyCode:int = 32, resetChangedOnReadout:Boolean = true) {
			_keyCode = keyCode;
			_resetChangedOnReadout = resetChangedOnReadout;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKey);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouse);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouse);
			
		}
		
		private function handleMouse(e:MouseEvent):void {
			var oldKeyState:Boolean = _keyState;
			
			_keyState = false;
			if (e.type == MouseEvent.MOUSE_DOWN) _keyState = true;
			
			_last_was_keyboard = false;
			
			if (_keyState != oldKeyState) {
				dispatchEvent(new Event(Event.CHANGE, false, true));
				_changedSinceLastReadout = true;
			}
		}
		
		private function handleKey(e:KeyboardEvent):void {
			if (e.keyCode != _keyCode) return;
			
			var oldKeyState:Boolean = _keyState;
			
			_keyState = false;
			if (e.type == KeyboardEvent.KEY_DOWN) _keyState = true;
			
			_last_was_keyboard = true;
			
			if (_keyState != oldKeyState) {
				dispatchEvent(new Event(Event.CHANGE, false, true));
				_changedSinceLastReadout = true;
			}
		}
		
		public function get isChanged():Boolean {
			var tmp:Boolean = _changedSinceLastReadout;
			if (_resetChangedOnReadout) _changedSinceLastReadout = false;
			return tmp;
		}
		
		public function get isDown():Boolean { 
			return _keyState; 
		}
		
		/**
		 * Is set to true if the last input update came from the keyboard, false if it was the mouse
		 */
		public function get lastWasKeyboard():Boolean { return _last_was_keyboard; }
		
		public function resetChanged():void {
			_changedSinceLastReadout = false;
		}
		
	}
	
}