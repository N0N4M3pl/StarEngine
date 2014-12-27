package pl.onthemoon.starEngine.camera {

import flash.geom.Rectangle;
import flash.utils.Dictionary;

import pl.onthemoon.starEngine.StarEngine;
import pl.onthemoon.starEngine.layer.Layer;

import starling.animation.Transitions;
import starling.animation.Tween;

public class Camera {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

//	public static const TRANSITION_SHAKE:String = "shake";
//	private static const _TRANSITION_FACTOR_6:Number = Math.PI * 6;

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	protected var _engine:StarEngine;
	protected var _layers:Dictionary;

	protected var _frameWidth:int;
	protected var _frameHeight:int;
	protected var _frameWidthHalf:int;
	protected var _frameHeightHalf:int;
	protected var _border:Rectangle;
	protected var _borderRightNoFrame:int;
	protected var _borderBottomNoFrame:int;
	protected var _centeredX:int;
	protected var _centeredY:int;

	protected var _zoom:Number;
	protected var _zoomFrameWidth:int;
	protected var _zoomFrameHeight:int;
	protected var _zoomFrameWidthHalf:int;
	protected var _zoomFrameHeightHalf:int;
	protected var _zoomBorderRightNoFrame:int;
	protected var _zoomBorderBottomNoFrame:int;

	public var _posX:int;
	public var _posY:int;

	protected var _fixedX:int;
	protected var _fixedY:int;

	protected var _tweenPos:Tween;
	protected var _tweenMod:Tween;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function Camera() {
		_border = new Rectangle();
		_centeredX = -1;
		_centeredY = -1;

		_posX = 0;
		_posY = 0;
		_zoom = 1;

		_tweenPos = new Tween(this, 1);
		_tweenMod = new Tween(this, 1);

//		Transitions.register(TRANSITION_SHAKE, transitionShake);
	}

	//--------------------------------------------------------------------------
	//   METHODS - private static
	//--------------------------------------------------------------------------

	/*private static function transitionShake(ratio:Number):Number {
		return Math.sin(ratio * _TRANSITION_FACTOR_6) * (1 - (ratio * ratio));
	}*/

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get border():Rectangle {
		return _border;
	}

	public function get zoom():Number {
		return _zoom;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function initialize(engine:StarEngine):void {
		_engine = engine;
		_layers = _engine.layerGetAll();
	}

	public function destroy():void {
		_engine = null;
		_layers = null;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function setupFrame(width:int, height:int):void {
		_frameWidth = width;
		_frameHeight = height;

		_frameWidthHalf = width >> 1;
		_frameHeightHalf = height >> 1;

		calculateHelpValues();
	}

	public function setupBorder(left:int, top:int, right:int, bottom:int):void {
		_border.left = left;
		_border.top = top;
		_border.right = right;
		_border.bottom = bottom;

		calculateHelpValues();
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function setPosition(x:int, y:int):void {
		_posX = x;
		_posY = y;
		fixPosition();
	}

	public function setPositionSmooth(x:int, y:int, time:Number = 1):void {
		_engine.juggler.remove(_tweenPos);
		_tweenPos.reset(this, time, Transitions.EASE_OUT);
		_tweenPos.animate("_posX", x);
		_tweenPos.animate("_posY", y);
		_tweenPos.onUpdate = fixPosition;
		_engine.juggler.add(_tweenPos);
	}

	//--------------------------------------------------------------------------

	public function setZoom(value:Number = 1):void {
		_zoom = value;

		_engine.scaleX = _zoom;
		_engine.scaleY = _zoom;

		calculateHelpValues();

		fixPosition();
	}

    public function calculateZoomShowAll():Number {
        var factorWidth:Number = _frameWidth / _border.width;
        var factorHeight:Number = _frameHeight / _border.height;

        if (factorWidth < 1 || factorHeight < 1) {
	       return Math.min(factorWidth, factorHeight);
        }

	    return 1;
    }

	//--------------------------------------------------------------------------

	/*public function shake(forceX:Number, forceY:Number, time:Number = 0.6):void {
		xMod = 0;
		yMod = 0;
		_engine.juggler.remove(_tweenMod);
		_tweenMod.reset(this, time, transitionShake);
		if (forceX != 0) {
			_tweenMod.animate("xMod", forceX);
		}
		if (forceY != 0) {
			_tweenMod.animate("yMod", forceY);
		}
		_tweenMod.onUpdate = updatePosition;
		_engine.juggler.add(_tweenMod);
	}*/

	//--------------------------------------------------------------------------
	//   METHODS - protected
	//--------------------------------------------------------------------------

	protected function calculateHelpValues():void {
		_zoomFrameWidth = _frameWidth / _zoom;
		_zoomFrameHeight = _frameHeight / _zoom;

		_zoomFrameWidthHalf = _zoomFrameWidth >> 1;
		_zoomFrameHeightHalf = _zoomFrameHeight >> 1;

		_borderRightNoFrame = _border.right - _frameWidth;
		_borderBottomNoFrame = _border.bottom - _frameHeight;

		_zoomBorderRightNoFrame = _border.right - _zoomFrameWidth;
		_zoomBorderBottomNoFrame = _border.bottom - _zoomFrameHeight;

		_centeredX = (_zoomFrameWidth - _border.width) * 0.5;
		_centeredY = (_zoomFrameHeight - _border.height) * 0.5;
	}

	protected function fixPosition():void {
		if (_centeredX >= 0) {
			_fixedX = _centeredX - _border.left;
		} else {
			_fixedX = _posX - _zoomFrameWidthHalf;
			if (_fixedX < _border.left) {
				_fixedX = _border.left;
			} else if (_fixedX > _zoomBorderRightNoFrame) {
				_fixedX = _zoomBorderRightNoFrame;
			}
			_fixedX = -_fixedX;
		}

		if (_centeredY >= 0) {
			_fixedY = _centeredY - _border.top;
		} else {
			_fixedY = _posY - _zoomFrameHeightHalf;
			if (_fixedY < _border.top) {
				_fixedY = _border.top;
			} else if (_fixedY > _zoomBorderBottomNoFrame) {
				_fixedY = _zoomBorderBottomNoFrame;
			}
			_fixedY = -_fixedY;
		}

		updatePosition();
	}

	protected function updatePosition():void {
		var layer:Layer;
		for each (layer in _layers) {
			layer.xScaled = _fixedX;
			layer.yScaled = _fixedY;
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
