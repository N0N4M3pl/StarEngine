/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 05.03.14
 * Time: 15:57
 */
package pl.onthemoon.starEngine.display {

import starling.display.Quad;
import starling.utils.VertexData;

public class QuadExt extends Quad {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function QuadExt(width:Number, height:Number, color:uint = 16777215, premultipliedAlpha:Boolean = true) {
		super(width, height, color, premultipliedAlpha);
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	public function get vertexData():VertexData {
		return mVertexData;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
}
}
