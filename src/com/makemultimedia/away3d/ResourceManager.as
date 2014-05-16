package com.makemultimedia.away3d 
{
	import away3d.extrusions.Elevation;
	import away3d.extrusions.SkinExtrude;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import away3d.utils.Cast;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class ResourceManager 
	{
		[Embed(source="../../../../media/SpaceFighter01.3ds", mimeType="application/octet-stream")]
		public static var SpaceFighter01Model:Class;
		
		[Embed(source="../../../../media/F01_512.jpg")]
		public static var SpaceFighter01Texture:Class;
		
		[Embed(source="../../../../media/island_texture.jpg")]
		public static var IslandTexture:Class;
		
		[Embed(source="../../../../media/island_height.gif")]
		public static var IslandHeight:Class;
		
		public function ResourceManager() 
		{
			
		}
		
		public static function LoadSpaceFighter01():Loader3D  {
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext();
			assetLoaderContext.mapUrlToData("F01_512.JPG", new SpaceFighter01Texture());
			var loader:Loader3D = new Loader3D();
			loader.rotationX = -90;
			loader.scale(0.2);
			loader.loadData(new SpaceFighter01Model(), assetLoaderContext, null, new Max3DSParser(false));
			return loader;
		}
		
		public static function LoadIsland():Elevation {		
			var heightmap:BitmapData = Cast.bitmapData(IslandHeight);
			 
			// create the material to be applied to the terrain
			var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(IslandTexture));
			 
			// create an Elevation instance
			var elevation:Elevation = new Elevation(material, heightmap, 1000, 100, 2000);
			
			elevation.rotationX = -90;				
			 
			return elevation;
		}
	}
}