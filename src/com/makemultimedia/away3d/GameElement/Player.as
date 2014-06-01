package com.makemultimedia.away3d.GameElement 
{
	import away3d.core.math.Vector3DUtils;
	import away3d.loaders.Loader3D;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.ResourceManager;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Player 
	{
		private static const MOVEMENT_SPEED:Number = 3;
		private var engineManager:EngineManager;
		private var model:Loader3D;
		
		public function Player(engineManager:EngineManager) 
		{
			this.engineManager = engineManager;
			
			model = ResourceManager.LoadSpaceFighter01();	
			engineManager.View.scene.addChild(model);
			
			engineManager.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			engineManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			engineManager.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function destory():void {
			engineManager.View.scene.removeChild(model);
		}
		
		private function onMouseDown(event:MouseEvent):void { 
			
		}
		
		private function onMouseUp(event:MouseEvent):void { 
			
		}
		
		private function onMouseMove(event:MouseEvent):void { 
			var screenPos:Vector3D = engineManager.View.camera.unproject(
				(event.stageX / engineManager.width) * 2 - 1, 
				(event.stageY / engineManager.height) * 2 - 1, 
				model.z - engineManager.View.camera.z);
			model.position = screenPos;	
		}
	}

}