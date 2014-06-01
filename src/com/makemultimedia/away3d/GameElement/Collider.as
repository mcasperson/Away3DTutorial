package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public interface Collider 
	{		
		function get CollisionType():int; 
		function get CollisionSphere():BoundingSphere;
		function Collision(otherCollider:Collider):void;		
	}

}