package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	import com.makemultimedia.away3d.Interface.Collider;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class CollisionGameElement extends GameElement implements Collider
	{
		private var collisionManager:CollisionManager;
		private var boundingSphere:BoundingSphere;
		private var myCollisionType:int;
		protected var radius:Number;
		protected var removeInNextUpdate:Boolean;
		
		protected function get MyCollisionManager():CollisionManager {
			return this.collisionManager;
		}
		
		protected function get MyBoundingSphere():BoundingSphere {
			return this.boundingSphere;
		}
		
		public function CollisionGameElement(engineManager:EngineManager, levelManager:LevelManager, collisionManager:CollisionManager, myCollisionType:int) 
		{
			super(engineManager, levelManager);
			this.collisionManager = collisionManager;
			this.myCollisionType = myCollisionType;
			this.boundingSphere = new BoundingSphere();
			this.removeInNextUpdate = false;
			
			collisionManager.addCollider(this);
		}
		
		public override function destroy():void {
			super.destroy();
			collisionManager.removeCollider(this);
		}
		
		public function get collisionSphere():BoundingSphere {
			return boundingSphere;
		}
		
		public function get collisionType():int {
			return myCollisionType;
		}	
		
	}

}