/**
 * User: Mateusz Skafiriak :: mateusz.skafiriak@gmail.com
 * Date: 11.01.13
 * Time: 08:34
 */
package pl.onthemoon.starEngine {

import flash.utils.Dictionary;

import pl.onthemoon.starEngine.camera.Camera;
import pl.onthemoon.starEngine.entity.Entity;
import pl.onthemoon.starEngine.input.Input;
import pl.onthemoon.starEngine.layer.Layer;

import starling.animation.IAnimatable;
import starling.animation.Juggler;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.ResizeEvent;

public class StarEngine extends Sprite implements IAnimatable {

	//--------------------------------------------------------------------------
	//   PROPERTIES
	//--------------------------------------------------------------------------

	protected var _isInitialized:Boolean = false;
	protected var _isRunning:Boolean = false;

	protected var _stageWidth:int;
	protected var _stageHeight:int;
	protected var _stageWidthHalf:int;
	protected var _stageHeightHalf:int;

	protected var _juggler:Juggler;

	protected var _camera:Camera;

	protected var _input:Input;

	protected var _entities:Vector.<Entity>;
	protected var _layers:Dictionary;

	//--------------------------------------------------------------------------
	//   CONSTRUCTOR
	//--------------------------------------------------------------------------

	public function StarEngine() {
		super();

		_juggler = new Juggler();

		_camera = new Camera();

		_input = new Input();

		_entities = new Vector.<Entity>();
		_layers = new Dictionary();
	}

	//--------------------------------------------------------------------------
	//   METHODS - public
	//--------------------------------------------------------------------------

	/*public function get isInitialized():Boolean {
	 return _isInitialized;
	 }*/

	public function get isRunning():Boolean {
		return _isRunning;
	}

	public function set isRunning(value:Boolean):void {
		if (_isInitialized)
			_isRunning = value;
	}

    public function get stageWidth():int {
        return _stageWidth;
    }

    public function get stageHeight():int {
        return _stageHeight;
    }

    public function get stageWidthHalf():int {
        return _stageWidthHalf;
    }

    public function get stageHeightHalf():int {
        return _stageHeightHalf;
    }

	public function get juggler():Juggler {
		return _juggler;
	}

	public function get camera():Camera {
		return _camera;
	}

	public function get input():Input {
		return _input;
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function advanceTime(time:Number):void {
		if (!_isRunning)
			return;

		_juggler.advanceTime(time);
		_input.advanceTime(time);
	}

	//--------------------------------------------------------------------------
	//   METHODS - layer
	//--------------------------------------------------------------------------

	public function layerGetAll():Dictionary {
		return _layers;
	}

	public function layerAdd(layer:Layer, index:int = -1):Layer {
		_layers[layer.name] = layer;
        if (index < 0) {
            addChild(layer);
        } else {
            addChildAt(layer, index);
        }
		return layer;
	}

	public function layerGet(name:String):Layer {
		return _layers[name];
	}

	/*public function layerRemove(name:String):void {
	 var layer:Layer = _layers[name];

	 layer.removeFromParent(true);
	 delete _layers[name];
	 }*/

	//--------------------------------------------------------------------------
	//   METHODS - entity
	//--------------------------------------------------------------------------

	public function entityAdd(entity:Entity):void {
		entity.initialize();
		_entities.push(entity);

		graphicsAdd(entity.g, entity.layer);

		if (entity.isAnimatable) {
			_juggler.add(entity);
		}
	}

	public function entityRemove(entity:Entity, dispose:Boolean = false):void {
		if (entity.isAnimatable) {
			_juggler.remove(entity);
		}

		graphicsRemove(entity.g, dispose);

		_entities.splice(_entities.indexOf(entity), 1);
		entity.destroy();
	}

	/*public function entityRemoveAll():void {
	 var i:int;
	 var n:int = 0;
	 for (i = _entities.length - 1; i >= n; i--) {
	 entityRemove(_entities[i]);
	 }
	 _entities.length = 0;
	 }*/

	//--------------------------------------------------------------------------

	public function entitySetLayer(entity:Entity, layerName:String, samePosition:Boolean = false):void {
		if (entity.layer == layerName)
			return;

		var g:DisplayObject = entity.g;

		var layer:Layer;
		if (samePosition) {
			layer = (_layers[entity.layer] as Layer);
			g.x = (g.x * layer.scale) + layer.x;
			g.y = (g.y * layer.scale) + layer.y;
		}

		graphicsRemove(g, false);
		entity.layer = layerName;
		graphicsAdd(g, layerName);

		if (samePosition) {
			layer = (_layers[layerName] as Layer);
			g.x = (g.x * layer.scale) + layer.x;
			g.y = (g.y * layer.scale) + layer.y;
		}
	}

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

	public function graphicsAdd(graphics:DisplayObject, layer:String):void {
		_layers[layer].addChild(graphics);
	}

	public function graphicsRemove(graphics:DisplayObject, dispose:Boolean = false):void {
		graphics.removeFromParent(dispose);
	}

    //--------------------------------------------------------------------------
    //   METHODS - protected
    //--------------------------------------------------------------------------

    protected function initialize():void {
        _isInitialized = true;
        _isRunning = false;

        _stageWidth = stage.stageWidth;
        _stageHeight = stage.stageHeight;

        _stageWidthHalf = _stageWidth >> 1;
        _stageHeightHalf = _stageHeight >> 1;

        _camera.initialize(this);
	    _camera.setupFrame(_stageWidth, _stageHeight);

        //		_input.isEnabled = true; //TODO why set to true ???

        //TODO move add to juggler to set isRunning ?
        Starling.juggler.add(this);

        //TEST is it working? (and in destroy)
        stage.addEventListener(ResizeEvent.RESIZE, onResize);
    }

    protected function destroy():void {
        Starling.juggler.remove(this);

        _isInitialized = false;
        _isRunning = false;

        _stageWidth = 0;
        _stageHeight = 0;

        _stageWidthHalf = 0;
        _stageHeightHalf = 0;

        _camera.destroy();

        _input.isEnabled = false;

        //		entityRemoveAll();

        Starling.juggler.remove(this);

        stage.removeEventListener(ResizeEvent.RESIZE, onResize);
    }

    //--------------------------------------------------------------------------

    protected function onResize(e:ResizeEvent):void {
        //TEST use e.width, e.height ?

        _stageWidth = stage.stageWidth;
        _stageHeight = stage.stageHeight;

        _stageWidthHalf = _stageWidth >> 1;
        _stageHeightHalf = _stageHeight >> 1;

        _camera.setupFrame(_stageWidth, _stageHeight);
    }

	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------

}
}
