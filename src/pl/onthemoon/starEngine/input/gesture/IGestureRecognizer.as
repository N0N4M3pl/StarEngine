/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 08.09.14
 * Time: 11:34
 */
package pl.onthemoon.starEngine.input.gesture {

import flash.geom.Point;

public interface IGestureRecognizer {

	function get phase():String;

	function set phase(value:String):void;

	function get centerPoint():Point;

	function calculateCenterPoint(toA:Point, toB:Point):void;

	function get moveIsRecognized():Boolean;

	function recognizeMove(fromA:Point, toA:Point, fromB:Point, toB:Point):void;

	function get zoomIsRecognized():Boolean;

	function recognizeZoom(fromA:Point, toA:Point, fromB:Point, toB:Point):void;

	function get swipeIsRecognized():Boolean;

	function recognizeSwipe(timesFromA:Number, timeToA:Number, fromA:Point, toA:Point):void;

	function clear():void;
}
}
