/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 14.01.13
 * Time: 21:45
 */

package pl.onthemoon.starEngine.entity {

import starling.animation.IAnimatable;
import starling.display.DisplayObject;

public class Entity implements IAnimatable {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _g:DisplayObject;

	public var layer:String = "_";

	private var _isAnimatable:Boolean = false

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function Entity(graphics:DisplayObject = null, layer:String = "_", isAnimatable:Boolean = false) {
		_g = graphics;
		this.layer = layer;
		_isAnimatable = isAnimatable
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get x():Number {
		return (_g) ? _g.x : NaN;
	}

	public function set x(value:Number):void {
		if (_g) _g.x = value;
	}

	public function get y():Number {
		return (_g) ? _g.y : NaN;
	}

	public function set y(value:Number):void {
		if (_g) _g.y = value;
	}

	public function get g():DisplayObject {
		return _g;
	}

	public function get isAnimatable():Boolean {
		return _isAnimatable;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function initialize():void {

	}

	public function destroy():void {

	}

	public function advanceTime(time:Number):void {
		// TODO check if is visible / on camera / ...
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
