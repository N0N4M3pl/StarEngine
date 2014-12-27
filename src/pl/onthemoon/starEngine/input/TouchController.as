/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.01.13
 * Time: 21:29
 */
package pl.onthemoon.starEngine.input {

import flash.geom.Point;

import starling.core.Starling;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class TouchController extends Controller {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _touch:Touch;

	protected var _isBegan:Boolean;
	protected var _isMoved:Boolean;
	protected var _isEnded:Boolean;
	protected var _isPressed:Boolean;

	protected var _positionBegan:Point;
	protected var _positionMoved:Point;
	protected var _positionEnded:Point;

	protected var _tapCount:int;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	override public function connect():void {
		if (_isConnected)
			return;

		_touch = null;

		_isBegan = false;
		_isMoved = false;
		_isEnded = false;
		_isPressed = false;

		_positionBegan = new Point();
		_positionMoved = new Point();
		_positionEnded = new Point();

		_tapCount = 0;

		Starling.current.stage.addEventListener(TouchEvent.TOUCH, onTouch);

		super.connect();
	}

	override public function disconnect():void {
		if (!_isConnected)
			return;

		_touch = null;

		_isBegan = false;
		_isMoved = false;
		_isEnded = false;
		_isPressed = false;

		_positionBegan = null;
		_positionMoved = null;
		_positionEnded = null;

		_tapCount = 0;

		Starling.current.stage.removeEventListener(TouchEvent.TOUCH, onTouch);

		super.disconnect();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function getTouch():Touch {
		return _touch;
	}

	public function isBegan():Boolean {
		return _isBegan;
	}

	public function isMoved():Boolean {
		return _isMoved;
	}

	public function isEnded():Boolean {
		return _isEnded;
	}

	public function isPressed():Boolean {
		return _isPressed;
	}

	public function getPositionBegan():Point {
		return _positionBegan;
	}

	public function getPositionMoved():Point {
		return _positionMoved;
	}

	public function getPositionEnded():Point {
		return _positionEnded;
	}

	public function getTapCount():int {
		return _tapCount;
	}

	//--------------------------------------------------------------------------
	//   METHODS - protected
	//--------------------------------------------------------------------------

	protected function onTouch(e:TouchEvent):void {
		_touch = e.getTouch(Starling.current.stage)
		if (_touch) {
			switch (_touch.phase) {
				case (TouchPhase.BEGAN):
					phaseBegan();
					break;
				case (TouchPhase.MOVED):
					phaseMoved();
					break;
				case (TouchPhase.ENDED):
					phaseEnded();
					break;
			}
		}
	}

	protected function phaseBegan():void {
		_isBegan = true;
		_isPressed = true;
		_positionBegan.setTo(_touch.globalX, _touch.globalY);
		_positionMoved.setTo(_touch.globalX, _touch.globalY);
	}

	protected function phaseMoved():void {
		_isMoved = true;
		_positionMoved.setTo(_touch.globalX, _touch.globalY);
	}

	protected function phaseEnded():void {
		_isEnded = true;
		_isPressed = false;
		_positionEnded.setTo(_touch.globalX, _touch.globalY);
		_positionMoved.setTo(_touch.globalX, _touch.globalY);
		_tapCount = _touch.tapCount;
	}

	//--------------------------------------------------------------------------
	//   METHODS - internal
	//--------------------------------------------------------------------------

	override internal function clear():void {
		super.clear();

		_isBegan = false;
		_isMoved = false;
		_isEnded = false;

		_tapCount = 0;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
