package com.makemultimedia.away3d.Interface 
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
	}

}