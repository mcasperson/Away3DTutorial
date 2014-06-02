package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
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
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Enemy implements Destroyable, Collider
	{
		private static const MOVE_SPEED:Number = 2;
		private static const X_AXIS_VARIATION:Number = 200;
		private var engineManager:EngineManager;
		private var collisionManager:CollisionManager;
		private var levelManager:LevelManager;
		private var model:Loader3D;
		private var boundingSphere:BoundingSphere;
		private var removeInNextUpdate:Boolean;		
		private var radius:Number;
		
		public function Enemy(engineManager:EngineManager, collisionManager:CollisionManager, levelManager:LevelManager, topOfScene:Vector3D) {
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
			this.levelManager = levelManager;
			this.boundingSphere = new BoundingSphere();
			this.removeInNextUpdate = false;
			
			model = ResourceManager.loadShuttle01(function(event:AssetEvent):void {
				//Bounds.getMeshBounds(Mesh(model.getChildAt(0)));
				Bounds.getMeshBounds(Mesh(event.asset));
				radius = (Bounds.width / 2 + Bounds.height / 2) / 2;
			});	
			engineManager.View.scene.addChild(model);
			
			collisionManager.addCollider(this);
			levelManager.addDestroyable(this);
			
			engineManager.View.scene.addChild(model);
			
			engineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);	
			
			model.y = topOfScene.y;
			model.x += (Math.random() * 2 - 1) * X_AXIS_VARIATION;;
		}
		
		private function onEnterFrame(event:Event):void {
			if (removeInNextUpdate) {
				destroy();
			} else {			
				model.y -= MOVE_SPEED;	
				boundingSphere.fromSphere(model.position, radius);	
			}
		}
		
		public function destroy():void {
			engineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			engineManager.View.scene.removeChild(model);			
			collisionManager.removeCollider(this);
			levelManager.removeDestroyable(this);
		}
		
		public function get collisionType():int {
			return CollisionTypes.ENEMY_COLLISION_TYPE;
		}
		
		public function get collisionSphere():BoundingSphere {
			return boundingSphere;
		}
		
		public function collision(other:Collider):void {
			removeInNextUpdate = true;
			new Explosion(engineManager, levelManager, model.position);
		}
		
	}

}