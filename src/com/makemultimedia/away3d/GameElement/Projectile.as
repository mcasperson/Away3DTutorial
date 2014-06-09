package com.makemultimedia.away3d.GameElement 
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.SphereGeometry;
	import com.makemultimedia.away3d.Event.CollisionEvent;
	import com.makemultimedia.away3d.Interface.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.CollisionTypes;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Projectile extends CollisionGameElement
	{	
		private static const MOVE_SPEED:Number = 20;
		private static const COLOUR:int = 0xff8844;
		private static const SIZE:int = 10;
		private var model:Mesh;
		
		public function Projectile(engineManager:EngineManager, levelManager:LevelManager, collisionManager:CollisionManager, position:Vector3D) 
		{
			super(engineManager, levelManager, collisionManager, CollisionTypes.PLAYER_PROJECTILE_COLLISION_TYPE);
			this.radius = SIZE;
			
			MyEngineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);	
			
			MyCollisionManager.addCollider(this);
			MyCollisionManager.addEventListener(CollisionEvent.COLLISION_EVENT, onCollision);
			MyBoundingSphere.fromSphere(position, radius);
			
			var material:ColorMaterial = new ColorMaterial(COLOUR);
			model = new Mesh(new SphereGeometry(radius), material);
			model.position = position;
			MyEngineManager.View.scene.addChild(model);
		}
		
		public override function destroy():void {
			super.destroy();
			MyEngineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);	
			MyCollisionManager.removeEventListener(CollisionEvent.COLLISION_EVENT, onCollision);
			MyEngineManager.View.scene.removeChild(model);			
		}
		
		private function onEnterFrame(event:Event):void {
			if (removeInNextUpdate) {
				destroy();
			} else {			
				model.y += MOVE_SPEED;	
				MyBoundingSphere.fromSphere(model.position, radius);	
			}
		}
		
		public function onCollision(event:CollisionEvent):void {
			if (event.involves(this)) {
				removeInNextUpdate = true;
			}
		}
	}

}