package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	import away3d.core.math.Vector3DUtils;
	import away3d.core.partition.MeshNode;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.loaders.Loader3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.tools.utils.Bounds;
	import com.makemultimedia.away3d.Event.CollisionEvent;
	import com.makemultimedia.away3d.Interface.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.CollisionTypes;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	import com.makemultimedia.away3d.Manager.ResourceManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Player extends CollisionGameElement
	{
		private static const MOVEMENT_SPEED:Number = 3;
		private var model:Loader3D;
		
		public function Player(engineManager:EngineManager, levelManager:LevelManager, collisionManager:CollisionManager) 
		{			
			super(engineManager, levelManager, collisionManager, CollisionTypes.PLAYER_COLLISION_TYPE);
			
			model = ResourceManager.loadSpaceFighter01(function(event:AssetEvent):void {
				Bounds.getMeshBounds(Mesh(model.getChildAt(0)));
				radius = (Bounds.width / 2 + Bounds.height / 2) / 2;
			});	
			MyEngineManager.View.scene.addChild(model);
							
			MyEngineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			MyEngineManager.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			MyEngineManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			MyEngineManager.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);		
		}
		
		private function onEnterFrame(event:Event):void {
			MyBoundingSphere.fromSphere(model.position, radius);
		}
		
		public override function destroy():void {
			super.destroy();
			
			MyEngineManager.View.scene.removeChild(model);			
			
			MyEngineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			MyEngineManager.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			MyEngineManager.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			MyEngineManager.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseDown(event:MouseEvent):void { 
			new Projectile(MyEngineManager, MyLevelManager, MyCollisionManager, model.position);
		}
		
		private function onMouseUp(event:MouseEvent):void { 
			
		}
		
		private function onMouseMove(event:MouseEvent):void { 
			var screenPos:Vector3D = MyEngineManager.View.camera.unproject(
				(event.stageX / MyEngineManager.width) * 2 - 1, 
				(event.stageY / MyEngineManager.height) * 2 - 1, 
				model.z - MyEngineManager.View.camera.z);
			model.position = screenPos;	
		}
	}

}