package gui.login 
{
	import components.RenderComponent;
	
	import fl.controls.TextInput;
    import fl.controls.Label;
    import fl.controls.Button;
	
	import flash.events.Event;
    import flash.events.MouseEvent;
    
	/**
	 * ...
	 * @author 
	 */
	public class LoginBoxRenderComponent extends RenderComponent 
	{
		private var _userInput:TextInput;
        private var _passInput:TextInput;
        private var _userLabel:Label;
        private var _passLabel:Label;
        private var _loginButton:Button;
		
		public function get username():String { return _userInput.text; }
		public function get password():String { return _passInput.text; }
		public function get loginButton():Button { return _loginButton; }
		
		public function LoginBoxRenderComponent() 
		{
			super();
		}
		
		public override function start():void
		{
			drawBackground();
			setupLabels();
            setupInputFields();    
            setupButton();
		}
		
		private function drawBackground():void
		{
			baseclip.graphics.beginFill( 0xF4AD95 );
			baseclip.graphics.drawRect( 0, 0, 200, 100 );
			baseclip.graphics.endFill();
		}
		
		private function setupInputFields():void 
		{
            _userInput = new TextInput();
            _passInput = new TextInput();
            
			_userInput.move(50,10);
            _passInput.move(50,40);
            
			_passInput.displayAsPassword = true;
            
			_userInput.addEventListener(Event.CHANGE, owner.getComponent( SCRIPT_COMPONENT ).textEntered);
            _passInput.addEventListener(Event.CHANGE, owner.getComponent( SCRIPT_COMPONENT ).textEntered);
            
			baseclip.addChild(_userInput);
            baseclip.addChild(_passInput);
        }
		
        private function setupLabels():void 
		{    
			_userLabel = new Label();
            _passLabel = new Label();
            
			_userLabel.move(10,10);
            _passLabel.move(10,40);
            
			_userLabel.text = "User:";
            _passLabel.text = "Pass:"
            
			baseclip.addChild(_userLabel);
            baseclip.addChild(_passLabel);
        }
		
        private function setupButton():void 
		{
            _loginButton = new Button();
            
			_loginButton.move(150,70);
            _loginButton.setSize(50, 20);
			
			_loginButton.label = "Login";
            
			_loginButton.enabled = false;
            
            _loginButton.addEventListener(MouseEvent.CLICK, owner.getComponent( SCRIPT_COMPONENT ).submitLogin);
            
			baseclip.addChild(_loginButton);
        }
		
	}

}