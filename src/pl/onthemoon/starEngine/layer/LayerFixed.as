/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 24.10.14
 * Time: 23:05
 */
package pl.onthemoon.starEngine.layer {

import pl.onthemoon.starEngine.layer.Layer;

public class LayerFixed extends Layer {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function LayerFixed(name:String, scale:Number = 1, visible:Boolean = true) {
		super(name, scale, visible);
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	override public function set xScaled(value:Number):void {

	}

	override public function set yScaled(value:Number):void {

	}

	override public function set scaleX(value:Number):void {

	}

	override public function set scaleY(value:Number):void {

	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
