package com.makemultimedia.away3d 
{
	import away3d.extrusions.Elevation;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelBackgroundElevation 
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
		
		private function destroy():void
		{
			engineManager.View.scene.removeChild(elevation);
		}
		
	}

}