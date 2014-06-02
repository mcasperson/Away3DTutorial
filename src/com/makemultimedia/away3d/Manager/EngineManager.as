package com.makemultimedia.away3d.Manager 
{
	import away3d.containers.View3D;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class EngineManager extends Sprite 
	{
		private var view:View3D;
		private var gameManager:GameManager;
		private var collisionManager:CollisionManager;
		
		public function get View():View3D {
			return view;
		}
		
		public function EngineManager() 
		{	
			stage.frameRate = 60;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			view = new View3D();
			addChild(this.view);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
			
			collisionManager = new CollisionManager(this);
			collisionManager.mapCollision(CollisionTypes.ENEMY_COLLISION_TYPE, CollisionTypes.PLAYER_COLLISION_TYPE);
			
			gameManager = new GameManager(this, collisionManager);
			gameManager.startLevel();
		}	
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			NativeApplication.nativeApplication.exit();
		}
		
		private function onEnterFrame(event:Event):void
		{
			view.render();
		}
		
		private function onResize(event:Event = null):void
		{
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
		}

	}
}