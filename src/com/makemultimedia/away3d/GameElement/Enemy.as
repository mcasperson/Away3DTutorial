package com.makemultimedia.away3d.GameElement 
{
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.CollisionTypes;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Enemy implements Destroyable, Collider
	{
		private var engineManager:EngineManager;
		private var collisionManager:CollisionManager;
		private var model:Loader3D;
		private var boundingSphere:BoundingSphere;
		
		public function Enemy(engineManager:EngineManager, collisionManager:CollisionManager, model:Loader3D) {
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
			this.model = model;
			collisionManager.addCollider(this);
		}
		
		public function destory() {
			engineManager.View.scene.removeChild(model);
			collisionManager.removeCollider(this);
		}
		
		public function get collisionType():int {
			return CollisionTypes.ENEMY_COLLISION_TYPE;
		}
		
		public function get collisionSphere():BoundingSphere {
			boundingSphere.fromSphere(model.position, Math.max(model.maxX - model.minX, model.maxY - model.minY, model.maxZ - model.minZ));
			return boundingSphere;
		}
		
		public function collision(other:Collider) {
			
		}
		
	}

}