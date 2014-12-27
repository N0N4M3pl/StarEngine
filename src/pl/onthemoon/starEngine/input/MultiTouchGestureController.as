/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.01.13
 * Time: 21:29
 */
package pl.onthemoon.starEngine.input {

import pl.onthemoon.starEngine.input.gesture.IGestureRecognizer;

import starling.events.Touch;
import starling.events.TouchPhase;

public class MultiTouchGestureController extends MultiTouchController {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _gesture:IGestureRecognizer;

	protected var _timestampBegan:Vector.<Number>;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function MultiTouchGestureController(gesture:IGestureRecognizer) {
		_gesture = gesture;

		_timestampBegan = new Vector.<Number>(2, true);
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	override public function connect():void {
		if (_isConnected)
			return;

		for (var i:int = 0; i < 2; i++) {
			_timestampBegan[i] = 0;
		}

		super.connect();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function getGesture():IGestureRecognizer {
		return _gesture;
	}

	//--------------------------------------------------------------------------
	//   METHODS - protected
	//--------------------------------------------------------------------------

	override protected function phaseBegan(index:int, touch:Touch):void {
		super.phaseBegan(index, touch);
		_timestampBegan[index] = touch.timestamp;
		if (_isPressed[0] && _isPressed[1] && (_gesture.phase == TouchPhase.ENDED || _gesture.phase == "")) {
			_gesture.phase = TouchPhase.BEGAN;
		}
	}

	override protected function phaseMoved(index:int, touch:Touch):void {
		super.phaseMoved(index, touch);
		if (_isMoved[0] && _isMoved[1]) {
			_gesture.phase = TouchPhase.MOVED;
			_gesture.calculateCenterPoint(_positionMoved[0], _positionMoved[1]);
			_gesture.recognizeMove(_positionBegan[0], _positionMoved[0], _positionBegan[1], _positionMoved[1]);
			_gesture.recognizeZoom(_positionBegan[0], _positionMoved[0], _positionBegan[1], _positionMoved[1]);
		}
	}

	override protected function phaseEnded(index:int, touch:Touch):void {
		super.phaseEnded(index, touch);
		if (!_isPressed[0] && !_isPressed[1]) {
			_gesture.phase = TouchPhase.ENDED;
		}
//		if (index == 0) {
//			_gesture.recognizeSwipe(_timestampBegan[0], touch.timestamp, _positionBegan[0], _positionEnded[0]);
//		}
	}

	//--------------------------------------------------------------------------
	//   METHODS - internal
	//--------------------------------------------------------------------------

	override internal function clear():void {
		super.clear();

		_gesture.clear()
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
