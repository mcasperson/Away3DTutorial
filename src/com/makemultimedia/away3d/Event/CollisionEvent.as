package com.makemultimedia.away3d.Event 
{
	import com.makemultimedia.away3d.Interface.Collider;
	import flash.events.Event;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class CollisionEvent extends Event
	{
		public static const COLLISION_EVENT:String = "CollisionEvent";
		private var collider1:Collider;
		private var collider2:Collider;
		
		public function get Collider1():Collider {
			return collider1;
		}
		
		public function get Collider2():Collider {
			return collider2;
		}
		
		public function CollisionEvent(collider1:Collider, collider2:Collider) 
		{
			super(COLLISION_EVENT);
			this.collider1 = collider1;
			this.collider2 = collider2;
		}
		
		//always override clone method in custom events
        public override function clone():Event
        {
            return new CollisionEvent(collider1, collider2);
        }
		
		public function involves(collider:Collider):Boolean {
			return collider1 === collider || collider2 === collider;
		}
		
	}

}