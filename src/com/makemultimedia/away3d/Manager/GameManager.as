package com.makemultimedia.away3d.Manager 
{
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class GameManager 
	{
		
		private var engineManager:EngineManager;
		
		public function GameManager(engineManager:EngineManager) 
		{
			this.engineManager = engineManager;
		}
		
		public function startLevel():void {
			var levelManager:LevelManager = new LevelManager(engineManager, this);
			levelManager.startLevel1();
		}		
	}

}