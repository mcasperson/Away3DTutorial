package com.makemultimedia.away3d.Manager 
{
	import away3d.extrusions.Elevation;
	import away3d.extrusions.SkinExtrude;
	import away3d.loaders.Loader3D;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.GameElement.Player;
	import com.makemultimedia.away3d.Level.Level;
	import com.makemultimedia.away3d.Level.LevelBackgroundElevation;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelManager implements Destroyable
	{	
		private static const ELEVATION_DIST:Number = 200;
		private static const SCROLL_SPEED:Number = 3;
		private var player:Player;
		private var engineManager:EngineManager;
		private var gameManager:GameManager;
		private var level:Level;
		private var middleBottom:Vector3D;			
		
		public function LevelManager(engineManager:EngineManager, gameManager:GameManager) 
		{
			this.gameManager = gameManager;
			this.engineManager = engineManager;
			this.player = new Player(engineManager);	
			this.middleBottom = engineManager.View.camera.unproject(0, 1, ELEVATION_DIST - engineManager.View.camera.z);
			
			engineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);			
		}
		
		private function onEnterFrame(event:Event):void
		{			
			level.Elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				elevation.MyElevation.moveBackward(SCROLL_SPEED);	
			});			
			
			level.Elevations.forEach(function (elevation:LevelBackgroundElevation, index:int, vector:Vector.<LevelBackgroundElevation>):void {
				if (elevation.MyElevation.depth / 2 + elevation.MyElevation.y < middleBottom.y) {
					elevation.MyElevation.y = level.HighestElevation.MyElevation.depth / 2 + level.HighestElevation.MyElevation.y + elevation.MyElevation.depth / 2;
					level.HighestElevation = elevation; 
				}	
			});		
		}
		
		public function destroy():void {
			player.destory();
			player = null;
			level.destroy();
			level = null;
		}
		
		public function startLevel1():void {
			level = new Level(engineManager, middleBottom, ELEVATION_DIST, function(Elevations:Vector.<LevelBackgroundElevation>) {
				Elevations.push(new LevelBackgroundElevation(engineManager, ResourceManager.LoadIsland()));
				Elevations.push(new LevelBackgroundElevation(engineManager, ResourceManager.LoadIsland()));
			});
		}
		
	}

}