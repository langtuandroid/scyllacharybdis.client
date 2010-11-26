package chess 
{
	import core.GameObject;
	import core.SceneObject;
	import core.MemoryManager;
	import core.EventManager;
	import gui.login.*;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoginScene extends SceneObject 
	{
		private var _loginBox:GameObject;
		
		public function LoginScene() 
		{
			
		}
		
		public override function awake():void
		{
			_loginBox = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_loginBox.addComponent(LoginBoxScriptComponent, LoginBoxScriptComponent.dependencies);
			_loginBox.addComponent(LoginBoxRenderComponent);
		}
		
		public override function destroy():void
		{
			MemoryManager.destroy( _loginBox );
			_loginBox = null;
		}
		
		public override function show():void
		{
			_loginBox.enabled = true;
		}
		
		public override function hide():void
		{
			_loginBox.enabled = false;
		}
		
	}

}