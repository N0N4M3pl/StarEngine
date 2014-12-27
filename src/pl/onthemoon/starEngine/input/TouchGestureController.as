/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.01.13
 * Time: 21:29
 */
package pl.onthemoon.starEngine.input {

import pl.onthemoon.starEngine.input.gesture.IGestureRecognizer;

public class TouchGestureController extends TouchController {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _gesture:IGestureRecognizer;

	protected var _timestampBegan:Number;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function TouchGestureController(gesture:IGestureRecognizer) {
		_gesture = gesture;
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	override public function connect():void {
		if (_isConnected)
			return;

		_timestampBegan = 0;

		super.connect();
	}

	override public function disconnect():void {
		if (!_isConnected)
			return;

		_timestampBegan = 0;

		super.disconnect();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function getGesture():IGestureRecognizer {
		return _gesture;
	}

	//--------------------------------------------------------------------------
	//   METHODS - protected
	//--------------------------------------------------------------------------

	override protected function phaseBegan():void {
		super.phaseBegan();
		_timestampBegan = _touch.timestamp;
	}

	//	override protected function phaseMoved():void {
	//		super.phaseMoved();
	//	}

	override protected function phaseEnded():void {
		super.phaseEnded();
		_gesture.recognizeSwipe(_timestampBegan, _touch.timestamp, _positionBegan, _positionEnded);
	}

	//--------------------------------------------------------------------------
	//   METHODS - internal
	//--------------------------------------------------------------------------

	override internal function clear():void {
		super.clear();

		_gesture.clear();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
