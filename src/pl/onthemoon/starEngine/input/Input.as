/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.01.13
 * Time: 08:04
 */
package pl.onthemoon.starEngine.input {

import starling.animation.IAnimatable;

public class Input implements IAnimatable {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	private var _isEnabled:Boolean = false;

	private var _controllers:Vector.<Controller>;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function Input() {
		_controllers = new Vector.<Controller>();
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get isEnabled():Boolean {
		return _isEnabled;
	}

	public function set isEnabled(value:Boolean):void {
		_isEnabled = value;

		if (value) {
			var i:int;
			var n:int = _controllers.length;
			for (i = 0; i < n; i++) {
				_controllers[i].clear();
			}
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	/**
	 * @private
	 */
	public function advanceTime(time:Number):void {
		if (!_isEnabled)
			return;

		var i:int;
		var n:int = _controllers.length;
		for (i = 0; i < n; i++) {
			_controllers[i].clear();
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	/**
	 * Add controller
	 * @param controller
	 * @return channel
	 */
	public function addController(controller:Controller):int {
		_controllers.push(controller);
		return _controllers.length - 1;
	}

	/**
	 * Remove controller by controller
	 * @param controller
	 */
	public function removeController(controller:Controller):void {
		var index:int = _controllers.indexOf(controller);
		if (index == -1) {
			return;
		}
		_controllers.splice(index, 1);
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	/*public function isPressed(channel:int = 0, actionId:* = null):Boolean {
		if (!_isEnabled)
			return false;

		return _controllers[channel].isPressed(actionId);
	}

	public function isPushed(channel:int = 0, actionId:* = null):Boolean {
		if (!_isEnabled)
			return false;

		return _controllers[channel].isPushed(actionId);
	}

	public function isMoved(channel:int = 0, actionId:* = null):Boolean {
		if (!_isEnabled)
			return false;

		return _controllers[channel].isMoved(actionId);
	}

	public function isReleased(channel:int = 0, actionId:* = null):Boolean {
		if (!_isEnabled)
			return false;

		return _controllers[channel].isReleased(actionId);
	}

	public function data(channel:int = 0, actionId:* = null):Object {
		if (!_isEnabled)
			return null;

		return _controllers[channel].data(actionId);
	}*/

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
