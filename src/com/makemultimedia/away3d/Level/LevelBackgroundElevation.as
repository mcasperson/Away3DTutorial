package com.makemultimedia.away3d.Level 
{
	import away3d.extrusions.Elevation;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.EngineManager;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelBackgroundElevation implements Destroyable
	{	
		private var elevation:Elevation;
		private var engineManager:EngineManager;
		
		public function get MyElevation():Elevation {
			return elevation;
		}
		
		public function LevelBackgroundElevation(engineManager:EngineManager, elevation:Elevation) 
		{
			this.engineManager = engineManager;
			this.elevation = elevation;			
			engineManager.View.scene.addChild(elevation);		
		}
		
		public function destroy():void
		{
			engineManager.View.scene.removeChild(elevation);
		}
		
	}

}