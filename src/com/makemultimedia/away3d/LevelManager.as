package com.makemultimedia.away3d 
{
	import away3d.extrusions.Elevation;
	import away3d.extrusions.SkinExtrude;
	import away3d.loaders.Loader3D;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelManager 
	{
		private static const ELEVATION_DIST:Number = 200;
		
		private static const SCROLL_SPEED:Number = 5;
		private var player:Player;
		private var engineManager:EngineManager;
		private var gameManager:GameManager;
		private var middleBottom:Vector3D;
		private var elevations:Vector.<LevelBackgroundElevation>;
		private var highestElevation:LevelBackgroundElevation;
		
		public function LevelManager(engineManager:EngineManager, gameManager:GameManager) 
		{
			this.gameManager = gameManager;
			this.engineManager = engineManager;
			this.player = new Player(engineManager);
			this.middleBottom = engineManager.View.camera.unproject(0, 1, ELEVATION_DIST - engineManager.View.camera.z);	
			this.elevations = new Vector.<LevelBackgroundElevation>();
			
			trace(middleBottom.x);
			trace(middleBottom.y);
			trace(middleBottom.z);
			
			engineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			startLevel1();
		}
		
		private function onEnterFrame(event:Event):void
		{			
			elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				elevation.MyElevation.moveBackward(SCROLL_SPEED);	
			});			
			
			elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				if (elevation.MyElevation.depth / 2 + elevation.MyElevation.y < middleBottom.y) {
					elevation.MyElevation.y = highestElevation.MyElevation.depth / 2 + highestElevation.MyElevation.y + elevation.MyElevation.depth / 2;
					highestElevation = elevation; 
				}	
			});		
		}
		
		public function destroy():void {
			player.destory();			
		}
		
		public function startLevel1():void {
			var elevation1:LevelBackgroundElevation = new LevelBackgroundElevation(engineManager, ResourceManager.LoadIsland());
			var elevation2:LevelBackgroundElevation = new LevelBackgroundElevation(engineManager, ResourceManager.LoadIsland());
			
			elevations.push(elevation1);
			elevations.push(elevation2);
			
			var accumulatedHeight = middleBottom.y;
			
			elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				elevation.MyElevation.y = accumulatedHeight + elevation.MyElevation.depth / 2;
				accumulatedHeight += elevation.MyElevation.depth;
				elevation.MyElevation.z = ELEVATION_DIST;
			});	
			
			highestElevation = elevation2;
		}
		
	}

}