/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 02.09.14
 * Time: 14:17
 */
package pl.onthemoon.starEngine.input.gesture {

import flash.geom.Point;

import pl.onthemoon.starEngine.utils.StarUtils;

import starling.events.TouchPhase;

public class GestureRecognizer implements IGestureRecognizer {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	private var _phase:String;

	private var _centerPoint:Point;

	private var _moveIsRecognized:Boolean;
	public var moveCfgMaxAngleDiff:Number = 20 * StarUtils.DEG2RAD; // 20 stopni
	public var moveDistance:Number;

	private var _zoomIsRecognized:Boolean;
	public var zoomScale:Number;

	private var _swipeIsRecognized:Boolean;
	public var swipeCfgMaxDuration:Number = 1.5;
	public var swipeCfgMinDistance:Number = 300;
	public var swipeDuration:Number;
	public var swipeDistance:Number;
	public var swipeAngle:Number;

	private var _angleA:Number;
	private var _angleB:Number;
	private var _angleABDiff:Number;
	private var _distanceAA:Number;
	private var _distanceBB:Number;
	private var _distanceABF:Number;
	private var _distanceABT:Number;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function GestureRecognizer() {
		_phase = TouchPhase.ENDED;
		_centerPoint = new Point();
		_swipeIsRecognized = false;
		_moveIsRecognized = false;
		_zoomIsRecognized = false;

		clear();
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get phase():String {
		return _phase;
	}

	public function set phase(value:String):void {
		_phase = value;
	}

	public function get centerPoint():Point {
		return _centerPoint;
	}

	public function get moveIsRecognized():Boolean {
		return _moveIsRecognized;
	}

	public function get zoomIsRecognized():Boolean {
		return _zoomIsRecognized;
	}

	public function get swipeIsRecognized():Boolean {
		return _swipeIsRecognized;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function calculateCenterPoint(toA:Point, toB:Point):void {
		_centerPoint.x = (toA.x + toB.x) * 0.5;
		_centerPoint.y = (toA.y + toB.y) * 0.5;
	}

	public function recognizeMove(fromA:Point, toA:Point, fromB:Point, toB:Point):void {
		setAngleA(fromA, toA);
		setAngleB(fromB, toB);
		setAngleABDiff();
		if (StarUtils.abs(_angleABDiff) < moveCfgMaxAngleDiff) {
			setDistanceAA(fromA, toA);

			if (_distanceAA != moveDistance) {
				moveDistance = _distanceAA;
				_moveIsRecognized = true;
			}
		}
	}

	public function recognizeZoom(fromA:Point, toA:Point, fromB:Point, toB:Point):void {
		setDistanceABF(fromA, fromB);
		setDistanceABT(toA, toB);
        var scale:Number = _distanceABT / _distanceABF;
        if (scale != zoomScale) {
            zoomScale = scale;
            _zoomIsRecognized = true;
        }
	}

	public function recognizeSwipe(fromTimeA:Number, toTimeA:Number, fromA:Point, toA:Point):void {
		var duration:Number = toTimeA - fromTimeA;
		if (duration < swipeCfgMaxDuration) {
			setDistanceAA(fromA, toA);
			if (_distanceAA > swipeCfgMinDistance) {
				setAngleA(fromA, toA);

				swipeDuration = duration;
				swipeDistance = _distanceAA;
				swipeAngle = _angleA;
				_swipeIsRecognized = true;
			}
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function clear():void {
		_phase = "";
		_swipeIsRecognized = false;
		_moveIsRecognized = false;
		_zoomIsRecognized = false;

		_angleA = Number.NaN;
		_angleB = Number.NaN;
		_angleABDiff = Number.NaN;
		_distanceAA = Number.NaN;
		_distanceBB = Number.NaN;
		_distanceABF = Number.NaN;
		_distanceABT = Number.NaN;
	}

	//--------------------------------------------------------------------------
	//   METHODS - private
	//--------------------------------------------------------------------------

	private function setAngleA(fromA:Point, toA:Point):void {
		if (StarUtils.isNaN(_angleA)) {
			_angleA = StarUtils.radianAngle(fromA.x, fromA.y, toA.x, toA.y);
		}
	}

	private function setAngleB(fromB:Point, toB:Point):void {
		if (StarUtils.isNaN(_angleB)) {
			_angleB = StarUtils.radianAngle(fromB.x, fromB.y, toB.x, toB.y);
		}
	}

	private function setAngleABDiff():void {
		if (StarUtils.isNaN(_angleABDiff)) {
			_angleABDiff = StarUtils.radianAngleDiff(_angleA, _angleB);
		}
	}

	private function setDistanceAA(fromA:Point, toA:Point):void {
		if (StarUtils.isNaN(_distanceAA)) {
			_distanceAA = StarUtils.distance(fromA.x, fromA.y, toA.x, toA.y);
		}
	}

	private function setDistanceBB(fromB:Point, toB:Point):void {
		if (StarUtils.isNaN(_distanceBB)) {
			_distanceBB = StarUtils.distance(fromB.x, fromB.y, toB.x, toB.y);
		}
	}

	private function setDistanceABF(fromA:Point, fromB:Point):void {
		if (StarUtils.isNaN(_distanceABF)) {
			_distanceABF = StarUtils.distance(fromA.x, fromA.y, fromB.x, fromB.y);
		}
	}

	private function setDistanceABT(toA:Point, toB:Point):void {
		if (StarUtils.isNaN(_distanceABT)) {
			_distanceABT = StarUtils.distance(toA.x, toA.y, toB.x, toB.y);
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
