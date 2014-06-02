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
	import com.makemultimedia.away3d.Destroyable;
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
	public class Player implements Destroyable, Collider
	{
		private static const MOVEMENT_SPEED:Number = 3;
		private var engineManager:EngineManager;
		private var collisionManager:CollisionManager;
		private var levelManager:LevelManager;
		private var model:Loader3D;
		private var boundingSphere:BoundingSphere;
		private var radius:Number;
		
		public function Player(engineManager:EngineManager, levelManager:LevelManager, collisionManager:CollisionManager) 
		{
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
			this.levelManager = levelManager;
			this.boundingSphere = new BoundingSphere();
			
			collisionManager.addCollider(this);
			levelManager.addDestroyable(this);
			
			model = ResourceManager.loadSpaceFighter01(function(event:AssetEvent):void {
				Bounds.getMeshBounds(Mesh(model.getChildAt(0)));
				radius = (Bounds.width / 2 + Bounds.height / 2) / 2;
			});	
			engineManager.View.scene.addChild(model);
							
			engineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			engineManager.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			engineManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			engineManager.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);		
		}
		
		private function onEnterFrame(event:Event):void {
			boundingSphere.fromSphere(model.position, radius);
		}
		
		public function destroy():void {
			engineManager.View.scene.removeChild(model);
			collisionManager.removeCollider(this);
			levelManager.removeDestroyable(this);
			
			engineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			engineManager.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			engineManager.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			engineManager.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
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
		
		public function get collisionType():int {
			return CollisionTypes.PLAYER_COLLISION_TYPE;
		}
		
		public function get collisionSphere():BoundingSphere {					
			return boundingSphere;
		}
		
		public function collision(otherCollider:Collider):void {
			
		}
	}

}