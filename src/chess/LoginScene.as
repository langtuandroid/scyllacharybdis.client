package chess 
{
	import core.GameObject;
	import core.SceneObject;
	import core.MemoryManager;
	import core.EventManager;
	import gui.login.*;
	
	/**
	 */
	public class LoginScene extends SceneObject 
	{
		private var _loginBox:GameObject;
		
		public override function awake():void
		{
			_loginBox = MemoryManager.instantiate( GameObject );
			_loginBox.addComponent(LoginBoxScriptComponent, LoginBoxScriptComponent.dependencies);
			_loginBox.addComponent(LoginBoxRenderComponent);
		}
		
		public override function start():void
		{
			addToScene( _loginBox );
		}
		
		public override function stop():void
		{
			removeFromScene( _loginBox );
		}
		
		
		public override function destroy():void
		{
			MemoryManager.destroy( _loginBox );
			_loginBox = null;
		}
	}
}
