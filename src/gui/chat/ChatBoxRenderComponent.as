package gui.chat 
{
	import components.RenderComponent;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import core.MemoryManager;
	import fl.events.ComponentEvent;
	
	/**
	 * ...
	 * @author The Engine Team
	 */
	public class ChatBoxRenderComponent extends RenderComponent
	{
		private var _messageText:TextArea = null;
		private var _inputText:TextInput = null;
		
		public function get messageText():TextArea { return _messageText; }
		public function get inputText():TextInput { return _inputText; }
		
		public function ChatBoxRenderComponent() 
		{
			super();
			
		}
		
		public override function awake():void
		{
			_messageText = new TextArea();
			_inputText = new TextInput();
		}
		
		public override function destroy():void
		{
			MemoryManager.destroy( _messageText );
			MemoryManager.destroy( _inputText );
			
			_messageText = null;
			_inputText = null;
		}
		
		public override function start():void
		{
			baseclip.graphics.beginFill( 0xF4AD95 );
			baseclip.graphics.drawRect( 0, 0, 300, 300 );
			baseclip.graphics.endFill();
			
			_messageText.move( 10, 10 );
			_inputText.move( 10, 20 + _messageText.height );
			
			baseclip.addChild( _messageText );
			baseclip.addChild( _inputText );
			
			_inputText.addEventListener( ComponentEvent.ENTER, owner.getComonent( SCRIPT_COMPONENT ).onInputTextEnter, false, 0, true );
		}
		
		public override function stop():void
		{
			baseclip.removeChild( _messageText );
			baseclip.removeChild( _inputText );
			baseclip.graphics.clear();
			
			_inputText.removeEventListener( ComponentEvent.ENTER, owner.getComonent( SCRIPT_COMPONENT ).onInputTextEnter );
		}
		
	}

}