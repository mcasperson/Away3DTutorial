package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
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
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Enemy extends CollisionGameElement
	{
		private static const MOVE_SPEED:Number = 2;
		private static const X_AXIS_VARIATION:Number = 200;
		private var model:Loader3D;
		private var topOfScene:Vector3D;
		
		public function Enemy(engineManager:EngineManager, collisionManager:CollisionManager, levelManager:LevelManager, topOfScene:Vector3D) {
			super(engineManager, levelManager, collisionManager, CollisionTypes.ENEMY_COLLISION_TYPE);	
			this.topOfScene = topOfScene;
			model = ResourceManager.loadShuttle01(onMeshLoad);	
		}
		
		private function onMeshLoad(event:AssetEvent):void {
			//Bounds.getMeshBounds(Mesh(model.getChildAt(0)));
			Bounds.getMeshBounds(Mesh(event.asset));
			radius = (Bounds.width / 2 + Bounds.height / 2) / 2;
			
			model.y = topOfScene.y + Bounds.height;
			model.x += (Math.random() * 2 - 1) * X_AXIS_VARIATION;
			MyEngineManager.View.scene.addChild(model);
			
			MyBoundingSphere.fromSphere(model.position, radius);
			
			MyCollisionManager.addCollider(this);
			MyCollisionManager.addEventListener(CollisionEvent.COLLISION_EVENT, onCollision);				
			MyEngineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);	
		}
		
		private function onEnterFrame(event:Event):void {
			if (removeInNextUpdate) {
				destroy();
			} else {			
				model.y -= MOVE_SPEED;	
				MyBoundingSphere.fromSphere(model.position, radius);	
			}
		}
		
		public override function destroy():void {
			super.destroy();
			MyEngineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			MyCollisionManager.removeEventListener(CollisionEvent.COLLISION_EVENT, onCollision);
			MyEngineManager.View.scene.removeChild(model);			
		}
		
		public function onCollision(event:CollisionEvent):void {
			if (!removeInNextUpdate && event.involves(this)) {
				removeInNextUpdate = true;
				new Explosion(MyEngineManager, MyLevelManager, model.position);
			}
		}		
	}

}