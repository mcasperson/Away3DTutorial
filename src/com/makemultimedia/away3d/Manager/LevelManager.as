package com.makemultimedia.away3d.Manager 
{
	import away3d.extrusions.Elevation;
	import away3d.extrusions.SkinExtrude;
	import away3d.loaders.Loader3D;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.GameElement.Enemy;
	import com.makemultimedia.away3d.GameElement.Player;
	import com.makemultimedia.away3d.Level.Level;
	import com.makemultimedia.away3d.Level.LevelBackgroundElevation;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import org.as3commons.collections.LinkedList;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class LevelManager implements Destroyable
	{	
		private static const ELEVATION_DIST:Number = 200;
		private static const SCROLL_SPEED:Number = 3;
		private static const ENEMY_CREATE_DELAY:Number = 3000;
		private var player:Player;
		private var engineManager:EngineManager;
		private var collisionManager:CollisionManager;
		private var gameManager:GameManager;
		private var level:Level;
		private var middleBottom:Vector3D;	
		private var middleTop:Vector3D;
		private var timeUntilNextEnemy:int;
		private var destroyableObjects:LinkedList;
		
		public function LevelManager(engineManager:EngineManager, collisionManager:CollisionManager, gameManager:GameManager) 
		{
			this.gameManager = gameManager;
			this.collisionManager = collisionManager;
			this.engineManager = engineManager;
			
			this.destroyableObjects = new LinkedList();
			
			this.player = new Player(engineManager, this, collisionManager);	
			this.middleBottom = engineManager.View.camera.unproject(0, 1, ELEVATION_DIST - engineManager.View.camera.z);
			this.middleTop = engineManager.View.camera.unproject(0, -1, ELEVATION_DIST - engineManager.View.camera.z);
			this.timeUntilNextEnemy = new Date().getTime();
			
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
			
			var now:int = new Date().getTime();
			if (now - timeUntilNextEnemy > ENEMY_CREATE_DELAY) {
				timeUntilNextEnemy = now;
				new Enemy(engineManager, collisionManager, this, middleTop);
			}
		}
		
		public function destroy():void {		
			while (destroyableObjects.size !== 0) {
				(destroyableObjects.first as Destroyable).destroy();
			}
			
			engineManager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function addDestroyable(destroyable:Destroyable):void {
			destroyableObjects.add(destroyable);
		}
		
		public function removeDestroyable(destroyable:Destroyable):void {
			destroyableObjects.remove(destroyable);
		}
		
		public function startLevel1():void {
			level = new Level(
				engineManager, 
				this, 
				middleBottom, 
				ELEVATION_DIST, 
				function(me:LevelManager):Function {
					return function(Elevations:Vector.<LevelBackgroundElevation>):void {
						Elevations.push(new LevelBackgroundElevation(engineManager, me, ResourceManager.loadIsland()));
						Elevations.push(new LevelBackgroundElevation(engineManager, me, ResourceManager.loadIsland()));
					}
				}(this)
			);
		}
		
	}

}