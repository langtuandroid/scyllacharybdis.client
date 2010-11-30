package gui.login 
{
	import components.ScriptComponent;
	import core.EventManager;
	import flash.events.Event;
    import flash.events.MouseEvent;
	import models.LoginModel;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoginBoxScriptComponent extends ScriptComponent 
	{
		private var _eventManager:EventManager = null;
		
		public static function get dependencies():Array { return [EventManager]; }
		
		public function LoginBoxScriptComponent() 
		{
			super();
		}
		
		public override function awake():void
		{
			_eventManager = getDependency(EventManager);
		}
		
		public function textEntered(e:Event):void 
		{
			var renderable:LoginBoxRenderComponent = owner.getComponent( RENDER_COMPONENT );
			
            if ( renderable.username != "" && renderable.password != "") 
			{
                renderable.loginButton.enabled = true;
            }
            else 
			{
                renderable.loginButton.enabled = false;    
            }
        }
		
        public function submitLogin(e:MouseEvent):void 
		{
            var renderable:LoginBoxRenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			var user:String = renderable.username;
			var pass:String = renderable.password;
			
			_eventManager.fireEvent("NETWORK_LOGIN", new LoginModel( user, pass, LoginModel.USER_LOGIN ) );
			
            renderable.loginButton.removeEventListener(MouseEvent.CLICK, submitLogin);
        }
		
	}

}