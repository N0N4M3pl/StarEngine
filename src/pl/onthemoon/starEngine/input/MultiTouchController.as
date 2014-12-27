/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.01.13
 * Time: 21:29
 */
package pl.onthemoon.starEngine.input {

import flash.events.EventPhase;
import flash.geom.Point;

import starling.core.Starling;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MultiTouchController extends Controller {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _touches:Vector.<Touch>;

	protected var _isBegan:Vector.<Boolean>;
	protected var _isMoved:Vector.<Boolean>;
	protected var _isEnded:Vector.<Boolean>;
	protected var _isPressed:Vector.<Boolean>;

	protected var _positionBegan:Vector.<Point>;
	protected var _positionMoved:Vector.<Point>;
	protected var _positionEnded:Vector.<Point>;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function MultiTouchController() {
		_touches = new Vector.<Touch>();

		_isBegan = new Vector.<Boolean>(2, true);
		_isMoved = new Vector.<Boolean>(2, true);
		_isEnded = new Vector.<Boolean>(2, true);
		_isPressed = new Vector.<Boolean>(2, true);

		_positionBegan = new Vector.<Point>(2, true);
		_positionMoved = new Vector.<Point>(2, true);
		_positionEnded = new Vector.<Point>(2, true);
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	override public function connect():void {
		if (_isConnected)
			return;

		for (var i:int = 0; i < 2; i++) {
			_isBegan[i] = false;
			_isMoved[i] = false;
			_isEnded[i] = false;
			_isPressed[i] = false;

			_positionBegan[i] = new Point();
			_positionMoved[i] = new Point();
			_positionEnded[i] = new Point();
		}

		Starling.current.stage.addEventListener(TouchEvent.TOUCH, onTouch);

		super.connect();
	}

	override public function disconnect():void {
		if (!_isConnected)
			return;

		Starling.current.stage.removeEventListener(TouchEvent.TOUCH, onTouch);

		super.disconnect();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function getTouch(index:int = 0):Touch {
		return _touches[index];
	}

	public function isBegan(index:int = 0):Boolean {
		return _isBegan[index];
	}

	public function isMoved(index:int = 0):Boolean {
		return _isMoved[index];
	}

	public function isEnded(index:int = 0):Boolean {
		return _isEnded[index];
	}

	public function isPressed(index:int = 0):Boolean {
		return _isPressed[index];
	}

	public function getPositionBegan(index:int = 0):Point {
		return _positionBegan[index];
	}

	public function getPositionMoved(index:int = 0):Point {
		return _positionMoved[index];
	}

	public function getPositionEnded(index:int = 0):Point {
		return _positionEnded[index];
	}

	//--------------------------------------------------------------------------
	//   METHODS - protected
	//--------------------------------------------------------------------------

	protected function onTouch(e:TouchEvent):void {
		_touches.length = 0;
		e.getTouches(Starling.current.stage, null, _touches);
		var i:int;
		var n:uint = _touches.length;
		if (n > 2) {
			n = 2;
		}
		var touch:Touch;
		for (i = 0; i < n; i++) {
			touch = _touches[i];
			if (touch) {
				switch (touch.phase) {
					case (TouchPhase.BEGAN):
						if (!_isPressed[i]) {
							phaseBegan(i, touch);
//							if (i == 1) {
//								trace("BEGAN | " + i + " | " + _positionBegan[i] + " | bubbles=" + e.bubbles);
//							}
						}
						break;
					case (TouchPhase.MOVED):
						if (_isPressed[i]) {
							phaseMoved(i, touch);
						}
						break;
					case (TouchPhase.ENDED):
						if (_isPressed[i]) {
							phaseEnded(i, touch);
//							if (i == 1) {
//								trace("ENDED | " + i + " | " + _positionEnded[i] + " | bubbles=" + e.bubbles);
//							}
						}
						break;
				}
			}
		}
	}

	protected function phaseBegan(index:int, touch:Touch):void {
		_isBegan[index] = true;
		_isPressed[index] = true;
		_positionBegan[index].setTo(touch.globalX, touch.globalY);
		_positionMoved[index].setTo(touch.globalX, touch.globalY);
	}

	protected function phaseMoved(index:int, touch:Touch):void {
		_isMoved[index] = true;
		_positionMoved[index].setTo(touch.globalX, touch.globalY);
	}

	protected function phaseEnded(index:int, touch:Touch):void {
		_isEnded[index] = true;
		_isPressed[index] = false;
		_positionEnded[index].setTo(touch.globalX, touch.globalY);
		_positionMoved[index].setTo(touch.globalX, touch.globalY);
	}

	//--------------------------------------------------------------------------
	//   METHODS - internal
	//--------------------------------------------------------------------------

	override internal function clear():void {
		super.clear();

		for (var i:int = 0; i < 2; i++) {
			_isBegan[i] = false;
			_isMoved[i] = false;
			_isEnded[i] = false;
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
