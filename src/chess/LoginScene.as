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
		
		public override function show():void
		{
			_loginBox = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_loginBox.addComponent(LoginBoxScriptComponent, [EventManager]);
			_loginBox.addComponent(LoginBoxRenderComponent);
			
			_loginBox.enabled = true;
		}
		
	}

}