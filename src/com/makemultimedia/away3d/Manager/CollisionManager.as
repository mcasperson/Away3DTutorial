package com.makemultimedia.away3d.Manager 
{
	import com.makemultimedia.away3d.GameElement.Collider;
	import flash.utils.Dictionary;
	import org.as3commons.collections.LinkedList;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class CollisionManager 
	{
		private var collisionMap:Dictionary = new Dictionary();
		private var colliders:LinkedList = new LinkedList();
		
		public function CollisionManager() 
		{
			
		}	
		
		public function AddCollider(collider:Collider):void {
			colliders.push(collider);
		}
		
		public function RemoveCollider(collider:Collider):void {
			colliders.remove(collider);
		}
	}

}