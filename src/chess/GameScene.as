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
		
		public function GameScene() 
		{
			super();
			
		}
		
		public override function awake():void
		{
			_board = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_board.addComponent( BoardScriptComponent, [EventManager]);
			_board.addComponent( BoardRenderComponent );
		}
		
		public override function destroy():void
		{
			MemoryManager.destroy( _board );
			
			_board = null;
		}
		
		public override function show():void
		{
			_board.enabled = true;
		}
		
		public override function hide():void
		{
			_board.enabled = false;
		}
		
		
		
	}

}