package pl.onthemoon.starEngine.layer {

import starling.display.Quad;
import starling.display.Sprite;

public class Layer extends Sprite {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _scale:Number;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function Layer(name:String, scale:Number, visible:Boolean = true) {
		super();

//		var quad:Quad = new Quad(100, 100, 0x0000ff);
//		quad.alpha = 0.2;
//		addChild(quad);

		this.name = name;
		_scale = scale;
		this.visible = visible;

		scaleX = _scale;
		scaleY = _scale;
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get scale():Number {
		return _scale;
	}

	public function get xScaled():Number {
		return x / _scale;
	}

	public function set xScaled(value:Number):void {
		x = value * _scale;
	}

	public function get yScaled():Number {
		return y / _scale;
	}

	public function set yScaled(value:Number):void {
		y = value * _scale;
	}

    //--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
