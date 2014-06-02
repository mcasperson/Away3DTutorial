package com.makemultimedia.away3d.Manager 
{
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.GameElement.Enemy;
	import org.as3commons.collections.LinkedList;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class EnemyManager implements Destroyable
	{		
		private var enemies:LinkedList;
		
		public function EnemyManager() 
		{
			this.enemies = new LinkedList();
		}
		
		public function addEnemy(enemy:Enemy):void {
			enemies.add(enemy);
		}
		
		public function removeEnemy(enemy:Enemy):void {
			enemies.remove(enemy);
		}
		
		public function destroy():void {
			while (enemies.size !== 0) {
				(enemies.first as Enemy).destroy();
			}
		}
	}

}