package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	import com.makemultimedia.away3d.Interface.Collider;
	import com.makemultimedia.away3d.Interface.Destroyable;
	import com.makemultimedia.away3d.Manager.CollisionManager;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class GameElement implements Destroyable
	{		
		private var engineManager:EngineManager;		
		private var levelManager:LevelManager;

		protected function get MyEngineManager():EngineManager {
			return this.engineManager;
		}

		protected function get MyLevelManager():LevelManager {
			return this.levelManager;
		}

		public function GameElement(engineManager:EngineManager, levelManager:LevelManager) 
		{
			this.engineManager = engineManager;
			this.levelManager = levelManager;
			
			levelManager.addDestroyable(this);
		}
		
		public function destroy():void {			
			levelManager.removeDestroyable(this);
		}
		
	
	}

}