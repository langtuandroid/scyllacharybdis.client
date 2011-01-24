package chess 
{
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.objects.SceneObject;
	import gui.login.*;
	
	/**
	 */
	public class LoginScene extends SceneObject 
	{
		private var _loginBox:GameObject;
		
		public override function awake():void
		{
			_loginBox = MemoryManager.instantiate( GameObject );
			_loginBox.addComponent(LoginBoxScriptComponent);
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
