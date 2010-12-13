package chess 
{
	import core.GameObject;
	import core.SceneObject;
	import core.EventManager;
	import core.MemoryManager;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameScene extends SceneObject 
	{
		private var _board:GameObject;
		
		public override function awake():void
		{
			_board = MemoryManager.instantiate( GameObject );
			_board.addComponent( BoardScriptComponent, [EventManager]);
			_board.addComponent( BoardRenderComponent );
			
		}
		
		public override function start():void
		{
			addToScene( _board );
		}
		
		public override function stop():void
		{
			removeFromScene( _board );
		}
		
		public override function destroy():void
		{
			MemoryManager.destroy( _board );
			
			_board = null;
		}
	
	}
}