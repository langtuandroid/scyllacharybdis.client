package gui.login 
{
	import components.ScriptComponent;
	
	import flash.events.Event;
    import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoginBoxScriptComponent extends ScriptComponent 
	{
		
		public function LoginBoxScriptComponent() 
		{
			super();
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
			
			trace("User: " + renderable.username + "\nPass: " + renderable.password);
			
            renderable.loginButton.removeEventListener(MouseEvent.CLICK, submitLogin);
        }
		
	}

}