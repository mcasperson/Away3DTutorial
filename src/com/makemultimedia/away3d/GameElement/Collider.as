package com.makemultimedia.away3d.GameElement 
{
	import away3d.bounds.BoundingSphere;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public interface Collider 
	{		
		function get collisionType():int; 
		function get collisionSphere():BoundingSphere;
		function collision(otherCollider:Collider):void;		
	}

}