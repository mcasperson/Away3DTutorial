package com.makemultimedia.away3d.Manager 
{
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.GameElement.Enemy;
	import org.as3commons.collections.LinkedList;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class DestroyableManager implements Destroyable
	{		
		private var destroyableObjects:LinkedList;
		
		public function DestroyableManager() 
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