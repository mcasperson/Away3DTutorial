package com.makemultimedia.away3d.Manager 
{
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class GameManager 
	{
		
		private var engineManager:EngineManager;
		private var collisionManager:CollisionManager;
		
		public function GameManager(engineManager:EngineManager, collisionManager:CollisionManager) 
		{
			this.engineManager = engineManager;
			this.collisionManager = collisionManager;
		}
		
		public function startLevel():void {
			var levelManager:LevelManager = new LevelManager(engineManager, collisionManager, this);
			levelManager.startLevel1();
		}		
	}

}