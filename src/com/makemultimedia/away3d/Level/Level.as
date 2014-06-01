package com.makemultimedia.away3d.Level 
{
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Level implements Destroyable 
	{				
		private var elevations:Vector.<LevelBackgroundElevation> = new Vector.<LevelBackgroundElevation>();
		private var highestElevation:LevelBackgroundElevation;
		private var engineManager:EngineManager;
		
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
		
		public function Level(engineManager:EngineManager, middleBottom:Vector3D, elevationDistance:Number, initialiseElevations:Function) {
			this.engineManager = engineManager;
			
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
			Elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				elevation.destroy();
			});
			Elevations = null;
		}
	}

}