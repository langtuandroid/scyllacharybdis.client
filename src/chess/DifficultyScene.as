package chess 
{
	import core.EventManager;
	import core.GameObject;
	import core.MemoryManager;
	import core.SceneObject;
	import gui.difficulty.DifficultyMenuRenderComponent;
	import gui.difficulty.DifficultyMenuScriptComponent;
	
	/**
	 * ...
	 * @author 
	 */
	public class DifficultyScene extends SceneObject 
	{
		private var _difficultyMenu:GameObject;
		
		public override function awake():void
		{
			_difficultyMenu = MemoryManager.instantiate( GameObject );
			_difficultyMenu.addComponent(DifficultyMenuScriptComponent, [EventManager]);
			_difficultyMenu.addComponent(DifficultyMenuRenderComponent);
		}
		
		public override function start():void
		{
			addToScene( _difficultyMenu );
		}
		
		public override function stop():void
		{
			removeFromScene( _difficultyMenu );
		}
		
		
		public override function destroy():void
		{
			MemoryManager.destroy( _difficultyMenu );
			_difficultyMenu = null;
		}
	}

}