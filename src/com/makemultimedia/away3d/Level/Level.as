package com.makemultimedia.away3d.Level 
{
	import com.makemultimedia.away3d.Interface.Destroyable;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Level implements Destroyable 
	{				
		private var elevations:Vector.<LevelBackgroundElevation>;
		private var highestElevation:LevelBackgroundElevation;
		private var engineManager:EngineManager;
		private var levelManager:LevelManager;
		
		public function get Elevations():Vector.<LevelBackgroundElevation> {
			return elevations;
		}
		
		public function set Elevations(elevations:Vector.<LevelBackgroundElevation>):void {
			this.elevations = elevations;
		}
		
		public  function get HighestElevation():LevelBackgroundElevation {
			return highestElevation;
		}
		
		public  function set HighestElevation(highestElevation:LevelBackgroundElevation):void {
			this.highestElevation = highestElevation;
		}
		
		public function Level(engineManager:EngineManager, levelManager:LevelManager, middleBottom:Vector3D, elevationDistance:Number, initialiseElevations:Function) {
			this.engineManager = engineManager;
			this.levelManager = levelManager;
			this.elevations = new Vector.<LevelBackgroundElevation>(); 
			
			levelManager.addDestroyable(this);
			
			initialiseElevations(Elevations);
			
			var accumulatedHeight:Number = middleBottom.y;
			
			Elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				elevation.MyElevation.y = accumulatedHeight + elevation.MyElevation.depth / 2;
				accumulatedHeight += elevation.MyElevation.depth;
				elevation.MyElevation.z = elevationDistance;
			});	
			
			HighestElevation = Elevations[elevations.length - 1];
		}
		
		public function destroy():void {
			levelManager.removeDestroyable(this);
			Elevations = null;
		}
	}

}