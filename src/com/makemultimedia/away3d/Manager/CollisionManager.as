package com.makemultimedia.away3d.Manager 
{
	import away3d.core.base.CompactSubGeometry;
	import away3d.entities.Mesh;
	import away3d.primitives.SphereGeometry;
	import com.makemultimedia.away3d.Event.CollisionEvent;
	import com.makemultimedia.away3d.Interface.Collider;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import org.as3commons.collections.framework.ILinkedListIterator;
	import org.as3commons.collections.LinkedList;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class CollisionManager extends EventDispatcher
	{
		private var engineManager:EngineManager;
		private var collisionMap:Dictionary;
		private var colliders:LinkedList;
		private var debug:Boolean;
		
		public function CollisionManager(engineManager:EngineManager, debug:Boolean = false) {
			this.engineManager = engineManager;
			this.collisionMap =  new Dictionary();
			this.colliders = new LinkedList();
			this.debug = debug;
			engineManager.addEventListener(Event.ENTER_FRAME, onEnterFrame);	
		}	
		
		private function onEnterFrame(event:Event):void
		{			
			var iterator1:ILinkedListIterator = colliders.iterator() as ILinkedListIterator;
			var iterator2:ILinkedListIterator = colliders.iterator() as ILinkedListIterator;
			
			while (iterator1.hasNext()) {
				var collider1:Collider = iterator1.next() as Collider;					
				iterator2.end();
				while (iterator2.hasPrevious()) {
					var collider2:Collider = iterator2.previous() as Collider;
					
					if (collider1 === collider2) {
						break;
					}

					if (collisionMap[collider1.collisionType].indexOf(collider2.collisionType) !== -1) {
						if (collider1.collisionSphere.overlaps(collider2.collisionSphere)) {
							this.dispatchEvent(new CollisionEvent(collider1, collider2));
						}
					}
				}
			}
		}
		
		public function mapCollision(collider1:int, collider2:int):void {
			if (collisionMap[collider1] === undefined) {
				collisionMap[collider1] = new Vector.<int>();
			}
			
			if (collisionMap[collider2] === undefined) {
				collisionMap[collider2] = new Vector.<int>();
			}
			
			if (collisionMap[collider1].indexOf(collider2) === -1) {
				collisionMap[collider1].push(collider2);
			}
			
			if (collisionMap[collider2].indexOf(collider1) === -1) {
				collisionMap[collider2].push(collider1);
			}
		}
		
		public function addCollider(collider:Collider):void {
			colliders.add(collider);
			if (debug) {
				engineManager.View.scene.addChild(collider.collisionSphere.boundingRenderable);
			}
		}
		
		public function removeCollider(collider:Collider):void {
			colliders.remove(collider);
			if (debug) {
				engineManager.View.scene.removeChild(collider.collisionSphere.boundingRenderable);
			}
		}
	}

}