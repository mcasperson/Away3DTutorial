package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	import away3d.core.math.Vector3DUtils;
	import away3d.loaders.Loader3D;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.CollisionTypes;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.ResourceManager;
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
		private var model:Loader3D;
		private var boundingSphere:BoundingSphere;
		
		public function Player(engineManager:EngineManager, collisionManager:CollisionManager) 
		{
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
			
			collisionManager.addCollider(this);
			
			model = ResourceManager.loadSpaceFighter01();	
			engineManager.View.scene.addChild(model);
			
			this.boundingSphere = new BoundingSphere();
			
			engineManager.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			engineManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			engineManager.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function destroy():void {
			engineManager.View.scene.removeChild(model);
			collisionManager.removeCollider(this);
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
			boundingSphere.fromSphere(model.position, Math.max(model.maxX - model.minX, model.maxY - model.minY, model.maxZ - model.minZ));
			return boundingSphere;
		}
		
		public function collision(otherCollider:Collider):void {
			
		}
	}

}