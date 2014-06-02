package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	import away3d.entities.Mesh;
	import away3d.loaders.Loader3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.tools.utils.Bounds;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.CollisionTypes;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.EnemyManager;
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
		private var enemyManager:EnemyManager;
		private var model:Loader3D;
		private var boundingSphere:BoundingSphere;
		private var removeInNextUpdate:Boolean;		
		
		public function Enemy(engineManager:EngineManager, collisionManager:CollisionManager, enemyManager:EnemyManager, model:Loader3D, topOfScene:Vector3D) {
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
			this.enemyManager = enemyManager;
			this.model = model;
			this.boundingSphere = new BoundingSphere();
			this.removeInNextUpdate = false;			
			
			collisionManager.addCollider(this);
			enemyManager.addEnemy(this);
			
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
				if (model.numChildren !== 0) {
					Bounds.getMeshBounds(Mesh(model.getChildAt(0)));
					boundingSphere.fromSphere(model.position, (Bounds.width / 2 + Bounds.height / 2) / 2);
				}		
			}
		}
		
		public function destroy():void {
			engineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			engineManager.View.scene.removeChild(model);			
			collisionManager.removeCollider(this);
			enemyManager.removeEnemy(this);
		}
		
		public function get collisionType():int {
			return CollisionTypes.ENEMY_COLLISION_TYPE;
		}
		
		public function get collisionSphere():BoundingSphere {
			return boundingSphere;
		}
		
		public function collision(other:Collider):void {
			removeInNextUpdate = true;
		}
		
	}

}