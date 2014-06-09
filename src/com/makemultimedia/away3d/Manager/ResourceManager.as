package com.makemultimedia.away3d.Manager 
{
	import away3d.events.AssetEvent;
	import away3d.extrusions.Elevation;
	import away3d.extrusions.SkinExtrude;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import away3d.utils.Cast;
	import flash.display.BitmapData;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class ResourceManager 
	{
		/**
		 * http://opengameart.org/content/explosion
		 */
		[Embed(source="media/explosion.png")]
		public static var Explosion:Class;
		
		/**
		 * http://3drt.com/store/free-downloads/
		 */
		[Embed(source="media/SpaceFighter01.3ds", mimeType="application/octet-stream")]
		public static var SpaceFighter01Model:Class;
		
		/**
		 * http://3drt.com/store/free-downloads/
		 */
		[Embed(source="media/F01_512.jpg")]
		public static var SpaceFighter01Texture:Class;
		
		/**
		 * http://3drt.com/store/free-downloads/
		 */
		[Embed(source="media/Shuttle01.3ds", mimeType="application/octet-stream")]
		public static var Shuttle01Model:Class;
		
		/**
		 * http://3drt.com/store/free-downloads/
		 */
		[Embed(source="media/S01_512.jpg")]
		public static var Shuttle01Texture:Class;
		
		/**
		 * http://www.toymaker.info/html/texgen.html
		 */
		[Embed(source="media/island_texture.jpg")]
		public static var IslandTexture:Class;
		
		/**
		 * http://www.toymaker.info/html/texgen.html
		 */
		[Embed(source="media/island_height.gif")]
		public static var IslandHeight:Class;
		
		[Embed(source = "media/DeathFlash.mp3")]
		public static var ExplosionSound:Class;
		
		public function ResourceManager() 
		{
			
		}
		
		public static function loadSpaceFighter01(loadedCallback:Function):Loader3D  {
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext();
			assetLoaderContext.mapUrlToData("F01_512.JPG", new SpaceFighter01Texture());
			var loader:Loader3D = new Loader3D();
			loader.rotationX = -90;
			loader.scale(0.2);
			loader.addEventListener(AssetEvent.MESH_COMPLETE, loadedCallback);
			loader.loadData(new SpaceFighter01Model(), assetLoaderContext, null, new Max3DSParser(false));
			return loader;
		}
		
		public static function loadShuttle01(loadedCallback:Function):Loader3D  {
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext();
			assetLoaderContext.mapUrlToData("S01_512.JPG", new Shuttle01Texture());
			var loader:Loader3D = new Loader3D();
			loader.rotationX = -90;
			loader.scale(0.2);
			loader.addEventListener(AssetEvent.MESH_COMPLETE, loadedCallback);
			loader.loadData(new Shuttle01Model(), assetLoaderContext, null, new Max3DSParser(false));			
			return loader;
		}
		
		public static function loadIsland():Elevation {		
			var heightmap:BitmapData = Cast.bitmapData(IslandHeight);
			 
			// create the material to be applied to the terrain
			var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(IslandTexture));
			 
			// create an Elevation instance
			var elevation:Elevation = new Elevation(material, heightmap, 1000, 100, 2000);
			
			elevation.rotationX = -90;				
			 
			return elevation;
		}
		
		public static function loadExplosion():Sound {
			return new ExplosionSound() as Sound;			
		}
	}
}