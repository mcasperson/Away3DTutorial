package com.makemultimedia.away3d.Level 
{
	import away3d.extrusions.Elevation;
	import com.makemultimedia.away3d.Interface.Destroyable;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelBackgroundElevation implements Destroyable
	{	
		private var elevation:Elevation;
		private var engineManager:EngineManager;
		private var levelManager:LevelManager;
		
		public function get MyElevation():Elevation {
			return elevation;
		}
		
		public function LevelBackgroundElevation(engineManager:EngineManager, levelManager:LevelManager, elevation:Elevation) 
		{
			this.engineManager = engineManager;
			this.levelManager = levelManager;
			this.elevation = elevation;		
			
			levelManager.addDestroyable(this);
			
			engineManager.View.scene.addChild(elevation);		
		}
		
		public function destroy():void
		{
			levelManager.removeDestroyable(this);
			engineManager.View.scene.removeChild(elevation);
		}
		
	}

}