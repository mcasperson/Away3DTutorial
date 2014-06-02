package com.makemultimedia.away3d.GameElement 
{
	import away3d.animators.nodes.SpriteSheetClipNode;
	import away3d.animators.SpriteSheetAnimationSet;
	import away3d.animators.SpriteSheetAnimator;
	import away3d.entities.Mesh;
	import away3d.events.AnimatorEvent;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.tools.helpers.SpriteSheetHelper;
	import away3d.utils.Cast;
	import com.makemultimedia.away3d.Destroyable;
	import com.makemultimedia.away3d.Manager.EngineManager;
	import com.makemultimedia.away3d.Manager.LevelManager;
	import com.makemultimedia.away3d.Manager.ResourceManager;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Matthew Casperson
	 */
	public class Explosion implements Destroyable
	{
		
		private var engineManager:EngineManager;
		private var levelManager:LevelManager;
		private var mesh:Mesh;
		private var spriteSheetAnimator:SpriteSheetAnimator;
		
		public function Explosion(engineManager:EngineManager, levelManager:LevelManager, position:Vector3D) 
		{
			this.engineManager = engineManager;
			this.levelManager = levelManager;
			
			levelManager.addDestroyable(this);
			
			var spriteSheetHelper:SpriteSheetHelper = new SpriteSheetHelper();
			var spriteSheetAnimationSet:SpriteSheetAnimationSet = new SpriteSheetAnimationSet();
			var spriteSheetClipNode:SpriteSheetClipNode = spriteSheetHelper.generateSpriteSheetClipNode("ExplosionAnimation", 4, 4);
			spriteSheetAnimationSet.addAnimation(spriteSheetClipNode);
			spriteSheetAnimator = new SpriteSheetAnimator(spriteSheetAnimationSet);
			
			var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(ResourceManager.Explosion));
			material.alphaBlending = true;
			
			mesh = new Mesh(new PlaneGeometry(175, 175, 1, 1, false), material);
			mesh.position = position;
			
			mesh.animator = spriteSheetAnimator;
			
			spriteSheetAnimator.fps = 16;
			spriteSheetAnimator.play(spriteSheetClipNode.name);
			engineManager.View.scene.addChild(mesh);
			
			spriteSheetAnimator.addEventListener(AnimatorEvent.CYCLE_COMPLETE, animationFinished);
		}
		
		private function animationFinished(event:AnimatorEvent) {
			spriteSheetAnimator.removeEventListener(AnimatorEvent.CYCLE_COMPLETE, animationFinished);
			destroy();
		}
		
		public function destroy():void {
			levelManager.removeDestroyable(this);
			engineManager.View.scene.removeChild(mesh);
		}
		
	}

}